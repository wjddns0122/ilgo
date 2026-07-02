# 읽고 (Ilgo) — 모바일(프론트) API 명세 & 목데이터

| 항목 | 내용 |
|---|---|
| 문서 버전 | v1.0 |
| 작성일 | 2026-06-30 |
| 대상 | 프론트(Flutter) 개발자 — 본인 |
| 백엔드 원본 | `읽고_백엔드_API명세_ERD.md` |
| 용도 | **먼저 목데이터로 화면 완성 → 백엔드 붙으면 실데이터로 전환** |

> 이 문서의 응답 예시(JSON)는 **그대로 복사해서 `assets/mock/*.json`으로 쓰면 됩니다.** §6 목데이터 전략 참고.

---

## 1. 개요 — 목 우선(Mock-first) 전략

1. **지금:** 아래 예시 JSON을 목데이터로 넣고 **화면·플로우부터 완성**한다(백엔드 없이도 앱 100% 동작).
2. **나중:** 백엔드(`/v1/analyses` 등)가 준비되면 **Repository 구현만 교체**해 실데이터로 전환한다.
3. 전환은 **플래그 하나(`USE_MOCK`)**로 스위치. 화면 코드는 안 바뀐다.

---

## 2. 공통 규약 (앱 관점)

- **Base URL:** 빌드 설정으로 주입 → `--dart-define=BASE_URL=https://ilgo-api.up.railway.app/v1`
- **공통 헤더:**
  - `X-Device-Id: <uuid>` — 앱 최초 실행 시 생성해 로컬 저장(로그인 없음).
  - `Content-Type: application/json`
- **시간:** ISO 8601 UTC 문자열.
- **에러 응답(공통):**
```json
{ "error": { "code": "AI_PARSE_FAILED", "message": "분석에 실패했어요. 다시 시도해 주세요.", "details": {} } }
```
- **앱의 상태코드 처리:**
  | 코드 | 앱 동작 |
  |---|---|
  | 200/201 | 정상 렌더 |
  | 400/413 | "이미지를 다시 선택/촬영해 주세요" |
  | 422 | "분석에 실패했어요. 다시 찍어주세요" (+ 폴백 캐시) |
  | 429 | "잠시 후 다시 시도해 주세요" |
  | 502/500 | 재시도 버튼 + 폴백 캐시 표시 |
  | 네트워크 오류 | 재시도 + 폴백 |

---

## 3. 앱이 쓰는 엔드포인트

| # | Method | Path | 화면 | 우선순위 |
|---|---|---|---|---|
| 1 | POST | `/v1/analyses` | 분석 로딩→결과 | MVP |
| 2 | GET | `/v1/analyses` | 보관함 목록 | MVP |
| 3 | GET | `/v1/analyses/{id}` | 보관함 상세 | MVP |
| 4 | DELETE | `/v1/analyses/{id}` | 보관함 삭제 | P1 |
| 5 | PATCH | `/v1/analyses/{id}/actions/{action_id}` | 할 일 체크 | P2 |
| 6 | POST | `/v1/analyses/{id}/replies:regenerate` | 답장 재생성(native) | P2 |
| 7 | GET/PUT | `/v1/profile` | 설정 | P1 |

---

## 4. 핵심 API — POST /v1/analyses

이미지 1장을 보내면 분석 결과를 받는다.

**요청 (application/json)**
```json
{
  "image_base64": "<BASE64_STRING>",
  "media_type": "image/jpeg",
  "output_mode": "easy_korean",
  "lang": "ko",
  "save": true
}
```
- `output_mode`: `easy_korean` | `native`
- `lang`: `ko`(쉬운 한국어일 땐 ko) | `en`(모국어=영어 데모) | 기타 ISO 639-1

### 4-A. 응답 예시 — 쉬운 한국어 · 건강보험 고지서 → `mock/analyze_easy_health.json`
```json
{
  "id": "anl_0001",
  "status": "done",
  "output_mode": "easy_korean",
  "lang": "ko",
  "doc_type": "고지서",
  "summary_one_line": "8월 15일까지 건강보험료 6만 8천 원을 내야 해요",
  "original_text": "2026년 7월분 건강보험료 고지서. 본인부담금 68,000원. 납부기한 2026-08-15. 미납 시 연체금이 부과됩니다.",
  "explained_text": "건강보험료를 내라는 종이예요. 💰 6만 8천 원을 8월 15일까지 내면 돼요. 안 내면 돈이 더 붙어요.",
  "consequence": "기한이 지나면 연체료가 더해질 수 있어요",
  "cards": { "what": "건강보험료 납부", "when": null, "where": null, "amount": "68,000원", "deadline": "2026-08-15" },
  "risks": [
    { "id": "rsk_1", "level": "yellow", "type": "기한", "message": "8월 15일이 지나면 연체료가 붙을 수 있어요" }
  ],
  "actions": [
    { "id": "act_1", "text": "은행 앱이나 지로로 6만 8천 원을 내세요", "priority": 1, "is_done": false },
    { "id": "act_2", "text": "낸 뒤 영수증을 보관하세요", "priority": 2, "is_done": false }
  ],
  "reply_drafts": [],
  "created_at": "2026-06-30T07:10:00Z"
}
```

