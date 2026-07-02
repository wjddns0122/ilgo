# 읽고 (Ilgo) — Flutter 기술 스택

| 항목 | 내용 |
|---|---|
| 문서 버전 | v2.0 (경량화) |
| 작성일 | 2026-06-30 |
| 대상 | 프론트(Flutter) 개발자 — 본인 |
| 원칙 | 무박 2일 · 1인 · **작게** · 목데이터로 먼저 완성 → 실데이터 스왑 |
| 동반 | `읽고_프론트_API명세.md`, `읽고_백엔드_API명세_ERD.md` |

> v1 대비 변경: 상태관리 Riverpod→**GetX**, 라우팅 go_router 제거(GetX가 흡수), 모델 **freezed** 추가, 네트워크 dio→**dio+retrofit**, 디자인 **Figma MCP**.

---

## 1. 스택 결정 (한눈에)

| 영역 | 선택 | 이유 |
|---|---|---|
| SDK | **Flutter 3.x / Dart 3.x** | 단일 코드로 Android(데모)·iOS |
| **상태관리+라우팅+DI** | **GetX** (`get`) | 상태·라우팅·의존성 주입을 한 패키지로 → 해커톤에 최소 스택. `Obx`+`.obs`로 간단 |
| 디자인 핸드오프 | **Figma + Figma MCP** | 디자이너 시안에서 색·스타일·스크린샷을 MCP로 뽑아 그대로 구현 |
| 네트워크 | **dio + retrofit** | dio(인터셉터·타임아웃) + retrofit로 **API 클라이언트 자동 생성** |
| 모델/직렬화 | **freezed + json_serializable** | 불변 모델·copyWith·fromJson 자동. 목/실 파서 1개 |
| 이미지 입력 | **image_picker** | 카메라/갤러리 |
| 이미지 압축 | **flutter_image_compress** | 업로드 속도·비용(1280px) |
| 음성(TTS) | **flutter_tts** | 쉬운 모드 낭독 |
| 캘린더 | **add_2_calendar** | 기한 등록 |
| 복사/공유 | `flutter/services`(Clipboard) + **share_plus** | 답장 복사 |
| 전화 | **url_launcher** | tel: |
| 로컬 저장 | **shared_preferences** | 프로필(모드/언어)·기기 ID *(GetX 쓰면 get_storage도 대안)* |
| 폰트 | **google_fonts** | Noto Sans KR(큰 가독성) + 영어 |
| 설정/시크릿 | `--dart-define` | `BASE_URL`, `USE_MOCK` |

> **제거:** `flutter_riverpod`, `go_router` (GetX가 상태+라우팅+DI 모두 커버 → 의존성·학습량 감소).

---

## 2. 아키텍처 (GetX + Repository 스왑)

```
View (GetView<Controller> + Obx)
      │  controller.xxx.value 관찰
      ▼
Controller (GetxController, Rx 상태)
      │  호출
      ▼
Repository (인터페이스)
   ├── MockAnalysisRepository   (assets/mock/*.json)  ← 지금
   └── ApiAnalysisRepository    (retrofit IlgoApi→dio) ← 나중
      ▲
      │  Bindings에서 USE_MOCK로 주입 선택
```
- **View는 Repository 인터페이스에만 의존.** 목↔실 전환은 Bindings 한 줄(`USE_MOCK`).
- 분석 상태는 Controller의 `Rx`로: `isLoading`, `result`, `error`.

### 폴더 구조 (가볍게)
```
lib/
  main.dart                 # GetMaterialApp + 초기 Binding
  core/
    config.dart             # BASE_URL, USE_MOCK
    dio_client.dart         # dio + X-Device-Id 인터셉터
    theme.dart              # 큰 글씨·고대비 토큰 (Figma 변수 반영)
    app_pages.dart          # GetPage 라우트 목록
  data/
    models/                 # freezed: analysis, risk, action, reply_draft
    api/
      ilgo_api.dart         # retrofit @RestApi
    repositories/
      analysis_repository.dart       # 인터페이스
      mock_analysis_repository.dart  # 목
      api_analysis_repository.dart   # 실
    bindings/app_binding.dart        # 의존성 주입(USE_MOCK 분기)
  modules/
    onboarding/ home/ analyze/ reply/ library/ settings/
      *_controller.dart + *_view.dart
  widgets/                  # 신호등 배너, 카드, 원문↔풀이 토글 등 공용
assets/
  mock/                     # API 명세의 예시 JSON
```

---

