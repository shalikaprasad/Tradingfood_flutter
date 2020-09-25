import 'package:flutter/material.dart';
import 'package:trendingfood_flutter/data/district_data.dart';

class SearchField extends StatefulWidget{

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {

  List<DistrictCategory> districtCategory = DistrictCategory.getDistrictCategory();
  List<DropdownMenuItem<DistrictCategory>> dropDownMenuItems;

  DistrictCategory selectedDistrictCategory;

  onChangeDropdownItem(DistrictCategory value) {
      setState(() {
        selectedDistrictCategory = value;
      });
  }

  @override
  void initState() {
    dropDownMenuItems = buildDropDownMenuItems(districtCategory);
    selectedDistrictCategory = dropDownMenuItems[0].value;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
      child: Column(
        children: [
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            child: TextField(
              style:TextStyle(color: Colors.black, fontSize: 16.0),
              cursorColor: Theme.of(context).primaryColor,
              decoration:InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                suffixIcon: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    )
                ),
                border:InputBorder.none,
                hintText: "Search Foods"
              )
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Theme.of(context).primaryColor
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: DropdownButton(
                value: selectedDistrictCategory,
                items: dropDownMenuItems,
                onChanged: onChangeDropdownItem,
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<DropdownMenuItem<DistrictCategory>> buildDropDownMenuItems(List foodCategoryList) {
  List<DropdownMenuItem<DistrictCategory>> items = List();
  for(DistrictCategory foodCategory in foodCategoryList) {
    items.add(
        DropdownMenuItem(
          value: foodCategory,
          child: Text(foodCategory.type),
        )
    );
  }
  return items;
}