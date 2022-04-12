import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:parkingapp/models/parkinglot.dart';
import 'package:parkingapp/models/timeslot.dart';
part 'timeslotlistdata.g.dart';

@JsonSerializable()
class TimeslotData {
  @JsonKey(name: "docID")
  late String docID;

  @JsonKey(name: "timeslots")
  late Timeslot timeslots;

  TimeslotData();

  String getdocID() {
    return docID;
  }

  factory TimeslotData.fromJson(Map<String, dynamic> json) =>
      _$TimeslotDataFromJson(json);
  Map<String, dynamic> toJson() => _$TimeslotDataToJson(this);
}
