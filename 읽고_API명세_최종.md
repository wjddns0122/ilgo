# 읽고 (Ilgo) — API 명세서 (최종 확정본)

| 항목 | 내용 |
|---|---|
| 문서 버전 | v3.0 (앱 구현 기준 최종) |
| 작성일 | 2026-07-02 |
| 기준 | 실제 구현된 Flutter 화면·기능·TODO 반영 |
| Base URL | `https://ilgo-api.up.railway.app/v1` (빌드 시 `--dart-define=BASE_URL`로 주입) |
| 프론트 전환 | `USE_MOCK=false` 한 줄로 목→실서버 (Repository 인터페이스 동일) |

> 프론트는 현재 **목(mock)** 으로 100% 동작 중. 이 문서의 스키마대로 백엔드가 응답하면 `USE_MOCK=false`로 그대로 붙는다.
> **[TODO]** 표시 = 아직 프론트에 로직 미연동(UI만 있음), 백엔드 확정 후 연결할 부분.

---

## 1. 공통 규약

### 1-1. 인증 & 헤더
- 초기(로그인 전): `X-Device-Id: <uuid>` — 앱 최초 실행 시 생성해 로컬 저장.
- 로그인 후: `Authorization: Bearer <access_token>`
- 공통: `Content-Type: application/json`, `Accept-Language: <ko|en|km|vi|ne|zh|th|id>` (사용자 선택 언어)

### 1-2. 시간 / 형식
- 시간: ISO 8601 UTC 문자열 (`2026-08-15T00:00:00Z`)
- 기한(deadline): `YYYY-MM-DD`
- 금액: 문자열 (`"68,000원"`) — 표시용 그대로

### 1-3. 에러 응답 (공통)
```json
{ "error": { "code": "AI_PARSE_FAILED", "message": "분석에 실패했어요. 다시 시도해 주세요.", "details": {} } }
```

### 1-4. 상태코드 → 앱 동작 (구현됨)
| 코드 | 앱 화면/동작 |
|---|---|
| 200/201 | 정상 렌더 |
| 400/413 | "이미지를 다시 선택/촬영해 주세요" |
| 422 `AI_PARSE_FAILED` | **흐림 화면**(글자가 안 보여요) + 촬영 팁 |
| 200 + `doc_type` 불명/`status:"unsupported"` | **문서 아님 화면**(무슨 글인지 모르겠어요) |
| 401 | 로그인 화면으로 |
| 429 | "잠시 후 다시 시도해 주세요" |
| 5xx | 재시도 버튼 + 폴백 캐시 |
| 네트워크 오류 | **연결 끊김 화면** + 다시 시도 (사진 로컬 보관) |

---

## 2. 엔드포인트 요약

| # | Method | Path | 화면 | 상태 |
|---|---|---|---|---|
| 1 | POST | `/auth/signup` | 로그인/가입 완료 | **[TODO]** |
| 2 | POST | `/auth/login` | 로그인 | **[TODO]** |
| 3 | GET | `/auth/me` | 세션 확인(스플래시) | **[TODO]** |
| 4 | GET/PUT | `/profile` | 설정·온보딩 | P1 |
| 5 | POST | `/analyses` | 촬영→로딩→결과 | **MVP(핵심)** |
| 6 | GET | `/analyses` | 홈 최근기록·보관함 | MVP |
| 7 | GET | `/analyses/{id}` | 보관함 상세 | MVP |
| 8 | DELETE | `/analyses/{id}` | 보관함 삭제 | P1 |
| 9 | PATCH | `/analyses/{id}/actions/{action_id}` | 할 일 체크 | P2 |
| 10 | POST | `/analyses/{id}/replies:regenerate` | 답장 재생성 | P2 |
| 11 | POST | `/analyses/{id}/tts` | 소리 듣기 | **[TODO]** |
| 12 | GET | `/help-contacts` | 도움받을 곳 | **[TODO]** |

---

## 3. 인증 API **[TODO — 로그인 로직 미연동]**

