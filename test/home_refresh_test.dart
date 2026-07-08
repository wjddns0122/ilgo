// Regression test: popping back to home (결과 화면 → 홈) must reload
// "최근 기록". HomeController is a permanent singleton, so without the
// routingCallback hook the list would only load once in onInit.

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ilgo/core/app_routes.dart';
import 'package:ilgo/data/models/analysis.dart';
import 'package:ilgo/data/models/analysis_summary.dart';
import 'package:ilgo/data/models/enums.dart';
import 'package:ilgo/data/models/reply_draft.dart';
import 'package:ilgo/data/repositories/analysis_repository.dart';
import 'package:ilgo/data/services/profile_service.dart';
import 'package:ilgo/modules/home/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeRepo implements AnalysisRepository {
  int listCalls = 0;

  @override
  Future<List<AnalysisSummary>> list({String? cursor}) async {
    listCalls++;
    return const [];
  }

  @override
  Future<Analysis> analyze({
    required Uint8List imageBytes,
    required String mediaType,
    required OutputMode mode,
    required String lang,
    String? hint,
  }) =>
      throw UnimplementedError();

  @override
  Future<Analysis> getById(String id) => throw UnimplementedError();

  @override
  Future<void> delete(String id) => throw UnimplementedError();

  @override
  Future<void> toggleAction(String analysisId, String actionId, bool isDone) =>
      throw UnimplementedError();

  @override
  Future<List<ReplyDraft>> regenerateReplies(String analysisId,
          {String? tone}) =>
      throw UnimplementedError();

  @override
  Future<void> feedback(String analysisId,
          {required bool isHelpful, String? reason}) =>
      throw UnimplementedError();
}

void main() {
  tearDown(Get.reset);

  testWidgets('popping back to home reloads 최근 기록', (tester) async {
    // deadline_alarm off → loadRecent skips the in-app alert dialog.
    SharedPreferences.setMockInitialValues({'deadline_alarm': false});
    final repo = _FakeRepo();
    Get.put<AnalysisRepository>(repo);
    await Get.putAsync(() => ProfileService().init());
    Get.put(HomeController());

    await tester.pumpWidget(GetMaterialApp(
      routingCallback: HomeController.onRouting,
      initialRoute: Routes.home,
      getPages: [
        GetPage(
            name: Routes.home,
            page: () => const Scaffold(body: Text('home'))),
        GetPage(
            name: Routes.result,
            page: () => const Scaffold(body: Text('result'))),
      ],
    ));
    await tester.pumpAndSettle();
    final callsAfterInit = repo.listCalls;
    expect(callsAfterInit, greaterThanOrEqualTo(1)); // onInit load

    Get.toNamed(Routes.result); // push must NOT reload
    await tester.pumpAndSettle();
    expect(repo.listCalls, callsAfterInit);

    Get.back(); // pop back to home → reload
    await tester.pumpAndSettle();
    expect(repo.listCalls, callsAfterInit + 1);
  });
}
