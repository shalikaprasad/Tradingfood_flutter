import 'package:trendingfood_flutter/models/customer.dart';

Customer customerFromJson(Map<String, dynamic> json) {
  return Customer(
    username: json['username'] as String,
    businessName: json['businessName'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    role: json['role'] as String
  );
}

Map<String, dynamic> customerToJson(Customer instance) => <String, dynamic>{
  'username': instance.username,
  'businessName': instance.businessName,
  'email': instance.email,
  'password': instance.password,
  'role': instance.role,
};