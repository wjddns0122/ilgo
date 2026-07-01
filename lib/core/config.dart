/// Build-time configuration injected via `--dart-define`.
///
/// Run mock (default):  flutter run --dart-define=USE_MOCK=true
/// Run real server:      flutter run --dart-define=USE_MOCK=false \
///                                   --dart-define=BASE_URL=https://ilgo-api.up.railway.app/v1
class Config {
  const Config._();

  /// When true, the app serves data from `assets/mock/*.json`.
  static const bool useMock = bool.fromEnvironment('USE_MOCK', defaultValue: true);

  /// Backend base URL (only used when [useMock] is false).
  static const String baseUrl = String.fromEnvironment('BASE_URL', defaultValue: '');
}
