import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/services/profile_service.dart';
import '../analyze/analyze_controller.dart';

/// Home: capture / choose an image (or run a bundled sample) and kick off
/// an analysis using the current profile (mode + language).
class HomeController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  ProfileService get _profile => Get.find<ProfileService>();
  AnalyzeController get _analyze => Get.find<AnalyzeController>();

  Future<void> capture() => _pickAndAnalyze(ImageSource.camera);

  Future<void> fromGallery() => _pickAndAnalyze(ImageSource.gallery);

  Future<void> _pickAndAnalyze(ImageSource source) async {
    final picked = await _picker.pickImage(source: source, imageQuality: 90);
    if (picked == null) return; // user cancelled
    final bytes = await _compress(picked);
    await _run(bytes);
  }

  /// Demo path — runs an analysis without a camera (safe on simulators and as
  /// a presentation fallback). Mock ignores bytes; live sends a small image.
  Future<void> runSample() => _run(Uint8List(0));

  Future<void> _run(Uint8List bytes) {
    return _analyze.analyze(
      bytes: bytes,
      mediaType: 'image/jpeg',
      mode: _profile.mode.value,
      lang: _profile.lang.value,
    );
  }

  Future<Uint8List> _compress(XFile file) async {
    try {
      final out = await FlutterImageCompress.compressWithFile(
        file.path,
        minWidth: 1280,
        minHeight: 1280,
        quality: 80,
      );
      if (out != null) return out;
    } catch (_) {
      // fall through to raw bytes
    }
    return file.readAsBytes();
  }
}
