import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/responsive.dart';
import '../home/home_controller.dart';

/// In-app camera viewfinder (Figma node 17:995): dark screen, gold frame guide,
/// shutter, gallery + auto-detect controls. Captures → analyze.
///
/// No on-device OCR — the photo is sent to the backend where Claude reads it
/// (multimodal). This screen only captures a clear image.
class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

const _gold = Color(0xFFE6C15A);
const _bg = Color(0xFF1A1712);

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  CameraController? _controller;
  bool _initializing = true;
  bool _flashOn = false;
  bool _autoDetect = true;
  bool _busy = false;
  String? _error;

  HomeController get _home => Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setup();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final c = _controller;
    if (c == null || !c.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      c.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _setup();
    }
  }

  Future<void> _setup() async {
    setState(() {
      _initializing = true;
      _error = null;
    });
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() {
          _error = '카메라를 찾을 수 없어요.';
          _initializing = false;
        });
        return;
      }
      final back = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      final controller = CameraController(
        back,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await controller.initialize();
      if (!mounted) {
        controller.dispose();
        return;
      }
      setState(() {
        _controller = controller;
        _initializing = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = '카메라를 열 수 없어요. 권한을 확인하거나 갤러리에서 골라주세요.';
        _initializing = false;
      });
    }
  }

  Future<void> _toggleFlash() async {
    final c = _controller;
    if (c == null || !c.value.isInitialized) return;
    _flashOn = !_flashOn;
    await c.setFlashMode(_flashOn ? FlashMode.torch : FlashMode.off);
    setState(() {});
  }

  Future<void> _capture() async {
    final c = _controller;
    if (c == null || !c.value.isInitialized || _busy) return;
    setState(() => _busy = true);
    try {
      final file = await c.takePicture();
      if (!mounted) return;
      setState(() => _busy = false);
      _home.toConfirm(file); // → confirm screen before analyzing
    } catch (_) {
      if (mounted) setState(() => _busy = false);
      Get.snackbar(
        '오류',
        '사진을 찍지 못했어요. 다시 시도해 주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _previewLayer(context),
          _frameGuide(context),
          SafeArea(
            child: Column(
              children: [
                _topBar(context),
                const Spacer(),
                if (_error == null) _guideText(context),
                SizedBox(height: context.rs(24)),
                _controls(context),
                SizedBox(height: context.rs(16)),
              ],
            ),
          ),
          if (_busy)
            const Positioned.fill(
              child: ColoredBox(
                color: Colors.black45,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _previewLayer(BuildContext context) {
    final c = _controller;
    if (_initializing) {
      return const ColoredBox(
        color: _bg,
        child: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }
    if (c == null || !c.value.isInitialized) {
      return ColoredBox(
        color: _bg,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.rs(40)),
            child: Text(
              _error ?? '카메라를 사용할 수 없어요.',
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(16),
                height: 1.6,
                color: Colors.white70,
              ),
            ),
          ),
        ),
      );
    }
    // Cover-fit the preview to the screen.
    final media = MediaQuery.sizeOf(context);
    var scale = media.aspectRatio * c.value.aspectRatio;
    if (scale < 1) scale = 1 / scale;
    return Transform.scale(
      scale: scale,
      child: Center(child: CameraPreview(c)),
    );
  }

  Widget _topBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.rs(20),
        context.rs(8),
        context.rs(20),
        context.rs(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _circleButton(context, Icons.close, () => Get.back()),
          Text(
            '종이 찍기',
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(21),
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          _circleButton(
            context,
            _flashOn ? Icons.flash_on : Icons.flash_off,
            _toggleFlash,
          ),
        ],
      ),
    );
  }

  Widget _circleButton(
    BuildContext context,
    IconData icon,
    VoidCallback onTap,
  ) {
    final s = context.rs(50);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: s,
        height: s,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: context.rs(24)),
      ),
    );
  }

  Widget _frameGuide(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: context.rs(120)),
        child: FractionallySizedBox(
          widthFactor: 0.72,
          child: AspectRatio(
            aspectRatio: 0.78,
            child: Stack(
              children: [
                _corner(context, top: true, left: true),
                _corner(context, top: true, left: false),
                _corner(context, top: false, left: true),
                _corner(context, top: false, left: false),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _corner(
    BuildContext context, {
    required bool top,
    required bool left,
  }) {
    final w = context.rs(5);
    final side = const BorderSide(color: _gold, width: 5).copyWith(width: w);
    return Positioned(
      top: top ? 0 : null,
      bottom: top ? null : 0,
      left: left ? 0 : null,
      right: left ? null : 0,
      child: SizedBox(
        width: context.rs(44),
        height: context.rs(44),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: top ? side : BorderSide.none,
              bottom: top ? BorderSide.none : side,
              left: left ? side : BorderSide.none,
              right: left ? BorderSide.none : side,
            ),
          ),
        ),
      ),
    );
  }

  Widget _guideText(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.rs(24),
          vertical: context.rs(12),
        ),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          '고지서를 네모 안에 맞춰주세요',
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(19),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _controls(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.rs(48)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _sideButton(
            context,
            label: '갤러리',
            child: Icon(
              Icons.image_outlined,
              color: Colors.white,
              size: context.rs(30),
            ),
            onTap: _home.fromGallery,
          ),
          _shutter(context),
          _sideButton(
            context,
            label: '자동 인식',
            active: _autoDetect,
            child: Text(
              'A',
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(24),
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            onTap: () => setState(() => _autoDetect = !_autoDetect),
          ),
        ],
      ),
    );
  }

  Widget _shutter(BuildContext context) {
    final s = context.rs(84);
    return GestureDetector(
      onTap: _capture,
      child: Container(
        width: s,
        height: s,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFDF7),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.35),
            width: context.rs(6),
          ),
        ),
      ),
    );
  }

  Widget _sideButton(
    BuildContext context, {
    required String label,
    required Widget child,
    required VoidCallback onTap,
    bool active = false,
  }) {
    final s = context.rs(60);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: s,
            height: s,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(context.rs(14)),
            ),
            child: child,
          ),
          SizedBox(height: context.rs(8)),
          Opacity(
            opacity: 0.85,
            child: Text(
              label,
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(13),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
