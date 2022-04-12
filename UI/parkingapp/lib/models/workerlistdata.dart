import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:parkingapp/models/parkinglot.dart';
import 'package:parkingapp/models/timeslot.dart';
import 'package:parkingapp/models/worker.dart';
part 'workerlistdata.g.dart';

@JsonSerializable()
class WorkerData {
  @JsonKey(name: "docID")
  late String docID;

  @JsonKey(name: "worker")
  late Worker worker;

  WorkerData();

  String getdocID() {
    return docID;
  }

  factory WorkerData.fromJson(Map<String, dynamic> json) =>
      _$WorkerDataFromJson(json);
  Map<String, dynamic> toJson() => _$WorkerDataToJson(this);
}
