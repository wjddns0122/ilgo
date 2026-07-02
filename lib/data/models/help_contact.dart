import 'package:freezed_annotation/freezed_annotation.dart';

part 'help_contact.freezed.dart';
part 'help_contact.g.dart';

/// A support contact (GET /help-contacts).
@freezed
abstract class HelpContact with _$HelpContact {
  const factory HelpContact({
    required String id,
    required String title,
    String? org,
    String? phone,
    String? category,
    @Default(false) bool emergency,
  }) = _HelpContact;

  factory HelpContact.fromJson(Map<String, dynamic> json) =>
      _$HelpContactFromJson(json);
}

@freezed
abstract class HelpContactsResponse with _$HelpContactsResponse {
  const factory HelpContactsResponse({
    @Default(<HelpContact>[]) List<HelpContact> items,
  }) = _HelpContactsResponse;

  factory HelpContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$HelpContactsResponseFromJson(json);
}