> 현재 로그인/가입 화면 UI만 존재. 아래 스키마로 백엔드 확정 후 연결.

### 3-1. POST `/auth/signup`
요청 `{ "email": "name@example.com", "password": "******" }`
응답 `201` `{ "access_token": "...", "user": { "id": "usr_1", "email": "name@example.com" } }`
- 가입 성공 → **가입 완료 화면**(입력 이메일 표시) → 온보딩.

### 3-2. POST `/auth/login`
요청 `{ "email": "...", "password": "..." }`
응답 `200` `{ "access_token": "...", "user": { "id": "...", "email": "..." } }`
- 비번 6자 이상(클라 검증). 실패 `401`.

### 3-3. GET `/auth/me`
응답 `200` `{ "user": { "id": "...", "email": "..." }, "profile": { ...§4 } }`
- 스플래시에서 토큰 유효하면 로그인 스킵.

---

## 4. 프로필 API

### GET `/profile`
```json
{ "output_mode": "easy_korean", "lang": "ko", "text_scale": 1.0, "deadline_alarm": true }
```
### PUT `/profile`
요청(부분 허용) `{ "output_mode": "native", "lang": "km", "text_scale": 1.15, "deadline_alarm": false }` → 저장값 반환.

| 필드 | 값 | 설명 |
|---|---|---|
| output_mode | `easy_korean` \| `native` | 읽기 방식(쉬운 한국어 / 내 언어로) |
| lang | `ko` `km` `vi` `ne` `en` `zh` `th` `id` | 모국어 |
| text_scale | 0.9 / 1.0 / 1.15 / 1.3 | 글씨 크기(작게/보통/크게/아주 크게) — 현재 로컬 저장, 서버 동기화는 선택 |
| deadline_alarm | bool | 기한 알림 on/off — 실제 알림 스케줄링 **[TODO]** |

> 현재 프로필은 `shared_preferences` 로컬 저장. 로그인 붙이면 서버 동기화로 승격 가능(스키마 동일).

---

## 5. 분석 API (핵심) — POST `/analyses`

사진 1장 → 구조화 결과(ReadResult).

**요청 (application/json)**
```json
{
  "image_base64": "<BASE64>",
  "media_type": "image/jpeg",
  "output_mode": "easy_korean",
  "lang": "ko",
  "save": true
}
```
- `output_mode`: `easy_korean` | `native`
- `lang`: 출력 언어 (native일 때 `km/vi/ne/en/...`)

### 5-A. 응답 — 쉬운 한국어 · 고지서 (result 화면: 풀이 / 핵심·할 일)
```json
{
  "id": "anl_0001",
  "status": "done",
  "output_mode": "easy_korean",
  "lang": "ko",
  "doc_type": "고지서",
  "summary_one_line": "8월 15일까지 건강보험료 6만 8천 원을 내야 해요",
  "original_text": "2026년 7월분 건강보험료 고지서 …",
  "explained_text": "이건 건강보험료를 내라는 종이예요. 📮 …",
  "consequence": "기한이 지나면 연체료가 조금 더 붙어요. 하지만 늦게라도 낼 수 있어요.",
  "cards": { "what": "건강보험료", "when": "2025년 7월분", "where": "은행 · 편의점 · 앱", "amount": "68,000원", "deadline": "2026-08-15" },
  "risks": [
    { "id": "rsk_0", "level": "green", "type": "사기", "message": "국민건강보험공단이 보낸 진짜 고지서로 보여요. 안심하세요.",
      "detail": null, "steps": [] },
    { "id": "rsk_1", "level": "yellow", "type": "기한", "message": "8월 15일이 지나면 연체료가 조금 더 붙을 수 있어요.",
      "detail": null, "steps": [] }
  ],
  "actions": [
    { "id": "act_1", "text": "8월 15일 전에 6만 8천 원을 준비해요.", "priority": 1, "is_done": false },
    { "id": "act_2", "text": "은행 앱이나 편의점에서 납부해요.", "priority": 2, "is_done": false },
    { "id": "act_3", "text": "다 낸 뒤에는 영수증을 사진으로 남겨요.", "priority": 3, "is_done": false }
  ],
  "reply_drafts": [],
  "created_at": "2026-06-30T07:10:00Z"
}
```

