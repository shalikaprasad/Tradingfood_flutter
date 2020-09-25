import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendingfood_flutter/data/environment.dart';
import 'package:trendingfood_flutter/data/local_storage.dart';
import 'package:trendingfood_flutter/models/customer.dart';
import 'package:trendingfood_flutter/service/authentication_service.dart';
import 'package:trendingfood_flutter/service/service_locator.dart';

import '../customer_service.dart';

class CustomerServiceImpl extends CustomerService {

  String basePath = azure + '/user';

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Content-type': 'application/x-www-form-urlencoded'
  };

  AuthenticationService authenticationService = locator<AuthenticationService>();


  @override
  Future<String> createUser(Customer customer) async {
    final prefs = await SharedPreferences.getInstance();

    Customer defaultCustomer = new Customer();
    defaultCustomer.username = "prasad";
    defaultCustomer.password = "user";
    defaultCustomer.role = "Farmer";

    var result = authenticationService.loginUser(defaultCustomer).then((value) async {
      String url = basePath + "/createUser?access_token=" + prefs.getString("access_token");
      String bodyRequest = jsonEncode(customer);

      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };

      customerStorage.setItem('role', customer.role);
      customerStorage.setItem('username', customer.username);
      tokenStorage.setItem('access_token', authenticationService.getToken());

      prefs.setString('role', customer.role);
      prefs.setString('username', customer.username);

      var result2 = await post(url, headers: headers, body: bodyRequest).then((response){
        int statusCode = response.statusCode;
        if(statusCode == 200){
          return "success";
        } else{
          return null;
        }
      });
      return result2;
    });
    return result;

  }

  @override
  Future<String> getUser(Customer customer) async {
    final prefs = await SharedPreferences.getInstance();
    String bodyRequest = jsonEncode(customer);

    Response response = await post(basePath + "/getUser?access_token=" + prefs.getString("access_token"),headers: headers, body: bodyRequest);

    int statusCode = response.statusCode;
    if(statusCode == 200){
        return json.decode(response.body)['body'];
    }else{
      return null;
    }
  }
}