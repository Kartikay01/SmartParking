// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parkinglot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingLot _$ParkingLotFromJson(Map<String, dynamic> json) => ParkingLot()
  ..lotID = json['lotID'] as int
  ..location = json['location'] as String
  ..size = json['size'] as int
  ..price = json['price'] as int;

Map<String, dynamic> _$ParkingLotToJson(ParkingLot instance) =>
    <String, dynamic>{
      'lotID': instance.lotID,
      'location': instance.location,
      'size': instance.size,
      'price': instance.price,
    };
