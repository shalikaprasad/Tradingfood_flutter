import 'package:trendingfood_flutter/models/customer.dart';

abstract class CustomerService {
  Future<String> createUser(Customer customer);
  Future<String> getUser(Customer customer);
}