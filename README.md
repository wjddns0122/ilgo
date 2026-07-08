# 읽고 (Ilgo)

> 어려운 글, 대신 읽고 알려드릴게요.

`읽고`는 종이 고지서, 안내문, 문자, 카카오톡 메시지처럼 이해하기 어려운 생활 문서를 사진으로 찍으면 AI가 쉬운 한국어 또는 영어로 풀어 주는 배리어프리 모바일 서비스입니다. 외국인, 고령자, 발달장애인, 저문해자가 중요한 내용과 기한, 위험 신호, 해야 할 일을 한 화면에서 바로 확인하도록 만드는 것을 목표로 했습니다.

AI Re-Local 해커톤에 출품해 우리 팀은 3등 선도상을 받았습니다.

## 한눈에 보기

- 서비스명: 읽고 Ilgo
- 슬로건: 어려운 글, 대신 읽고 알려드릴게요.
- 대상 사용자: 외국인 노동자, 다문화 가정, 고령자, 발달장애인, 저문해자
- 핵심 문제: 어려운 행정 문서와 생활 안내문이 정보 격차와 불이익으로 이어지는 상황
- 해결 방식: 이미지 입력 -> AI 문서 해석 -> 쉬운 설명/위험도/핵심 카드/할 일 정리
- 해커톤 성과: 빛나는 인재 AI Re-Local 해커톤 3등 선도상

## 수상 및 보도

`읽고`는 2026년 6월 30일부터 7월 3일까지 제주WE호텔에서 열린 빛나는 인재 AI Re-Local 해커톤 창업캠프에서 만든 서비스 프로토타입입니다. 이번 해커톤은 AI 기술의 혜택에서 소외된 사람들을 위한 서비스 개발을 주제로 열렸으며 전국 5개 대학에서 온 학생 27명이 함께했습니다.

