import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:parkingapp/models/timeslot.dart';
part 'parkinglot.g.dart';

@JsonSerializable()
class ParkingLot {
  @JsonKey(name: "lotID")
  late int lotID;

  @JsonKey(name: "location")
  late String location;

  @JsonKey(name: "size")
  late int size;

  @JsonKey(name: "price")
  late int price;

  ParkingLot();

  int getLotID() {
    return lotID;
  }

  factory ParkingLot.fromJson(Map<String, dynamic> json) =>
      _$ParkingLotFromJson(json);
  Map<String, dynamic> toJson() => _$ParkingLotToJson(this);
}