### 5-B. 응답 — 모국어(예: 크메르어) · 카톡/메시지 (result 화면: 풀이 / 핵심·할 일 / 답장)
```json
{
  "id": "anl_0002",
  "status": "done",
  "output_mode": "native",
  "lang": "km",
  "doc_type": "메시지",
  "summary_one_line": "내일 새벽 5시까지 오라고 해요. 늦으면 일당을 깎겠다고 해요.",
  "original_text": "내일 새벽 5시까지 창고 앞으로 집합. 늦으면 일당 깐다. 이번 달 숙소비 15만 원은 월급에서 뗀다.",
  "explained_text": "ថ្ងៃស្អែក ត្រូវមកម៉ោង ៥ ព្រឹក។ … (모국어 풀이)",
  "consequence": "늦으면 하루 일당의 일부를 못 받을 수 있어요.",
  "cards": { "what": "새벽 집합 (출근)", "when": "내일 05:00", "where": "창고 앞", "amount": "숙소비 15만 원 공제", "deadline": null },
  "risks": [
    { "id": "rsk_2", "level": "red", "type": "임금", "message": "지각을 이유로 일당을 깎는 것은 부당할 수 있어요. 근로계약을 확인하세요.",
      "detail": "근로계약서에 정한 임금은 지켜야 해요. 실제 일하지 않은 시간만큼은 뺄 수 있지만, 그 이상으로 벌금처럼 깎는 것은 법 위반일 수 있어요.",
      "steps": ["근로계약서에서 임금·공제 조건을 확인해요.", "공제 내역을 문자·서면으로 남겨달라고 해요.", "부당하면 상담 전화로 물어봐요."] },
    { "id": "rsk_3", "level": "yellow", "type": "계약", "message": "숙소비 15만 원 공제가 계약에 있는지 꼭 확인하세요.",
      "detail": null, "steps": [] }
  ],
  "actions": [
    { "id": "act_6", "text": "새벽 4시에 알람을 맞춰 늦지 않게 준비해요.", "priority": 1, "is_done": false },
    { "id": "act_7", "text": "근로계약서에서 임금·숙소비 공제 내용을 확인해요.", "priority": 2, "is_done": false }
  ],
  "reply_drafts": [
    { "id": "rd_1", "korean": "네, 알겠습니다. 내일 새벽 5시까지 창고 앞으로 가겠습니다.", "note_in_lang": "\"Yes, understood…\"" },
    { "id": "rd_2", "korean": "확인했습니다. 숙소비 공제는 계약서를 다시 확인하고 싶습니다.", "note_in_lang": "\"Understood…\"" }
  ],
  "created_at": "2026-06-30T07:20:00Z"
}
```

### 5-C. 엣지케이스 응답
- **흐림/못 읽음**: `{ "status": "failed", "error": { "code": "AI_PARSE_FAILED" } }` 또는 HTTP 422 → 앱 **흐림 화면**.
- **문서 아님**: `{ "status": "done", "doc_type": null }` (또는 `"기타"`/`"unknown"`) → 앱 **문서 아님 화면** (+ "그래도 풀이"로 저장된 결과 표시).
- 프론트 판정 로직(구현됨): `status=="failed"`→흐림, `doc_type` 불명→문서아님, 그 외→결과.

---

## 6. 목록 / 상세 / 삭제

### GET `/analyses?limit=20&cursor=<opaque>` — 홈 최근기록 · 보관함
```json
{
  "items": [
    { "id": "anl_0001", "doc_type": "고지서", "summary_one_line": "8월 15일까지 건강보험료 …", "top_risk_level": "yellow", "card_deadline": "2026-08-15", "created_at": "2026-06-30T07:10:00Z" }
  ],
  "next_cursor": null
}
```
- **보관함은 `card_deadline` 오름차순(다가오는 기한 순)** 으로 정렬해 주면 좋음 (현재 클라에서도 정렬).
- 홈 "최근 기록"은 최신순 상위 5개 사용.

