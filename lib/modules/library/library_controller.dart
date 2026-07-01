import 'package:get/get.dart';

import '../../data/models/analysis_summary.dart';
import '../../data/repositories/analysis_repository.dart';
import '../analyze/analyze_controller.dart';

/// Library: list of saved analyses. Tapping a row loads its full detail.
class LibraryController extends GetxController {
  LibraryController(this._repo);

  final AnalysisRepository _repo;

  final isLoading = false.obs;
  final items = <AnalysisSummary>[].obs;
  final error = RxnString();

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    error.value = null;
    try {
      items.value = await _repo.list();
    } catch (_) {
      error.value = '목록을 불러오지 못했어요.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> open(String id) async {
    try {
      final analysis = await _repo.getById(id);
      Get.find<AnalyzeController>().openSaved(analysis);
    } catch (_) {
      Get.snackbar('오류', '내용을 불러오지 못했어요.');
    }
  }

  Future<void> remove(String id) async {
    await _repo.delete(id);
    items.removeWhere((e) => e.id == id);
  }
}