### 4-B. 응답 예시 — 모국어(영어) · 사장님 카톡(임금 위험) → `mock/analyze_native_wage.json`
```json
{
  "id": "anl_0002",
  "status": "done",
  "output_mode": "native",
  "lang": "en",
  "doc_type": "메시지",
  "summary_one_line": "Tomorrow 5 AM meetup. If you're late, your daily pay gets cut.",
  "original_text": "내일 새벽 5시까지 창고 앞으로 집합. 늦으면 일당 깐다.",
  "explained_text": "Your boss says: gather in front of the warehouse tomorrow at 5:00 AM. If you are late, he will deduct part of your daily wage.",
  "consequence": "If you arrive late, you may lose part of tomorrow's pay.",
  "cards": { "what": "Report for work (meetup)", "when": "Tomorrow 05:00", "where": "In front of the warehouse", "amount": null, "deadline": null },
  "risks": [
    { "id": "rsk_2", "level": "red", "type": "임금", "message": "This message says your daily wage will be cut if you are late. Check your work contract." }
  ],
  "actions": [
    { "id": "act_3", "text": "Set an alarm for 4:00 AM to arrive on time", "priority": 1, "is_done": false }
  ],
  "reply_drafts": [
    { "id": "rd_1", "korean": "네, 알겠습니다. 내일 새벽 5시까지 창고 앞으로 가겠습니다.", "note_in_lang": "\"Yes, understood. I'll be in front of the warehouse by 5 AM tomorrow.\"" },
    { "id": "rd_2", "korean": "확인했습니다. 혹시 늦을 수 있어 미리 말씀드립니다.", "note_in_lang": "\"Noted. I'm letting you know in advance in case I might be late.\"" }
  ],
  "created_at": "2026-06-30T07:20:00Z"
}
```

### 4-C. 응답 예시 — 쉬운 한국어 · 과태료(위험 빨강) → `mock/analyze_easy_fine.json`
```json
{
  "id": "anl_0003",
  "status": "done",
  "output_mode": "easy_korean",
  "lang": "ko",
  "doc_type": "고지서",
  "summary_one_line": "9월 1일까지 주차 과태료 4만 원을 내야 해요",
  "original_text": "불법주정차 과태료 부과 사전통지서. 과태료 40,000원. 의견제출 기한 2026-09-01.",
  "explained_text": "주차를 잘못해서 벌금이 나왔어요. 🚗 4만 원이에요. 9월 1일까지 내거나 억울하면 의견을 낼 수 있어요.",
  "consequence": "기한을 넘기면 돈이 더 늘어날 수 있어요",
  "cards": { "what": "주차 과태료", "when": null, "where": null, "amount": "40,000원", "deadline": "2026-09-01" },
  "risks": [
    { "id": "rsk_3", "level": "red", "type": "과태료", "message": "기한을 넘기면 가산금이 붙어요. 억울하면 기한 안에 의견을 낼 수 있어요." }
  ],
  "actions": [
    { "id": "act_4", "text": "9월 1일까지 4만 원을 내세요", "priority": 1, "is_done": false },
    { "id": "act_5", "text": "주차가 억울하면 의견 제출을 알아보세요", "priority": 2, "is_done": false }
  ],
  "reply_drafts": [],
  "created_at": "2026-06-30T07:25:00Z"
}
```

---

## 5. 나머지 API

### 5-1. GET /v1/analyses — 보관함 목록 → `mock/list.json`
`?limit=20&cursor=<opaque>`
```json
{
  "items": [
    { "id": "anl_0001", "doc_type": "고지서", "summary_one_line": "8월 15일까지 건강보험료 6만 8천 원…", "top_risk_level": "yellow", "card_deadline": "2026-08-15", "created_at": "2026-06-30T07:10:00Z" },
    { "id": "anl_0003", "doc_type": "고지서", "summary_one_line": "9월 1일까지 주차 과태료 4만 원…", "top_risk_level": "red", "card_deadline": "2026-09-01", "created_at": "2026-06-30T07:25:00Z" },
    { "id": "anl_0002", "doc_type": "메시지", "summary_one_line": "Tomorrow 5 AM meetup. If late, pay cut.", "top_risk_level": "red", "card_deadline": null, "created_at": "2026-06-30T07:20:00Z" }
  ],
  "next_cursor": null
}
```

### 5-2. GET /v1/analyses/{id} — 상세
응답: §4-A와 동일한 전체 객체.

### 5-3. DELETE /v1/analyses/{id}
성공: `204 No Content` (본문 없음).

