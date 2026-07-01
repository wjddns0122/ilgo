import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'risk.freezed.dart';
part 'risk.g.dart';

/// A single risk flag (fraud / wage / deadline …) with a traffic-light level.
@freezed
abstract class Risk with _$Risk {
  const Risk._();

  const factory Risk({
    required String id,
    required String level,
    required String type,
    required String message,
  }) = _Risk;

  factory Risk.fromJson(Map<String, dynamic> json) => _$RiskFromJson(json);

  /// Parsed severity for UI. Unknown levels degrade to [RiskLevel.unknown]
  /// (rendered as yellow — never hide a possible risk).
  RiskLevel get levelEnum => RiskLevel.fromString(level);
}
