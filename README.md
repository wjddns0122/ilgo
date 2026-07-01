# 📖 읽고 (Ilgo)

> **"어려운 글, 대신 읽고 알려드릴게요."**
> 
> 어려운 한국어 글(종이 고지서, 휴대폰 문자, 카카오톡 메시지 등)을 **사진 한 장**으로 촬영하면, AI가 **쉬운 한국어** 또는 **영어**로 번역하고 해석하여 정보 격차를 해소해 주는 배리어프리 및 다문화 지원 모바일 애플리케이션입니다.
>
> *(AI Re-Local 해커톤 출품작)*

---

## 🌟 핵심 가치 & 타겟 사용자
'읽고'는 문해력 격차로 인해 사회적 불이익을 받거나 일상생활에 어려움을 겪는 이웃들을 위해 개발되었습니다.
* 🧑‍🤝‍🧑 **발달장애인 & 저문해자**: 난해한 법률 용어나 행정 서류를 직관적이고 친근한 **쉬운 한국어(Easy Korean)**로 바꾸어 제공합니다.
* 🧑‍🎨 **외국인 노동자 & 다문화 가정**: 일상 속 한국어 고지서나 안내문 등을 이해하기 쉬운 **영어(English)**로 로컬라이징해 줍니다.
* ♿ **배리어프리(Accessibility) 극대화**: 큰 글씨(본문 18sp+, 핵심 24sp+), 고대비 테마, 터치 영역 48dp+ 확보 및 TTS(음성 읽기)를 완벽 지원합니다.

---

## 🚀 주요 기능
1. **멀티모달 AI 분석**
   * 종이 고지서나 화면 캡처 이미지를 업로드하면, 백엔드 프록시를 거쳐 Claude 3.5 Sonnet 멀티모달 API를 1회 호출하고, 완벽히 구조화된 JSON 데이터(`ReadResult`)를 받아와 카드 UI로 시각화합니다.
2. **신호등 위험 감지 시스템**
   * 사기, 임금 체불, 불이익, 기한 임박 등의 잠재적 위험 요소를 **초록(안전) / 노랑(주의) / 빨강(경고)**의 직관적인 신호등 색상과 메시지로 시각화하여 위험을 즉시 감지하도록 돕습니다.
3. **핵심 정보 요약 카드 & 할 일(Action Item) 관리**
   * 무엇을, 언제, 어디서, 얼마를 내야 하는지(deadline, amount 등) 핵심 내용만 카드로 요약하고, 네이티브 캘린더 등록(`add_2_calendar`)과 연동하여 중요한 기한을 놓치지 않게 돕습니다.
4. **문자/카톡 답장 초안(Draft) 제공**
   * 분석 결과를 바탕으로 상대방에게 전송할 적절한 답장 문구를 상황에 맞게 생성하여 즉시 공유할 수 있도록 지원합니다.
5. **텍스트 음성 변환(TTS) 지원**
   * 앱 화면에 표시된 모든 본문과 위험 경고 내용을 음성으로 들려주어 시각/발달장애인의 정보 접근성을 극대화합니다.
6. **유연한 모드 스왑 (Mock ↔ Real Server)**
   * 백엔드가 배포되기 전에도 완벽히 작동하는 목(Mock) 데이터 모드를 탑재하였으며, 빌드 파라미터 하나로 실제 API 서버 통신 환경으로 즉시 스왑할 수 있습니다.

---

## 🛠 기술 스택

### Frontend (Flutter)
* **Framework:** Flutter (Android / iOS / Windows 지원)
* **State Management & Routing:** GetX (상태 관리, 라우팅, DI 통합 관리)
* **Networking:** Dio + Retrofit (타입 안전한 REST API 통신)
* **Serialization:** Freezed + Json Serializable (불변 객체 및 JSON 직렬화 자동 생성)
* **Key Packages:**
  * `image_picker` & `flutter_image_compress` (이미지 촬영/선택 및 업로드 크기 최적화)
  * `flutter_tts` (텍스트 음성 합성 기능)
  * `add_2_calendar` (디바이스 캘린더 일정 추가 연동)
  * `url_launcher` & `share_plus` (외부 링크 연결 및 텍스트/답장 초안 공유)
  * `shared_preferences` (앱 내 언어 설정 및 온보딩 여부 로컬 저장)
  * `google_fonts` (가독성 높은 폰트 세팅)

### Backend & Infrastructure
* **Framework:** Spring Boot
* **Database:** Supabase (PostgreSQL)
* **Deployment:** Railway Cloud
* **API Documentation:** Swagger UI (springdoc)

