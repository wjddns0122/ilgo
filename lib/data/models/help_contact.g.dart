// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HelpContact _$HelpContactFromJson(Map<String, dynamic> json) => _HelpContact(
  id: json['id'] as String,
  title: json['title'] as String,
  org: json['org'] as String?,
  phone: json['phone'] as String?,
  category: json['category'] as String?,
  emergency: json['emergency'] as bool? ?? false,
);

Map<String, dynamic> _$HelpContactToJson(_HelpContact instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'org': instance.org,
      'phone': instance.phone,
      'category': instance.category,
      'emergency': instance.emergency,
    };

_HelpContactsResponse _$HelpContactsResponseFromJson(
  Map<String, dynamic> json,
) => _HelpContactsResponse(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => HelpContact.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <HelpContact>[],
);

Map<String, dynamic> _$HelpContactsResponseToJson(
  _HelpContactsResponse instance,
) => <String, dynamic>{'items': instance.items};
