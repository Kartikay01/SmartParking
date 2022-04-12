import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "type")
  late int type;

  @JsonKey(name: "phoneNumber")
  late String phoneNumber;

  @JsonKey(name: "email")
  late String email;

  @JsonKey(name: "firstname")
  late String firstname;

  @JsonKey(name: "lastname")
  late String lastname;

  @JsonKey(name: "address")
  late String address;

  @JsonKey(name: "carnumber")
  late String carnumber;

  @JsonKey(name: "username")
  late String username;

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
