import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trendingfood_flutter/models/customer.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/bottom_screen.dart';
import 'package:trendingfood_flutter/service/authentication_service.dart';
import 'package:trendingfood_flutter/service/customer_service.dart';
import 'package:trendingfood_flutter/service/service_locator.dart';
import 'package:trendingfood_flutter/utils/bottom_navigator.dart';
import 'package:trendingfood_flutter/utils/user_data.dart';
import 'package:trendingfood_flutter/widget/dialogs/connection_failure.dart';
import 'package:trendingfood_flutter/widget/dialogs/connection_failure.dart';
import 'package:trendingfood_flutter/widget/dialogs/dialog_helper.dart';

import 'package:trendingfood_flutter/widget/social_icons.dart';
import 'package:trendingfood_flutter/utils/custom_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {

  CustomerService customerService = locator<CustomerService>();
  AuthenticationService authenticationService = locator<AuthenticationService>();
  bool isLogin = true;
  bool isSignTap = false;
  Animation<double> loginSize;
  AnimationController loginController;
  AnimatedOpacity opacityAnimation;
  Duration animationDuration = Duration(milliseconds: 270);

  List<UserType> userTypes = UserType.getUserTypes();
  List<DropdownMenuItem<UserType>> dropDownMenuItems;
  UserType selectedUserType;

  @override
  void initState() {
    dropDownMenuItems = buildDropDownMenuItems(userTypes);
    selectedUserType = dropDownMenuItems[0].value;
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);

    loginController = AnimationController(vsync: this, duration: animationDuration);
    opacityAnimation = AnimatedOpacity(opacity: 0.0, duration: animationDuration);
  }

  List<DropdownMenuItem<UserType>> buildDropDownMenuItems(List userTypesList) {
    List<DropdownMenuItem<UserType>> items = List();
    for(UserType userType in userTypesList) {
      items.add(
          DropdownMenuItem(
            value: userType,
            child: Text(userType.type),
          )
      );
    }
    return items;
  }

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }



  Color gradientStart = Colors.deepPurple[700]; //Change start gradient color here
  Color gradientEnd = Colors.purple[500]; //Change end gradient color here

  Widget _buildLoginWidgets() {
    return Visibility(
      visible: !isSignTap,
      child: Container(
        padding: EdgeInsets.only(bottom: 62, top: 16),
        width: MediaQuery.of(context).size.width,
        height: loginSize.value,
        decoration: BoxDecoration(
          //color: Colors.deepOrangeAccent,
//          image: DecorationImage(
//            image: ExactAssetImage('assets/curved.png'),
//          ),
//          color: Colors.purple,
//          gradient: new LinearGradient(
//            colors: [Colors.red, Colors.cyan],
//          ),
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFF3366FF),
                  const Color(0xFF00CCFF),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
//          gradient: new LinearGradient(colors: [gradientStart, gradientEnd],
//              begin: const FractionalOffset(0.5, 0.0),
//              end: const FractionalOffset(0.0, 0.5),
//              stops: [0.0,1.0],
//              tileMode: TileMode.clamp
//          ),

            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(190),
                bottomRight: Radius.circular(190))),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedOpacity(
            opacity: loginController.value,
            duration: animationDuration,
            child: GestureDetector(
              onTap: isLogin ? null : () {
                loginController.reverse();

                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Container(
                child: Text(
                  'LOG IN'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginComponents() {
    final usernameLogin = TextEditingController();
    final passwordLogin = TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Visibility(
          visible: isLogin,
          child:
          Padding(
            padding: const EdgeInsets.only(left: 42, right: 42),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextField(
                    controller: usernameLogin,
                    style: TextStyle(color: Colors.white, height: 1),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32))
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordLogin,
                    style: TextStyle(color: Colors.white, height: 1),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key),
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(32)))),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Password is required';
                      }else{
                        return '';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: DropdownButton(
                    value: selectedUserType,
                    items: dropDownMenuItems,
                    onChanged: onChangeDropdownItem,
                  ),
                ),

                GestureDetector(
                  onTap: () async {
                    Customer customer = new Customer();
                    customer.username = usernameLogin.text;
                    customer.password = passwordLogin.text;
                    customer.role = selectedUserType.type;
//                    Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => BottomNavigatior(BottomScreen.home)),
//                      );
                    await authenticationService.loginUser(customer).then((value){
                      if(value == "success") {
                        showToast("Login Successfully");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BottomNavigatior(BottomScreen.home)),
                        );
                      }else{
                        DialogHelper.logFailure(context);
                      }
                    }).catchError((onError){
                      DialogHelper.connectionFailure(context);
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 16),
                    width: 300.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: _isSelected? Color(0xFF8E24AA) : Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      // child: ProgressButton()
                      child: new Text(
                        "Login Account",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white70,
                            fontFamily: 'mermaid',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }

  void showToast(String toastText){
    Fluttertoast.showToast(
        msg: toastText,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil().setWidth(120),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );

  bool _isSelected = false;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
    width: 16.0,
    height: 16.0,
    padding: EdgeInsets.all(2.0),
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2.0, color: Colors.black)),
    child: isSelected
        ? Container(
      width: double.infinity,
      height: double.infinity,
      decoration:
      BoxDecoration(shape: BoxShape.circle, color: Colors.black),
    )
        : Container(),
  );


  Widget _buildRegistercomponents() {
    final usernameRegister = TextEditingController();
    final businessRegister = TextEditingController();
    final emailRegister = TextEditingController();
    final passwordRegister = TextEditingController();
    return Padding(
      padding: EdgeInsets.only(
          left: 42,
          right: 42,
          top: 32,
          bottom: 32
      ),
      child: SingleChildScrollView(
        child: GestureDetector(
          onTap: (){
            setState(() {
              isSignTap = false;
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Text(
                  'Sign UP'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF2a3ed7)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(),
                child: TextFormField(
                  onTap: (){
                    setState(() {
                      isSignTap = true;
                    });
                  },
                  controller: usernameRegister,
                  style: TextStyle(color: Colors.black, height: 1),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.verified_user,
                      ),
                      hintText: 'User Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  controller: businessRegister,
                  style: TextStyle(color: Colors.black, height: 1),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.house,
                      ),
                      hintText: 'Business Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordRegister,
                  style: TextStyle(color: Colors.black, height: 1),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32)))
                  ),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Password is required';
                    }else{
                      return '';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  obscureText: true,
                  style: TextStyle(color: Colors.black, height: 1),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32)))),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Password is required';
                    }else if(value != passwordRegister.text){
                      return 'Password should be match';
                    }else{
                      return '';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: DropdownButton(
                  value: selectedUserType,
                  items: dropDownMenuItems,
                  onChanged: onChangeDropdownItem,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: GestureDetector(
                  onTap: () async {
                    Customer customer = new Customer();
                    customer.username = usernameRegister.text;
                    customer.businessName = businessRegister.text;
                    customer.email = emailRegister.text;
                    customer.password = passwordRegister.text;
                    customer.role = selectedUserType.type;
                    await customerService.createUser(customer).then((value){
                      if(value == "success") {
                        showToast("SignUp Successfully");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BottomNavigatior(BottomScreen.home)),
                        );
                      }else{
                        DialogHelper.logFailure(context);
                      }
                    }).catchError((onError){
                      DialogHelper.connectionFailure(context);
                    });
                  },
                  child: Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color(0XFF2a3ed7),
                        borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    child: Center(
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ) ,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,width: 750, height: 1334, allowFontScaling: true);
    double _defaultLoginSize = MediaQuery.of(context).size.height / 1.6;

    loginSize = Tween<double>(begin: _defaultLoginSize, end: 200).animate(
        CurvedAnimation(parent: loginController, curve: Curves.linear));

    return Scaffold(
      //backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/images/login.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedOpacity(
              opacity: isLogin ? 0.0 : 1.0,
              duration: animationDuration,
              child: Container(child: _buildRegistercomponents()),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              //color: isLogin && !loginController.isAnimating ? Colors.orangeAccent : Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: _defaultLoginSize/1.5,
              child: Visibility(
                visible: isLogin,
                child: GestureDetector(
                  onTap: () {
                    loginController.forward();
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: Text(
                            'Sign UP'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0XFF2a3ed7),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: ScreenUtil().setHeight(50)
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 12.0,
                            ),
                            GestureDetector(
                              onTap: _radio,
                              child: radioButton(_isSelected),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text("Remember me",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Poppins-Medium"
                                )
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(50),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            horizontalLine(),
                            Text("Social Login",
                                style: TextStyle(
                                    fontSize: 16.0, fontFamily: "Poppins-Medium")),
                            horizontalLine()
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(50),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SocialIcon(
                              colors: [
                                Color(0xFF102397),
                                Color(0xFF187adf),
                                Color(0xFF00eaf8),
                              ],
                              iconData: CustomIcons.facebook,
                              onPressed: () {},
                            ),
                            SocialIcon(
                              colors: [
                                Color(0xFFff4f38),
                                Color(0xFFff355d),
                              ],
                              iconData: CustomIcons.googlePlus,
                              onPressed: () {},
                            ),
                            SocialIcon(
                              colors: [
                                Color(0xFF17ead9),
                                Color(0xFF6078ea),
                              ],
                              iconData: CustomIcons.twitter,
                              onPressed: () {},
                            ),
                            SocialIcon(
                              colors: [
                                Color(0xFF00c6fb),
                                Color(0xFF005bea),
                              ],
                              iconData: CustomIcons.linkedin,
                              onPressed: () {},
                            )
                          ],
                        ),

                      ],
                    ),

                  ),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: loginController,
            builder: (context, child) {
              return _buildLoginWidgets();
            },
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2,
                child: Center(child: _buildLoginComponents()),
              )
          ),

        ],
      ),
    );
  }

  readValue(key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(key) ?? 0;
    prefs.remove(key);
    return value;
  }

  saveTextValue (key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  onChangeDropdownItem(UserType value) {
    setState(() {
      selectedUserType = value;
    });
  }
}
