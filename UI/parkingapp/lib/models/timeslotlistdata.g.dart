// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeslotlistdata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeslotData _$TimeslotDataFromJson(Map<String, dynamic> json) => TimeslotData()
  ..docID = json['docID'] as String
  ..timeslots = Timeslot.fromJson(json['timeslots'] as Map<String, dynamic>);

Map<String, dynamic> _$TimeslotDataToJson(TimeslotData instance) =>
    <String, dynamic>{
      'docID': instance.docID,
      'timeslots': instance.timeslots,
    };
