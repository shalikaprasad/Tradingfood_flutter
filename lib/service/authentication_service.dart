import 'package:trendingfood_flutter/models/customer.dart';

abstract class AuthenticationService {
  Future<String> loginUser(Customer customer);
  Future<String> getToken();
}