## 3. 상태관리 패턴 (GetX)

```dart
// analyze_controller.dart
class AnalyzeController extends GetxController {
  AnalyzeController(this._repo);
  final AnalysisRepository _repo;

  final isLoading = false.obs;
  final result = Rxn<Analysis>();
  final error = RxnString();

  Future<void> run(Uint8List bytes, String mediaType, OutputMode mode, String lang) async {
    isLoading.value = true;
    error.value = null;
    try {
      result.value = await _repo.analyze(
        imageBytes: bytes, mediaType: mediaType, mode: mode, lang: lang);
      Get.toNamed('/result');
    } catch (e) {
      error.value = '분석에 실패했어요. 다시 시도해 주세요.'; // + 폴백 캐시
    } finally {
      isLoading.value = false;
    }
  }
}
```
```dart
// analyze_view.dart — 로딩/결과/에러 자동 분기
Obx(() {
  final c = controller;
  if (c.isLoading.value) return const AnalyzingView();     // "AI가 읽고 있어요"
  if (c.error.value != null) return ErrorView(onRetry: ...);
  final a = c.result.value;
  return a == null ? const HomeView() : ResultView(a);
});
```

---

## 4. 모델 (freezed + json_serializable)

```dart
@freezed
class Analysis with _$Analysis {
  const factory Analysis({
    required String id,
    required String status,                       // done|processing|failed
    @JsonKey(name: 'output_mode') required String outputMode,
    required String lang,
    @JsonKey(name: 'doc_type') String? docType,
    @JsonKey(name: 'summary_one_line') String? summaryOneLine,
    @JsonKey(name: 'original_text') String? originalText,
    @JsonKey(name: 'explained_text') String? explainedText,
    String? consequence,
    Cards? cards,
    @Default(<Risk>[]) List<Risk> risks,
    @Default(<ActionItem>[]) List<ActionItem> actions,
    @JsonKey(name: 'reply_drafts') @Default(<ReplyDraft>[]) List<ReplyDraft> replyDrafts,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _Analysis;
  factory Analysis.fromJson(Map<String, dynamic> j) => _$AnalysisFromJson(j);
}

@freezed
class Risk with _$Risk {
  const factory Risk({required String id, required String level,
      required String type, required String message}) = _Risk;
  factory Risk.fromJson(Map<String, dynamic> j) => _$RiskFromJson(j);
}
// ActionItem(id,text,priority,isDone), ReplyDraft(id,korean,noteInLang), Cards(what,when,where,amount,deadline) 동일 패턴
```
- 목 JSON = 실 응답 **동일 스키마** → 파서 1개로 양쪽 커버.

---

## 5. 네트워크 (dio + retrofit)

```dart
// ilgo_api.dart — retrofit이 구현 생성
@RestApi()
abstract class IlgoApi {
  factory IlgoApi(Dio dio, {String baseUrl}) = _IlgoApi;

  @POST('/analyses')
  Future<Analysis> analyze(@Body() AnalyzeRequest body);

  @GET('/analyses')
  Future<AnalysisListResponse> list(@Query('cursor') String? cursor);

  @GET('/analyses/{id}')
  Future<Analysis> getById(@Path('id') String id);

  @DELETE('/analyses/{id}')
  Future<void> delete(@Path('id') String id);
}
```
```dart
// dio_client.dart
Dio buildDio() {
  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 30),
  ));
  dio.interceptors.add(InterceptorsWrapper(onRequest: (o, h) async {
    o.headers['X-Device-Id'] = await DeviceId.get(); // shared_preferences
    h.next(o);
  }));
  return dio;
}
```
```dart
// app_binding.dart — 목↔실 스왑
class AppBinding extends Bindings {
  @override
  void dependencies() {
    if (Config.useMock) {
      Get.lazyPut<AnalysisRepository>(() => MockAnalysisRepository());
    } else {
      final api = IlgoApi(buildDio(), baseUrl: Config.baseUrl);
      Get.lazyPut<AnalysisRepository>(() => ApiAnalysisRepository(api));
    }
  }
}
```
```dart
// config.dart
class Config {
  static const useMock = bool.fromEnvironment('USE_MOCK', defaultValue: true);
  static const baseUrl = String.fromEnvironment('BASE_URL', defaultValue: '');
}
```

---

## 6. 디자인 핸드오프 (Figma MCP)

