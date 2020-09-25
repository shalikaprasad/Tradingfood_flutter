import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendingfood_flutter/data/environment.dart';
import 'package:trendingfood_flutter/data/local_storage.dart';
import 'package:trendingfood_flutter/models/customer.dart';
import 'package:trendingfood_flutter/service/authentication_service.dart';


class AuthenticationServiceImpl extends AuthenticationService {

  String basePath = azure_oauth;

//  const params = new URLSearchParams();
//  params.append('username', user.userName);
//  params.append('password', user.password);
//  params.append('grant_type', 'password');


//  'Content-Type': 'application/json; charset=UTF-8',

  @override
  Future<String> loginUser(Customer customer) async {
    final prefs = await SharedPreferences.getInstance();
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('msprasad:pin'));
    Map<String, String> headers = {
      'Authorization': 'Basic bXNwcmFzYWQ6cGlu',
      'Content-type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };

    var params = {
      "username": customer.username,
      "password": customer.password,
      "grant_type": 'password'
    };

    customerStorage.setItem('username', customer.username);

    prefs.setString('username', customer.username);
    prefs.setString('role', customer.role);

    String result = await post(basePath + "/oauth/token",headers: headers, body: params).then((response) async {
      customerStorage.setItem('role', customer.role);
      int statusCode = response.statusCode;
      if(statusCode == 200){
        print(json.decode(response.body));
        String token = json.decode(response.body)['access_token'];
        tokenStorage.setItem('access_token', token);
        prefs.setString('access_token', token);
       customerStorage.setItem('role', customer.role);
//        customerStorage.setItem('username', customer.username);
        String success =await get(azure + "/shop/getShop?access_token=" + token).then((response){
          int statusCode = response.statusCode;
          if(statusCode == 200){
            var shop = json.decode(response.body)['body'];
            customerStorage.setItem('shopId', shop['id'].toString());
            customerStorage.setItem('shopName', shop['name']);
            prefs.setString('shopId', shop['id'].toString());
            prefs.setString('shopName', shop['name']);
            prefs.setString('userId', shop['userId']);
            prefs.setString('shopImage', shop['pictureId']);
            return "success";
          }else{
            print('No Shop');
            return "success";
          }
        });
        return success;
      }else{
        return null;
      }
    });
    return result;
  }


  @override
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<Customer> gettingUser(Customer customer, String token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Content-type': 'application/x-www-form-urlencoded'
    };
    String bodyRequest = jsonEncode(customer);
    Customer response = await post(basePath + "/getUser?access_token=" + token,headers: headers, body: bodyRequest).then((value){
      int statusCode = value.statusCode;
      if(statusCode == 200){
        var user = json.decode(value.body)['body'];
        Customer customer = new Customer();
        customer.username = user['userName'];
        customer.role = user['role'];
        customer.businessName = user['businessName'];
        return customer;
      }else{
        return null;
      }
    });
    return response;
  }

}