- [뉴스N제주 - AI로 지역문제 해결하는 청년인재 양성 '시동'](https://www.newsnjeju.com/news/articleView.html?idxno=291702)
- [파이낸셜뉴스 - 전국 대학생 27명 제주 모였다... AI로 돌봄·다문화·장애인 문제 풀었다](https://v.daum.net/v/20260707163544266)
- [한국대학신문 - 인덕대, '빛나는 인재 AI Re-Local 해커톤' 참가 전원 수상](https://news.unn.net/news/articleView.html?idxno=594458)

## 주요 기능

1. 문서 사진 분석
    - 종이 고지서, 안내문, 문자, 카카오톡 메시지 캡처를 올리면 AI가 내용과 맥락을 읽어냅니다.

2. 쉬운 한국어와 영어 설명
    - 어려운 표현은 쉬운 문장으로 바꿉니다. 영어가 필요한 사용자에게는 이해하기 쉬운 영어 안내로 보여줍니다.

3. 위험도 신호등
    - 스미싱, 사칭, 임금 체불, 기한 임박, 불이익 가능성을 초록/노랑/빨강 상태로 한눈에 보여줍니다.

4. 핵심 정보 카드
    - 날짜, 금액, 장소, 준비물, 연락처처럼 놓치면 안 되는 내용을 카드로 정리해 줍니다.

5. 할 일과 캘린더 연결
    - 사용자가 해야 할 일은 체크리스트로 보여줍니다. 중요한 일정은 바로 캘린더에 추가하도록 했습니다.

6. 음성 읽기와 답장 초안
    - 분석 결과를 TTS로 들려줍니다. 필요한 경우 문자나 카톡 답장 초안도 함께 보여줍니다.

## 기술 스택

### Frontend

- Flutter
- GetX
- Dio + Retrofit
- Freezed + Json Serializable
- image_picker
- flutter_tts
- add_2_calendar
- url_launcher
- share_plus
- shared_preferences
- google_fonts

### Backend

- Spring Boot
- Supabase PostgreSQL
- Railway
- Swagger UI

## 실행 방법

### 의존성 설치

```bash
flutter pub get
```

### 코드 생성

```bash
dart run build_runner build --delete-conflicting-outputs --force-jit
```

### Mock 데이터로 실행

```bash
flutter run
```

```bash
flutter run --dart-define=USE_MOCK=true
```

### 실서버로 실행

```bash
flutter run --dart-define=USE_MOCK=false --dart-define=BASE_URL=https://ilgo-api.up.railway.app/v1
```

## 프로젝트 구조

```text
lib/
├── core/          # 테마, 라우팅, 설정, 공통 유틸
├── data/          # API, 모델, 레포지토리, 서비스
├── modules/       # 화면 단위 기능
│   ├── onboarding/
│   ├── login/
│   ├── home/
│   ├── camera/
│   ├── analyze/
│   ├── result/
│   ├── library/
│   ├── help/
│   └── settings/
└── widgets/       # 재사용 UI 컴포넌트
```

## 디자인 시안

아래 이미지를 누르면 Figma 원본 시안으로 이동합니다.

[<img src="capture/figma_preview.png" width="100%" alt="읽고 Figma 디자인 미리보기">](https://www.figma.com/design/vQjZTBlx5Z7D09oWEGvpm7/%EC%9D%BD%EA%B3%A0?node-id=0-1&t=s6B1TvfSLgxVma8k-1)

## 발표 자료

원본 PDF: [읽고 발표 자료](capture/ilgo_presentation.pdf)

`capture/ilgo_presentation.pdf`도 README에서 바로 볼 수 있도록 페이지별 이미지로 렌더링했습니다.

<p>
<img src="capture/pdf_pages/ilgo_ppt_page-01.png" width="100%" alt="읽고 발표 자료 01쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-02.png" width="100%" alt="읽고 발표 자료 02쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-03.png" width="100%" alt="읽고 발표 자료 03쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-04.png" width="100%" alt="읽고 발표 자료 04쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-05.png" width="100%" alt="읽고 발표 자료 05쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-06.png" width="100%" alt="읽고 발표 자료 06쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-07.png" width="100%" alt="읽고 발표 자료 07쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-08.png" width="100%" alt="읽고 발표 자료 08쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-09.png" width="100%" alt="읽고 발표 자료 09쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-10.png" width="100%" alt="읽고 발표 자료 10쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-11.png" width="100%" alt="읽고 발표 자료 11쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-12.png" width="100%" alt="읽고 발표 자료 12쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-13.png" width="100%" alt="읽고 발표 자료 13쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-14.png" width="100%" alt="읽고 발표 자료 14쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-15.png" width="100%" alt="읽고 발표 자료 15쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-16.png" width="100%" alt="읽고 발표 자료 16쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-17.png" width="100%" alt="읽고 발표 자료 17쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-18.png" width="100%" alt="읽고 발표 자료 18쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-19.png" width="100%" alt="읽고 발표 자료 19쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-20.png" width="100%" alt="읽고 발표 자료 20쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-21.png" width="100%" alt="읽고 발표 자료 21쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-22.png" width="100%" alt="읽고 발표 자료 22쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-23.png" width="100%" alt="읽고 발표 자료 23쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-24.png" width="100%" alt="읽고 발표 자료 24쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-25.png" width="100%" alt="읽고 발표 자료 25쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-26.png" width="100%" alt="읽고 발표 자료 26쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-27.png" width="100%" alt="읽고 발표 자료 27쪽">
<img src="capture/pdf_pages/ilgo_ppt_page-28.png" width="100%" alt="읽고 발표 자료 28쪽">
</p>

## 앱 화면 캡처

`capture/` 폴더에 있는 앱 화면 캡처 27장을 모두 모았습니다.

<p>
<img src="capture/app_screen_01.png" width="190" alt="읽고 앱 화면 캡처 01">
<img src="capture/app_screen_02.png" width="190" alt="읽고 앱 화면 캡처 02">
<img src="capture/app_screen_03.png" width="190" alt="읽고 앱 화면 캡처 03">
<img src="capture/app_screen_04.png" width="190" alt="읽고 앱 화면 캡처 04">
<br>
<img src="capture/app_screen_05.png" width="190" alt="읽고 앱 화면 캡처 05">
<img src="capture/app_screen_06.png" width="190" alt="읽고 앱 화면 캡처 06">
<img src="capture/app_screen_07.png" width="190" alt="읽고 앱 화면 캡처 07">
<img src="capture/app_screen_08.png" width="190" alt="읽고 앱 화면 캡처 08">
<br>
<img src="capture/app_screen_09.png" width="190" alt="읽고 앱 화면 캡처 09">
<img src="capture/app_screen_10.png" width="190" alt="읽고 앱 화면 캡처 10">
<img src="capture/app_screen_11.png" width="190" alt="읽고 앱 화면 캡처 11">
<img src="capture/app_screen_12.png" width="190" alt="읽고 앱 화면 캡처 12">
<br>
<img src="capture/app_screen_13.png" width="190" alt="읽고 앱 화면 캡처 13">
<img src="capture/app_screen_14.png" width="190" alt="읽고 앱 화면 캡처 14">
<img src="capture/app_screen_15.png" width="190" alt="읽고 앱 화면 캡처 15">
<img src="capture/app_screen_16.png" width="190" alt="읽고 앱 화면 캡처 16">
<br>
<img src="capture/app_screen_17.png" width="190" alt="읽고 앱 화면 캡처 17">
<img src="capture/app_screen_18.png" width="190" alt="읽고 앱 화면 캡처 18">
<img src="capture/app_screen_19.png" width="190" alt="읽고 앱 화면 캡처 19">
<img src="capture/app_screen_20.png" width="190" alt="읽고 앱 화면 캡처 20">
<br>
<img src="capture/app_screen_21.png" width="190" alt="읽고 앱 화면 캡처 21">
<img src="capture/app_screen_22.png" width="190" alt="읽고 앱 화면 캡처 22">
<img src="capture/app_screen_23.png" width="190" alt="읽고 앱 화면 캡처 23">
<img src="capture/app_screen_24.png" width="190" alt="읽고 앱 화면 캡처 24">
<br>
<img src="capture/app_screen_25.png" width="190" alt="읽고 앱 화면 캡처 25">
<img src="capture/app_screen_26.png" width="190" alt="읽고 앱 화면 캡처 26">
<img src="capture/app_screen_27.png" width="190" alt="읽고 앱 화면 캡처 27">
</p>

## 안전 및 개인정보

- 실제 사용자의 고지서, 문자, 사진에는 이름, 연락처, 계좌번호, 주민번호, 주소 같은 민감정보가 들어갈 수 있습니다.
- 데모와 발표 자료에는 개인정보를 마스킹한 샘플 데이터를 사용하는 편이 안전합니다.
- AI 분석 결과는 사용자를 돕기 위한 보조 정보입니다. 법적·행정적 판단이 필요한 상황에서는 담당 기관이나 전문가 확인이 필요합니다.
