// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parkinglotlistdata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingLotData _$ParkingLotDataFromJson(Map<String, dynamic> json) =>
    ParkingLotData()
      ..docID = json['docID'] as String
      ..occupied = json['occupied'] as bool
      ..pl = ParkingLot.fromJson(json['parkingLot'] as Map<String, dynamic>)
      ..totalcost = json['totalcost'] as int;

Map<String, dynamic> _$ParkingLotDataToJson(ParkingLotData instance) =>
    <String, dynamic>{
      'docID': instance.docID,
      'occupied': instance.occupied,
      'parkingLot': instance.pl,
      'totalcost': instance.totalcost,
    };
