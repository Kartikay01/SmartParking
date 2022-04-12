// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Worker _$WorkerFromJson(Map<String, dynamic> json) => Worker()
  ..workername = json['workername'] as String
  ..username = json['username'] as String
  ..passwordString = json['passwordString'] as String
  ..rating = json['rating'] as int
  ..location = json['location'] as String
  ..dateofjoining = json['dateofjoining'] as int
  ..jobscompleted = json['jobscompleted'] as int;

Map<String, dynamic> _$WorkerToJson(Worker instance) => <String, dynamic>{
      'workername': instance.workername,
      'username': instance.username,
      'passwordString': instance.passwordString,
      'rating': instance.rating,
      'location': instance.location,
      'dateofjoining': instance.dateofjoining,
      'jobscompleted': instance.jobscompleted,
    };
