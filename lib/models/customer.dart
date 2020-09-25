import 'package:json_annotation/json_annotation.dart';

import 'generate/CustomerGenerate.dart';

@JsonSerializable(nullable: false)
class Customer {
  String username;
  String businessName;
  String email;
  String password;
  String role;

  Customer({String username, String businessName, String email, String password, String role});

  factory Customer.fromJson(Map<String, dynamic> json) => customerFromJson(json);
  Map<String, dynamic> toJson() => customerToJson(this);
}