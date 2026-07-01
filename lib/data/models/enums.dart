/// Output mode requested from the engine.
///
/// `wire` is the exact string the API expects (snake_case), decoupled from the
/// Dart identifier so we never ship a camelCase value by accident.
enum OutputMode {
  easyKorean('easy_korean'),
  nativeLang('native');

  const OutputMode(this.wire);

  final String wire;

  static OutputMode fromWire(String value) => OutputMode.values.firstWhere(
        (m) => m.wire == value,
        orElse: () => OutputMode.easyKorean,
      );
}

/// Risk severity, rendered as a traffic light. Kept as strings on the model
/// for robustness (the AI may return an unexpected value → treat as [unknown]).
enum RiskLevel {
  green,
  yellow,
  red,
  unknown;

  static RiskLevel fromString(String? value) {
    switch (value) {
      case 'green':
        return RiskLevel.green;
      case 'yellow':
        return RiskLevel.yellow;
      case 'red':
        return RiskLevel.red;
      default:
        return RiskLevel.unknown;
    }
  }
}
