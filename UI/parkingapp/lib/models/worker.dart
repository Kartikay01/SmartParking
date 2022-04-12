import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:parkingapp/models/timeslot.dart';
part 'worker.g.dart';

@JsonSerializable()
class Worker {
  @JsonKey(name: "workername")
  late String workername;

  @JsonKey(name: "username")
  late String username;

  @JsonKey(name: "passwordString")
  late String passwordString;

  @JsonKey(name: "rating")
  late int rating;

  @JsonKey(name: "location")
  late String location;

  @JsonKey(name: "dateofjoining")
  late int dateofjoining;

  @JsonKey(name: "jobscompleted")
  late int jobscompleted;

  Worker();

  factory Worker.fromJson(Map<String, dynamic> json) => _$WorkerFromJson(json);
  Map<String, dynamic> toJson() => _$WorkerToJson(this);
}
