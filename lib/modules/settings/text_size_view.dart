import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../data/services/profile_service.dart';

/// Text-size screen (Figma node 17:1292): live preview + 4-step slider.
/// Applies app-wide via [ProfileService.textScale] (wired in main.dart).
class TextSizeView extends StatefulWidget {
  const TextSizeView({super.key});

  @override
  State<TextSizeView> createState() => _TextSizeViewState();
}

class _TextSizeViewState extends State<TextSizeView> {
  final ProfileService _profile = Get.find<ProfileService>();
  late final List<MapEntry<String, double>> _presets =
      ProfileService.textScalePresets.entries.toList();
  late int _index = _initialIndex();

  int _initialIndex() {
    final i = _presets.indexWhere((e) => e.value == _profile.textScale.value);
    return i < 0 ? 1 : i; // default 보통
  }

  double get _scale => _presets[_index].value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kOnbMaxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.rs(28)),
                      child: Column(
                        children: [
                          SizedBox(height: context.rs(8)),
                          _preview(context),
                          SizedBox(height: context.rs(28)),
                          _slider(context),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      context.rs(28), context.rs(8), context.rs(28), context.rs(24)),
                  child: _confirmButton(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          context.rs(15), context.rs(15), context.rs(28), context.rs(8)),
      child: Row(
        children: [
          SizedBox(
            width: context.rs(22),
            height: context.rs(22),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: context.rs(22),
              icon: const Icon(Icons.arrow_back, color: AppColors.ink),
              onPressed: () => Get.back(),
            ),
          ),
          SizedBox(width: context.rs(16)),
          Text(
            '글씨 크기',
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(18.4),
              fontWeight: FontWeight.w700,
              letterSpacing: -0.184,
              color: AppColors.forest,
            ),
          ),
        ],
      ),
    );
  }

  /// Live preview — text renders at the *candidate* scale via a local
  /// MediaQuery override (independent of the currently-applied setting).
  Widget _preview(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(_scale)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: context.rs(28), vertical: context.rs(28)),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.hairline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '미리보기',
              style: GoogleFonts.notoSansKr(
                  fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.stone),
            ),
            SizedBox(height: context.rs(10)),
            Text(
              '8월 15일까지\n6만 8천 원을 내야 해요.',
              style: GoogleFonts.notoSansKr(
                fontSize: 24,
                height: 1.4,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            SizedBox(height: context.rs(10)),
            Text(
              '건강보험료 고지서예요.',
              style: GoogleFonts.notoSansKr(fontSize: 16, color: AppColors.stone),
            ),
          ],
        ),
      ),
    );
  }

  Widget _slider(BuildContext context) {
    return Column(
      children: [
        // 가 (small) … 가 (big)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('가',
                style: GoogleFonts.notoSansKr(
                    fontSize: context.rs(18), color: AppColors.stone)),
            Text('가',
                style: GoogleFonts.notoSansKr(
                    fontSize: context.rs(32),
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink)),
          ],
        ),
        SizedBox(height: context.rs(8)),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: context.rs(8),
            activeTrackColor: AppColors.forest,
            inactiveTrackColor: AppColors.hairline,
            thumbColor: AppColors.card,
            overlayColor: AppColors.forest.withValues(alpha: 0.12),
            thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: context.rs(14),
                elevation: 2),
            trackShape: const RoundedRectSliderTrackShape(),
          ),
          child: Slider(
            value: _index.toDouble(),
            min: 0,
            max: (_presets.length - 1).toDouble(),
            divisions: _presets.length - 1,
            onChanged: (v) => setState(() => _index = v.round()),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var i = 0; i < _presets.length; i++)
              Text(
                _presets[i].key,
                style: GoogleFonts.notoSansKr(
                  fontSize: context.rs(15),
                  fontWeight: i == _index ? FontWeight.w700 : FontWeight.w600,
                  color: i == _index ? AppColors.forest : AppColors.stone,
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _confirmButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: AppColors.forest,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            await _profile.setTextScale(_scale);
            Get.back();
          },
          child: Container(
            height: context.rs(64),
            alignment: Alignment.center,
            child: Text(
              '이 크기로 할게요',
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(20),
                fontWeight: FontWeight.w700,
                color: AppColors.paper,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
