import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/app_routes.dart';
import '../../core/deadline.dart';
import '../../data/models/analysis_summary.dart';
import '../../data/repositories/analysis_repository.dart';
import '../../data/services/profile_service.dart';
import '../analyze/analyze_controller.dart';
import 'deadline_alert_dialog.dart';

/// Home: capture / choose an image and kick off an analysis using the current
/// profile (mode + language). Also surfaces the most recent saved analyses
/// ("최근 기록").
class HomeController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  ProfileService get _profile => Get.find<ProfileService>();
  AnalyzeController get _analyze => Get.find<AnalyzeController>();
  AnalysisRepository get _repo => Get.find<AnalysisRepository>();

  /// Recent saved analyses shown at the bottom of home.
  final recent = <AnalysisSummary>[].obs;

  /// In-app "기한 알림" fires once per app session, not on every home visit.
  static bool _deadlineAlertShown = false;

  @override
  void onInit() {
    super.onInit();
    loadRecent();
  }

  Future<void> loadRecent() async {
    try {
      final items = await _repo.list();
      recent.assignAll(items.take(5).toList());
      _maybeShowDeadlineAlert(items);
    } catch (_) {
      recent.clear();
    }
  }

  /// In-app alert (설정 '기한 알림'): anything due within 7 days pops a
  /// dialog listing the closest deadlines first.
  void _maybeShowDeadlineAlert(List<AnalysisSummary> items) {
    if (_deadlineAlertShown || !_profile.deadlineAlarm.value) return;
    final upcoming = items
        .where((e) => Deadline.isUrgent(e.cardDeadline))
        .toList()
      ..sort((a, b) => (Deadline.daysLeft(a.cardDeadline) ?? 99)
          .compareTo(Deadline.daysLeft(b.cardDeadline) ?? 99));
    if (upcoming.isEmpty) return;
    _deadlineAlertShown = true;
    // Let the home screen settle before covering it with a dialog.
    Future.delayed(const Duration(milliseconds: 500), () {
      if (Get.isDialogOpen ?? false) return;
      Get.dialog(
        DeadlineAlertDialog(
          items: upcoming.take(3).toList(),
          onOpen: (id) {
            Get.back(); // close the dialog first
            openRecord(id);
          },
        ),
      );
    });
  }

  /// Open a recent record on the result screen.
  Future<void> openRecord(String id) async {
    try {
      _analyze.openSaved(await _repo.getById(id));
    } catch (_) {
      Get.snackbar('오류', '내용을 불러오지 못했어요.');
    }
  }

  Future<void> capture() => _pickAndAnalyze(ImageSource.camera);

  /// Pick from gallery, then show the capture-confirm screen before analyzing.
  Future<void> fromGallery() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    toConfirm(picked);
  }

  /// Open the "이 사진으로 읽어드릴까요?" confirm screen with [file].
  void toConfirm(XFile file) =>
      Get.toNamed(Routes.confirmCapture, arguments: file);

  /// Analyze a confirmed photo (from camera or gallery).
  Future<void> analyzeXFile(XFile file) async {
    final bytes = await _compress(file);
    await _run(bytes);
  }

  Future<void> _pickAndAnalyze(ImageSource source) async {
    // No `imageQuality` → skip image_picker_ios's background re-encode, which
    // can raise an uncatchable "Data cannot be nil" NSException. We compress
    // ourselves from validated bytes instead.
    final picked = await _picker.pickImage(source: source);
    if (picked == null) return; // user cancelled
    final bytes = await _compress(picked);
    await _run(bytes);
  }

  Future<void> _run(Uint8List bytes) {
    return _analyze.analyze(
      bytes: bytes,
      mediaType: 'image/jpeg',
      mode: _profile.mode.value,
      lang: _profile.lang.value,
    );
  }

  Future<Uint8List> _compress(XFile file) async {
    // Read bytes in Dart first (safe), then compress from the validated list.
    // Avoids compressWithFile's native file read, which can crash on nil data.
    final raw = await file.readAsBytes();
    if (raw.isEmpty) return raw;
    try {
      final out = await FlutterImageCompress.compressWithList(
        raw,
        minWidth: 1280,
        minHeight: 1280,
        quality: 80,
      );
      if (out.isNotEmpty) return out;
    } catch (_) {
      // fall through to raw bytes
    }
    return raw;
  }
}
