/// 개발용 스위치. CLI(--dart-define) 없이 여기 값만 바꾸면 됨.
/// IDE에서 그냥 Run 눌러도 적용됨.
class DevFlags {
  /// true  → 앱 켤 때 무조건 온보딩 화면부터 보여줌 (완료 여부 무시).
  /// false → 정상 동작 (온보딩 완료했으면 홈으로).
  ///
  /// 온보딩 다 확인했으면 false 로 되돌리세요.
  static const bool forceOnboarding = true;
}
