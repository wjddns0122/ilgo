# CLAUDE.md — 읽고 (Ilgo) 프로젝트

> 새 세션이 이 파일을 자동으로 읽습니다. 프로젝트 맥락·결정·다음 할 일이 여기 다 있어요.
> 세부는 아래 문서들을 참조.

## 프로젝트 한 줄
**읽고 (Ilgo)** — 어려운 한국어 글(종이 고지서 / 휴대폰 문자·카톡)을 **사진 한 장**으로 찍으면, **쉬운 한국어 또는 영어**로 풀어주고, **위험(사기·임금·기한)을 신호등으로** 짚고, **할 일·답장·음성**까지 주는 앱. (AI Re-Local 해커톤 출품작)

- 슬로건: "어려운 글, 대신 읽고 알려드릴게요."
- 두 사용자(동등): **김민수**(28, 발달장애·저문해 → 쉬운 한국어) / **마리아**(32, 필리핀 노동자 → 영어).
- **배리어프리 + 다문화 두 트랙 동시 출전** (1팀 1트랙 규정이면 배리어프리 메인 폴백).
- 차별점: 다른 팀은 Canva 목업, 우리는 **실제 구동 앱 + 라이브 AI**.
- 심사(100): 사회가치30 / 창의25 / AI활용20 / 완성15 / 발표10.

## 핵심 엔진
`사진/캡처 → (백엔드 프록시) → Claude 멀티모달 1회 호출 → 구조화 JSON(ReadResult) → 카드 UI`.
모드는 파라미터 분기(`output_mode`: easy_korean|native, `lang`: ko|en).

## 확정 기술 스택
- **프론트(Flutter):** GetX(상태+라우팅+DI) · dio+retrofit · freezed+json_serializable · image_picker · flutter_image_compress · flutter_tts · add_2_calendar · url_launcher · share_plus · shared_preferences · google_fonts. 디자인=**Figma MCP** 핸드오프.
- **백엔드:** Spring Boot · Supabase(PostgreSQL) · Railway 배포 · Swagger UI(springdoc). Claude 키는 서버(Railway env).
- **개발 방식:** **목데이터로 화면 100% 완성 → `USE_MOCK=false` 한 줄로 실서버 스왑**(Repository 인터페이스 + GetX Bindings).

## 문서 인덱스 (source of truth)
| 파일 | 내용 |
|---|---|
| `읽고_PRD.md` | 제품 요구사항(문제·목표·페르소나·유저스토리·FR·마일스톤·결정사항) |
| `읽고_기능명세서.md` | 비개발자용 쉬운 기능 설명 |
| `읽고_백엔드_API명세_ERD.md` | 백엔드 REST API + ERD + Spring/Supabase/Railway/Swagger |
| `읽고_프론트_API명세.md` | 앱이 쓰는 API + **바로 쓸 목 JSON** + 목→실 스왑 |
| `읽고_Flutter_기술스택.md` | Flutter 스택(GetX/retrofit/freezed) + 아키텍처 + 폴더구조 + 코드 스케치 |
| `읽고_팀_업무분담.md` | 개발 외 팀원(자료조사·디자인·영상·발표) 할 일 |
| `최종_통합아이디어_읽어드림.md` | 통합 아이디어 배경(구 이름 "읽어드림") |
| `해커톤_트랙별_아이디어.html` | 4개 트랙 비교(참고) |

## 데이터 계약 (ReadResult)
`id, status, output_mode, lang, doc_type, summary_one_line, original_text, explained_text, consequence, cards{what,when,where,amount,deadline}, risks[{id,level(green|yellow|red),type,message}], actions[{id,text,priority,is_done}], reply_drafts[{id,korean,note_in_lang}](native만), created_at`. 프론트·백엔드 동일 스키마.

## 현재 상태
- 기획/명세/스택 **문서화 완료**. 코드 아직 없음.
- 백엔드는 아직 안 붙음 → **프론트는 목 우선**으로 진행 가능.

## 다음 할 일 (새 세션 시작점)
1. Flutter 스캐폴드: `flutter create ilgo` + `읽고_Flutter_기술스택.md` §8 커맨드로 패키지.
2. freezed 모델(Analysis 등) + `assets/mock/*.json`(= `읽고_프론트_API명세.md`의 예시 JSON).
3. Repository 인터페이스 + Mock 구현 + GetX AnalyzeController.
4. 화면: 온보딩→홈(촬영/캡처)→로딩→결과(요약/토글/카드/신호등/할일)→답장/음성.
5. 이후 백엔드 나오면 retrofit ApiRepository + `USE_MOCK=false`.

## 주의/컨벤션
- 개인정보: 데모 자료(고지서·문자)는 이름·번호·계좌 **마스킹**. 이미지 기본 미저장.
- AI 위험판정: 확신 없으면 **yellow**(사기 false negative 방지). "보조 도구, 최종 확인은 사람".
- 발표 안전망: 목 JSON을 **라이브 실패 폴백 캐시**로도 사용.
- 접근성: 큰 글씨(본문 18sp+/핵심 24sp+)·고대비·터치 48dp+.