---

## 📂 프로젝트 구조

```text
lib/
├── core/                # 앱 공통 설정, 테마, 라우팅 정의
│   ├── app_pages.dart   # GetX 페이지 라우트 등록
│   ├── app_routes.dart  # 라우트 경로 상수 정의
│   ├── config.dart      # 환경 변수 및 빌드 설정 주입
│   └── theme.dart       # 배리어프리용 고대비 및 라이트 테마 정의
├── data/                # 데이터 레이어 (모델, API, 레포지토리)
│   ├── api/             # Retrofit API 클라이언트 및 DTO 정의
│   ├── bindings/        # GetX Dependency Injection 바인딩
│   ├── models/          # Freezed 기반 데이터 계약 모델 (Analysis, Risk, Card 등)
│   ├── repositories/    # 데이터 소스 추상화 (Mock / API Repository 구현체)
│   └── services/        # 앱 전역 비즈니스 서비스 (TTS, 사용자 프로필)
├── modules/             # 화면 및 프레젠테이션 레이어 (GetX Controller + View)
│   ├── onboarding/      # 초기 모드 및 사용자 언어 선택 화면
│   ├── home/            # 이미지 촬영 및 분석 요청 홈
│   ├── analyze/         # 분석 진행 중 상태를 보여주는 로딩 화면
│   ├── result/          # 분석 결과 상세 화면 (카드 요약, 위험도, 답장, 액션)
│   ├── library/         # 과거 분석 이력 보관함
│   └── settings/        # 앱 설정 및 고대비 테마 변경 화면
└── widgets/             # 재사용 가능한 UI 컴포넌트 (음성 버튼, 리스크 배너, 토글 등)
```

---

## 💻 실행 방법

### 1. 의존성 설치
```bash
flutter pub get
```

### 2. 코드 생성 (build_runner)
Retrofit 클라이언트 및 Freezed 모델 생성을 위해 `build_runner`를 실행합니다.
> ⚠️ **macOS 빌드 시 주의사항**
> macOS 환경에 따라 Dart AOT 모드 컴파일러(`gen_snapshot`) 관련 오류가 발생할 수 있습니다. 정상적인 코드 생성을 위해 반드시 `--force-jit` 옵션을 추가해 실행하세요.
```bash
dart run build_runner build --delete-conflicting-outputs --force-jit
```

### 3. 애플리케이션 실행

#### A. 목(Mock) 데이터 모드 (기본값)
로컬에 내장된 Mock JSON을 사용해 오프라인 환경에서도 100% 동작하는 데모를 신속하게 구동하고 테스트합니다.
```bash
flutter run
# 또는 명시적으로 주입
flutter run --dart-define=USE_MOCK=true
```

#### B. 실서버 연동 모드
배포된 Railway API 서버와 실시간으로 통신하며 라이브 AI 분석 기능을 수행합니다.
```bash
flutter run --dart-define=USE_MOCK=false --dart-define=BASE_URL=https://ilgo-api.up.railway.app/v1
```

### 4. iOS 실기기 디버깅 가이드
1. `ios` 폴더에서 CocoaPods 의존성을 설치합니다.
   ```bash
   cd ios && pod install && cd ..
   ```
2. Xcode로 `ios/Runner.xcworkspace` 프로젝트를 열고, **Signing & Capabilities**에서 본인의 개발자 팀 설정을 진행합니다.
3. 실기기를 연결하고 기기 설정에서 **개발자 모드**를 활성화한 뒤 빌드를 실행합니다.

---

## ⚠️ 컨벤션 및 안전망
* **개인정보 보호**: 데모에 사용되는 고지서, 메시지 캡처본 등은 이름, 주민번호, 계좌번호 등의 민감한 개인정보를 마스킹 처리하여 구동하는 것을 권장합니다. (이미지는 기본적으로 서버에 영구 보존되지 않도록 프록시 설계)
* **AI 위험 판정 가이드**: 사기/사칭/체불 등 위험 유무에 확신이 없을 경우, 안전을 위해 **Yellow(주의)** 이상으로 보수적인 판정을 내리도록 유도합니다. (본 앱은 보조 도구이며 최종 확인은 사용자 본인의 책임입니다.)
* **발표 안전망**: 네트워크 상태가 불안정한 해커톤 데모 환경 등에서는 실서버 통신 실패 시 목(Mock) JSON을 캐시로 활용하여 데모 안정성을 확보합니다.
