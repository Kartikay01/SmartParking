// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeslot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Timeslot _$TimeslotFromJson(Map<String, dynamic> json) => Timeslot()
  ..checkin = json['checkin'] as int
  ..checkout = json['checkout'] as int
  ..user = json['user'] as String
  ..worker = json['worker'] as String
  ..lotID = json['lotID'] as String
  ..timestamp = json['timestamp'] as int
  ..cost = json['cost'] as int
  ..vote = json['vote'] as int
  ..servicesArrayList = (json['servicesArrayList'] as List<dynamic>)
      .map((e) => e as int)
      .toList();

Map<String, dynamic> _$TimeslotToJson(Timeslot instance) => <String, dynamic>{
      'checkin': instance.checkin,
      'checkout': instance.checkout,
      'user': instance.user,
      'worker': instance.worker,
      'lotID': instance.lotID,
      'timestamp': instance.timestamp,
      'cost': instance.cost,
      'vote': instance.vote,
      'servicesArrayList': instance.servicesArrayList,
    };
