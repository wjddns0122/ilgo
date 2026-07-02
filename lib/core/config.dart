/// Build-time configuration injected via `--dart-define`.
///
/// Real server (default):  flutter run
/// Force mock (offline demo): flutter run --dart-define=USE_MOCK=true
/// Override host:            flutter run --dart-define=BASE_URL=https://.../v1
class Config {
  const Config._();

  /// When true, the app serves data from `assets/mock/*.json` (offline demo).
  /// Defaults to false now that the backend is live.
  static const bool useMock = bool.fromEnvironment('USE_MOCK', defaultValue: false);

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
