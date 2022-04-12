import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:parkingapp/models/parkinglot.dart';
import 'package:parkingapp/models/timeslot.dart';
part 'parkinglotlistdata.g.dart';

@JsonSerializable()
class ParkingLotData {
  @JsonKey(name: "docID")
  late String docID;

  @JsonKey(name: "occupied")
  late bool occupied;

  @JsonKey(name: "parkingLot")
  late ParkingLot pl;

  @JsonKey(name: "totalcost")
  late int totalcost;

  ParkingLotData();

  String getdocID() {
    return docID;
  }

  factory ParkingLotData.fromJson(Map<String, dynamic> json) =>
      _$ParkingLotDataFromJson(json);
  Map<String, dynamic> toJson() => _$ParkingLotDataToJson(this);
}