### GET `/analyses/{id}` — §5 ReadResult 전체 객체.
### DELETE `/analyses/{id}` — `204 No Content`.

---

## 7. 할 일 체크 — PATCH `/analyses/{id}/actions/{action_id}` (P2)
요청 `{ "is_done": true }` → 응답 `{ "id": "act_1", "is_done": true }`
> 현재 결과 화면 할 일은 번호 리스트(표시). 체크 토글 붙이면 이 API로 동기화.

---

## 8. 답장 재생성 — POST `/analyses/{id}/replies:regenerate` (native, P2)
요청(선택) `{ "tone": "polite" }` → 응답 `{ "reply_drafts": [ { "id": "rd_3", "korean": "…", "note_in_lang": "…" } ] }`
- easy 모드 요청 시 `409 NOT_NATIVE_MODE`.
- 답장 상세 화면에서 "다른 답장" 요청 시 사용(현재 UI 없음, 확장용).

---

## 9. 소리 듣기 (TTS) — POST `/analyses/{id}/tts` **[TODO]**

소리 듣기 화면: 문장 하이라이트 + 파형 + 재생/속도. 정확한 동기화 위해 **오디오 + 워드 타이밍** 필요.

요청 `{ "target": "explained", "lang": "ko", "speed": 1.0 }`
- `target`: `explained` | `summary` | `reply`
응답
```json
{
  "audio_url": "https://.../anl_0001_explained.mp3",
  "duration_ms": 14200,
  "marks": [
    { "text": "이건", "start_ms": 0, "end_ms": 420 },
    { "text": "건강보험료를", "start_ms": 420, "end_ms": 1180 }
  ]
}
```
- `marks`로 문장/단어 하이라이트 + 파형 진행 동기화.
- **[TODO]** 프론트: 현재 재생/속도/하이라이트 전부 로컬 토글만. `audio_url` 재생 + `marks` 구독으로 연결 예정.
- 대안: 온디바이스 `flutter_tts`만 쓰면 이 API 불필요(단, 파형·정밀 하이라이트 제한).

---

## 10. 위험 상세 (신호등 이유)

위험 상세 화면은 `risks[]`의 **`detail`(설명)** + **`steps[]`(단계별 대처)** 를 사용.

**권장: §5 ReadResult의 각 risk에 아래 필드 포함** (별도 호출 불필요)
```json
{ "id": "rsk_2", "level": "red", "type": "임금",
  "message": "짧은 한 줄 이유",
  "detail": "왜 그렇게 판정했는지 자세한 설명 (문단)",
  "steps": ["1단계", "2단계", "3단계"] }
```
- **[TODO]** 백엔드가 `detail`/`steps` 생성. 없으면 프론트는 `message`만 표시(폴백 구현됨).
- 별도 호출을 원하면: `GET /analyses/{id}/risks/{risk_id}` → `{ detail, steps }`.

---

## 11. 도움받을 곳 — GET `/help-contacts` **[TODO]**

도움받을 곳 화면 목록을 **언어·지역·문서타입 맞춤**으로 제공.

요청(쿼리) `?lang=km&doc_type=메시지&region=`
응답
```json
{
  "items": [
    { "id": "hlp_1", "title": "외국인 노동자 상담", "org": "고용노동부", "phone": "1350", "category": "labor", "emergency": false },
    { "id": "hlp_2", "title": "외국인종합안내센터", "org": "법무부", "phone": "1345", "category": "general", "emergency": false },
    { "id": "hlp_3", "title": "건강보험 문의", "org": "국민건강보험공단", "phone": "1577-1000", "category": "health", "emergency": false },
    { "id": "hlp_4", "title": "긴급 · 범죄 신고", "org": "경찰", "phone": "112", "category": "emergency", "emergency": true }
  ]
}
```
- `emergency:true` → 빨강 버튼. 탭 → `tel:` 발신(구현됨).
- **[TODO]** 현재 목록 하드코딩(오프라인 폴백). 이 API로 교체.

