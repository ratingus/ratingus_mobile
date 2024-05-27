// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JWT _$JWTFromJson(Map<String, dynamic> json) => JWT(
      id: (json['id'] as num).toInt(),
      login: json['login'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      patronymic: json['patronymic'] as String,
      school: json['school'] as String?,
      classId: (json['classId'] as num?)?.toInt(),
      className: json['className'] as String?,
      role: UserRole.fromJson(json['role'] as String),
      sub: json['sub'] as String,
      iat: (json['iat'] as num).toInt(),
      exp: (json['exp'] as num).toInt(),
    );

Map<String, dynamic> _$JWTToJson(JWT instance) => <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'name': instance.name,
      'surname': instance.surname,
      'patronymic': instance.patronymic,
      'school': instance.school,
      'role': instance.role,
      'classId': instance.classId,
      'className': instance.className,
      'sub': instance.sub,
      'iat': instance.iat,
      'exp': instance.exp,
    };
