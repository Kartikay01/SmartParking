import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'timeslot.g.dart';

@JsonSerializable()
class Timeslot {
  @JsonKey(name: "checkin")
  late int checkin;

  @JsonKey(name: "checkout")
  late int checkout;

  @JsonKey(name: "user")
  late String user;

  @JsonKey(name: "worker")
  late String worker;

  @JsonKey(name: "lotID")
  late String lotID;

  @JsonKey(name: "timestamp")
  late int timestamp;

  @JsonKey(name: "cost")
  late int cost;

  @JsonKey(name: "vote")
  late int vote;

  @JsonKey(name: "servicesArrayList")
  late List<int> servicesArrayList;

  Timeslot();
  factory Timeslot.fromJson(Map<String, dynamic> json) =>
      _$TimeslotFromJson(json);
  Map<String, dynamic> toJson() => _$TimeslotToJson(this);
}