---

## 12. 데이터 계약 — ReadResult (전체 필드)

| 필드 | 타입 | 필수 | 설명 |
|---|---|---|---|
| id | string | ✓ | 분석 ID |
| status | enum | ✓ | `done` / `processing` / `failed` |
| output_mode | enum | ✓ | `easy_korean` / `native` |
| lang | string | ✓ | `ko` `km` `vi` `ne` `en` `zh` `th` `id` |
| doc_type | string? | | `고지서`/`안내문`/`계약서`/`메시지`/`공지`/… (불명 시 null→문서아님 화면) |
| summary_one_line | string? | | 핵심 한 문장 |
| original_text | string? | | 원문(원문 보기 토글) |
| explained_text | string? | | 쉬운말/모국어 풀이 |
| consequence | string? | | 안 하면 생기는 일 |
| cards | object? | | `what/when/where/amount(string?)`, `deadline(YYYY-MM-DD?)` |
| risks[] | array | | `id, level(green/yellow/red), type, message` **+ `detail(string?)`, `steps(string[])` [신규]** |
| actions[] | array | | `id, text, priority(int), is_done(bool)` |
| reply_drafts[] | array | | `id, korean, note_in_lang` (native만) |
| created_at | string | ✓ | ISO 8601 |

**AnalysisSummary (목록용):** `id, doc_type, summary_one_line, top_risk_level, card_deadline, created_at`

> **[신규] `risks[].detail`, `risks[].steps`** 는 위험 상세 화면용으로 추가된 필드. 기존 모델(id/level/type/message)과 하위호환(옵셔널).

---

## 13. 화면 ↔ API 매핑

| 화면 | API | 비고 |
|---|---|---|
| 스플래시 | `GET /auth/me` [TODO] | 세션 확인 |
| 로그인/가입 | `POST /auth/login`,`/auth/signup` [TODO] | UI만 |
| 온보딩(모드·언어·권한) | `PUT /profile` | 현재 로컬 |
| 홈(최근 기록) | `GET /analyses` | 최신 5 |
| 카메라→확인→분석 | `POST /analyses` | 핵심 |
| 결과(풀이/핵심·할일/답장) | `POST /analyses` 응답 | ReadResult |
| 소리 듣기 | `POST /analyses/{id}/tts` [TODO] | 오디오+타이밍 |
| 위험 상세 | `risks[].detail/steps` [TODO] | 응답 내포 권장 |
| 캘린더 추가 | — | 클라(add_2_calendar) |
| 답장 상세 | `reply_drafts[]` / regenerate(P2) | tel/카톡은 클라 |
| 보관함 | `GET /analyses`,`GET/DELETE /analyses/{id}` | 기한순 정렬 |
| 설정 | `GET/PUT /profile` | 글씨/알림 로컬 |
| 도움받을 곳 | `GET /help-contacts` [TODO] | 맞춤 목록 |
| 엣지케이스(흐림/문서아님/연결) | status·error·doc_type | §1-4, §5-C |

---

## 14. 확정 / TODO 요약

**바로 붙일 수 있음 (스키마 확정):**
- `POST /analyses` (ReadResult) — 핵심
- `GET /analyses`, `GET/DELETE /analyses/{id}` — 목록/상세/삭제
- `GET/PUT /profile`

**백엔드 협의 후 연동 [TODO]:**
- 인증: `/auth/signup`,`/auth/login`,`/auth/me` (로그인 로직)
- 소리 듣기: `POST /analyses/{id}/tts` (오디오 + 워드 타이밍)
- 위험 상세: `risks[].detail`,`risks[].steps`
- 도움받을 곳: `GET /help-contacts` (맞춤 목록)
- P2: 할 일 체크 PATCH, 답장 재생성, 기한 알림 스케줄링

---

*읽고 API 명세 v3.0 · 앱 구현 기준 · 프론트 목→실 스왑은 `USE_MOCK=false` · 동반: `읽고_프론트_API명세.md`, `읽고_백엔드_API명세_ERD.md`(구버전).*