### 5-4. PATCH /v1/analyses/{id}/actions/{action_id} — 할 일 체크
요청 `{ "is_done": true }` → 응답 `{ "id": "act_1", "is_done": true }`

### 5-5. POST /v1/analyses/{id}/replies:regenerate — 답장 재생성(native)
요청(선택) `{ "tone": "polite" }` → 응답 `{ "reply_drafts": [ { "id": "rd_3", "korean": "…", "note_in_lang": "…" } ] }`
easy 모드 분석에 요청 시 `409 NOT_NATIVE_MODE`.

### 5-6. GET / PUT /v1/profile — 설정
GET `{ "output_mode": "easy_korean", "lang": "ko" }` / PUT 요청 `{ "output_mode": "native", "lang": "en" }` → 저장값 반환.

---

## 6. 목데이터 전략 (Mock-first 구현)

**폴더**
```
assets/
  mock/
    analyze_easy_health.json      # 4-A
    analyze_native_wage.json      # 4-B
    analyze_easy_fine.json        # 4-C
    list.json                     # 5-1
```
`pubspec.yaml`에 `assets: [assets/mock/]` 등록.

**Repository 스왑 (핵심 패턴)**
```dart
abstract class AnalysisRepository {
  Future<Analysis> analyze({required Uint8List imageBytes, required String mediaType,
                            required OutputMode mode, required String lang});
  Future<List<AnalysisSummary>> list({String? cursor});
  Future<Analysis> getById(String id);
  Future<void> delete(String id);
}

// 지금: 목 구현 (자산 JSON 로드 + 지연 시뮬레이션)
class MockAnalysisRepository implements AnalysisRepository {
  @override
  Future<Analysis> analyze({required imageBytes, required mediaType,
                            required mode, required lang}) async {
    await Future.delayed(const Duration(seconds: 2)); // 로딩 화면 확인용
    final file = mode == OutputMode.native
        ? 'assets/mock/analyze_native_wage.json'
        : 'assets/mock/analyze_easy_health.json';
    final raw = await rootBundle.loadString(file);
    return Analysis.fromJson(jsonDecode(raw));
  }
  // list/getById도 자산에서 로드
}

// 나중: 실제 구현 (dio)
class ApiAnalysisRepository implements AnalysisRepository {
  final Dio dio;
  ApiAnalysisRepository(this.dio);
  @override
  Future<Analysis> analyze({required imageBytes, required mediaType,
                            required mode, required lang}) async {
    final res = await dio.post('/analyses', data: {
      'image_base64': base64Encode(imageBytes),
      'media_type': mediaType,
      'output_mode': mode.name,
      'lang': lang,
      'save': true,
    });
    return Analysis.fromJson(res.data);
  }
}
```

**플래그로 전환 (화면 코드는 안 바뀜)**
```dart
// --dart-define=USE_MOCK=true 로 실행하면 목, 아니면 실서버
const useMock = bool.fromEnvironment('USE_MOCK', defaultValue: true);

final analysisRepositoryProvider = Provider<AnalysisRepository>((ref) {
  return useMock
      ? MockAnalysisRepository()
      : ApiAnalysisRepository(ref.read(dioProvider));
});
```

> **작업 순서:** ① 목으로 모든 화면 완성(`USE_MOCK=true`) → ② 백엔드 나오면 `dioProvider` baseUrl 설정 후 `USE_MOCK=false`로 실행. 끝.

---

## 7. 실데이터 전환 체크리스트

- [ ] `--dart-define=BASE_URL=…` (Railway 도메인) 주입
- [ ] `dio` baseUrl + `X-Device-Id` 헤더 인터셉터 설정
- [ ] 타임아웃 30초, 에러 → §2 상태코드 매핑
- [ ] 응답 JSON 필드가 목과 동일한지 확인(아래 §8 필드 표)
- [ ] 라이브 실패 대비 목 JSON을 **폴백 캐시**로도 유지

---

## 8. 부록 — 응답 필드 (Analysis)

| 필드 | 타입 | 설명 |
|---|---|---|
| id | string | 분석 ID |
| status | enum | processing / done / failed |
| output_mode | enum | easy_korean / native |
| lang | string | ko / en … |
| doc_type | string | 고지서/공지/메시지/계약/기타 |
| summary_one_line | string | 핵심 한 문장 |
| original_text | string | 원문 |
| explained_text | string | 쉬운말/모국어 풀이 |
| consequence | string? | 안 하면 생기는 일 |
| cards | object | what/when/where/amount(string?), deadline(YYYY-MM-DD?) |
| risks[] | array | id, level(green/yellow/red), type, message |
| actions[] | array | id, text, priority(int), is_done(bool) |
| reply_drafts[] | array | id, korean, note_in_lang (native만) |
| created_at | string | ISO 8601 |

*프론트 API 명세 v1.0 · 제품 "읽고" · 목→실 전환 Repository 스왑 · 동반: `읽고_Flutter_기술스택.md`.*
