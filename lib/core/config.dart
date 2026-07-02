/// Build-time configuration injected via `--dart-define`.
///
/// Run:            flutter run
/// Override host:  flutter run --dart-define=BASE_URL=https://.../v1
class Config {
  const Config._();

  /// Backend base URL.
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://ilgo-backend-production.up.railway.app/v1',
  );

  /// Dev switch: force the onboarding screen even if it was already completed.
  /// Run: flutter run --dart-define=FORCE_ONBOARDING=true
  static const bool forceOnboarding =
      bool.fromEnvironment('FORCE_ONBOARDING', defaultValue: false);
}
