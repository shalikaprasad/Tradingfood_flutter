import 'package:trendingfood_flutter/data/assets.dart';

import '../models/category_model.dart';

class DistrictCategory {
  int id;
  String type;

  DistrictCategory(this.id, this.type);

  static List<DistrictCategory> getDistrictCategory() {
    return <DistrictCategory> [
      DistrictCategory(1, 'Kalutara'),
      DistrictCategory(2, 'Kandy'),
      DistrictCategory(3, 'Gampaha'),
      DistrictCategory(4, 'Kurunegala'),
      DistrictCategory(5, 'Colombo'),
      DistrictCategory(6, 'Mullaitivu'),
      DistrictCategory(7, 'Galle'),
      DistrictCategory(8, 'Anuradhapura'),
      DistrictCategory(9, 'Matara'),
      DistrictCategory(10, 'Polonnaruwa'),
      DistrictCategory(11, 'Badulla'),
      DistrictCategory(12, 'Mannar'),
      DistrictCategory(13, 'Hambantota'),
      DistrictCategory(14, 'Nuwara Eliya')

    ];
  }

}