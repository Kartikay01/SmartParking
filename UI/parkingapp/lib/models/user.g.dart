// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..type = json['type'] as int
  ..phoneNumber = json['phoneNumber'] as String
  ..email = json['email'] as String
  ..firstname = json['firstname'] as String
  ..lastname = json['lastname'] as String
  ..address = json['address'] as String
  ..carnumber = json['carnumber'] as String
  ..username = json['username'] as String;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'type': instance.type,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'address': instance.address,
      'carnumber': instance.carnumber,
      'username': instance.username,
    };
