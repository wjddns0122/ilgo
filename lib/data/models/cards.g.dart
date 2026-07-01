// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cards.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Cards _$CardsFromJson(Map<String, dynamic> json) => _Cards(
  what: json['what'] as String?,
  when: json['when'] as String?,
  where: json['where'] as String?,
  amount: json['amount'] as String?,
  deadline: json['deadline'] as String?,
);

Map<String, dynamic> _$CardsToJson(_Cards instance) => <String, dynamic>{
  'what': instance.what,
  'when': instance.when,
  'where': instance.where,
  'amount': instance.amount,
  'deadline': instance.deadline,
};
