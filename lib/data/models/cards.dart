import 'package:freezed_annotation/freezed_annotation.dart';

part 'cards.freezed.dart';
part 'cards.g.dart';

/// Structured "at a glance" fields extracted from the document.
@freezed
abstract class Cards with _$Cards {
  const factory Cards({
    String? what,
    String? when,
    String? where,
    String? amount,
    String? deadline,
  }) = _Cards;

  factory Cards.fromJson(Map<String, dynamic> json) => _$CardsFromJson(json);
}