- 디자이너가 Figma로 화면·컴포넌트·색 변수를 만들면, **Figma MCP**로 개발이 직접 끌어온다.
- 활용: **색/타이포 변수 → `theme.dart`**, **컴포넌트 스크린샷 → 위젯 구현 기준**, 스펙(간격·크기) 확인.
- 워크플로: Figma에서 프레임 선택 → MCP로 디자인 컨텍스트/스크린샷/변수 조회 → 큰 글씨·고대비 토큰을 `theme.dart`에 반영.
- 접근성 토큰(본문 18sp+, 핵심 24sp+, 신호등 🟢🟡🔴 색, 터치 48dp+)을 Figma 변수로 정의해 코드와 1:1 매칭.

---

## 7. pubspec 의존성 (초안)

```yaml
dependencies:
  get: ^4.6.6
  dio: ^5.7.0
  retrofit: ^4.4.1
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0
  image_picker: ^1.1.2
  flutter_image_compress: ^2.3.0
  flutter_tts: ^4.0.2
  add_2_calendar: ^3.0.1
  url_launcher: ^6.3.0
  share_plus: ^10.0.0
  shared_preferences: ^2.3.2
  google_fonts: ^6.2.1

dev_dependencies:
  build_runner: ^2.4.11
  retrofit_generator: ^9.1.2
  freezed: ^2.5.7
  json_serializable: ^6.8.0
  flutter_lints: ^4.0.0
```
> 버전은 착수 시 `flutter pub outdated`로 최신 안정판 확인. 핵심은 조합.

---

## 8. 초기 셋업 (착수 커맨드)

```bash
flutter create ilgo && cd ilgo
flutter pub add get dio retrofit freezed_annotation json_annotation \
  image_picker flutter_image_compress flutter_tts add_2_calendar \
  url_launcher share_plus shared_preferences google_fonts
flutter pub add -d build_runner retrofit_generator freezed json_serializable
# 모델 + retrofit 코드 생성
dart run build_runner build --delete-conflicting-outputs
# 목으로 실행(기본)
flutter run --dart-define=USE_MOCK=true
# 실서버로 실행
flutter run --dart-define=USE_MOCK=false --dart-define=BASE_URL=https://ilgo-api.up.railway.app/v1
```
- `main.dart`는 `GetMaterialApp(initialBinding: AppBinding(), getPages: AppPages.routes)`.
- **권한:** 카메라(image_picker), 캘린더 쓰기(add_2_calendar) → Android `AndroidManifest.xml`, iOS `Info.plist` 사유 문구.

---

## 9. 기능별 패키지 매핑

| 기능(FR) | 패키지 |
|---|---|
| 사진 촬영/선택 | image_picker |
| 이미지 압축 | flutter_image_compress |
| 분석 호출 | retrofit+dio (실) / rootBundle (목) |
| 상태·화면전환·DI | GetX |
| 원문↔풀이 토글 / 신호등 | 순수 위젯 + 색 토큰(Figma) |
| 할 일 체크 | GetX Rx / (실)PATCH |
| 캘린더 등록 | add_2_calendar |
| 답장 복사 | Clipboard(services) |
| 음성 낭독 | flutter_tts |
| 전화 | url_launcher |
| 보관함 저장 | shared_preferences |
| 폰트 | google_fonts |

---

## 10. 2일 빌드와 스택 매핑

| 구간 | 할 일 | 쓰는 것 |
|---|---|---|
| Day0 저녁 | 프로젝트·패키지·freezed 모델 생성, 목 JSON | flutter create, build_runner, assets/mock |
| Day1 오전 | Repository(목) + AnalyzeController + 홈/로딩 | GetX, image_picker |
| Day1 오후 | 결과 화면(요약/토글/카드/신호등/할일) | 순수 위젯 + theme(Figma) |
| Day1 밤 | 답장(native)·TTS·캘린더·보관함 | flutter_tts, add_2_calendar, shared_preferences |
| Day2 오전 | 온보딩/설정, 에러·폴백, 접근성 | GetX 라우팅, google_fonts |
| Day2 오후 | **실서버 스왑**(retrofit) + 리허설 | dio+retrofit, `USE_MOCK=false` |

> **핵심:** 목으로 화면 100% 완성 → 백엔드 나오면 Bindings에서 `USE_MOCK=false` 한 줄로 붙인다. 백엔드 늦어도 목으로 데모 가능(=발표 안전망).

---

*Flutter 기술 스택 v2.0(경량) · 제품 "읽고" · **GetX + dio/retrofit + freezed + Figma MCP** · 목→실 Repository 스왑 · 동반: `읽고_프론트_API명세.md`.*
