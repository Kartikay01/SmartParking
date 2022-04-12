// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workerlistdata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerData _$WorkerDataFromJson(Map<String, dynamic> json) => WorkerData()
  ..docID = json['docID'] as String
  ..worker = Worker.fromJson(json['worker'] as Map<String, dynamic>);

Map<String, dynamic> _$WorkerDataToJson(WorkerData instance) =>
    <String, dynamic>{
      'docID': instance.docID,
      'worker': instance.worker,
    };
