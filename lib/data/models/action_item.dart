import 'package:freezed_annotation/freezed_annotation.dart';

part 'action_item.freezed.dart';
part 'action_item.g.dart';

/// A concrete to-do the user should carry out.
@freezed
abstract class ActionItem with _$ActionItem {
  const factory ActionItem({
    required String id,
    required String text,
    @Default(0) int priority,
    @JsonKey(name: 'is_done') @Default(false) bool isDone,
  }) = _ActionItem;

  factory ActionItem.fromJson(Map<String, dynamic> json) =>
      _$ActionItemFromJson(json);
}
