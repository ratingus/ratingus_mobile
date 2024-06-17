// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

School _$SchoolFromJson(Map<String, dynamic> json) => School(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      role: UserRole.fromJson(json['role'] as String),
      classDto: json['classDto'] == null
          ? null
          : ClassItem.fromJson(json['classDto'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SchoolToJson(School instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
      'classDto': instance.classDto,
    };
