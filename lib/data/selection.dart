import 'package:trendingfood_flutter/data/local_storage.dart';

bool visibilityFloating(String roleString) {
  String role = customerStorage.getItem('role');
    if (role == roleString) {
      return false;
    } else {
      return true;
    }
}

bool visibilityAddFood(String shopRole) {
  String role = customerStorage.getItem('role');
  if (shopRole == 'Transporter') {
    return false;
  }
  else if (shopRole == 'Seller' && role == 'Seller') {
    return true;
  }
  else if (shopRole == 'Farmer' && role == 'Farmer') {
    return true;
  }
  else if (shopRole == 'Representative' && role == 'Representative') {
    return true;
  }
  else if (role == 'Buyer') {
    return false;
  }else {
    return false;
  }
}

bool visibilityFoodList(String shopRole) {
  String role = customerStorage.getItem('role');
  if (shopRole == 'Transporter' || shopRole == 'Buyer') {
    return false;
  } else {
    return true;
  }
}

bool visibilityFoodDetailsButton(String foodRole) {
  String role = customerStorage.getItem('role');
  if (role == 'Farmer' || role == 'Representative' || role == 'Transporter' || (foodRole == role && foodRole != 'Buyer')) {
    return false;
  } else {
    return true;
  }
}

bool visibilityFoodRequestButton(String foodRole) {
  String role = customerStorage.getItem('role');
  if (role == foodRole || role == 'Buyer' || role == 'Seller') {
    return false;
  } else {
    return true;
  }
}

bool visibilityFoodEditButton(String foodRole) {
  String role = customerStorage.getItem('role');
  if (role == foodRole && foodRole != 'Buyer') {
    return true;
  } else {
    return false;
  }
}