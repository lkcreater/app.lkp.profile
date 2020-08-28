import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/screen_width_height.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import '../components/url_api.dart';
import 'dart:convert';

class LoginApp extends StatefulWidget {
  @override
  _LoginAppState createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  // ignore: non_constant_identifier_names
  TextEditingController TxtUsername = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController TxtPassword = new TextEditingController();

  bool isLoading = false;

  // ignore: non_constant_identifier_names
  Future<void> CheckAuthentication(String username, String password) async {
    // ignore: non_constant_identifier_names
    UrlApi Api = new UrlApi();
    await Api.Post('users/login', {
      'username': username,
      'password': password
    });
    setState(() {
      isLoading = false;
    });
    dynamic json = jsonDecode(Api.body);
    if(json['status'] == false){
      showAlertDialog(context, json['msg']);
    }else{
      print('${json['data']}');
      /*SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('token', json['data']['token']);
      await prefs.setInt('email', json['data']['email']);
      await prefs.setInt('id', json['data']['id']);
      await prefs.setInt('username', json['data']['username']);*/
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000070),Color(0xFF57b0fd)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        ),
        child: Column(
          children: [
            SizedBox(height: ScreenWidthHeight.height(20, context),),
            Text('Login Page', style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: ScreenWidthHeight.height(5, context),),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left:15 ,right: 0, bottom: 0),
                child: Container(
                  padding: EdgeInsets.only(top: 30, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(0),
                        topLeft: Radius.circular(100),
                        bottomLeft: Radius.circular(0),
                    )
                  ),
                  child: isLoading ? Center( child: CircularProgressIndicator(),) : SingleChildScrollView(
                    //padding: EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        SizedBox(height: ScreenWidthHeight.height(4, context),),
                        InputLoginPage(
                          controller: TxtUsername,
                          label: 'USERNAME',
                          icon: Icon(Icons.supervisor_account)
                        ),
                        SizedBox(height: ScreenWidthHeight.height(3, context),),
                        InputLoginPage(
                          controller: TxtPassword,
                          label: 'PASSWORD',
                          icon: Icon(Icons.vpn_key),
                          isPass: true
                        ),
                        SizedBox(height: ScreenWidthHeight.height(4, context),),
                        Text('Forgot your password'),
                        SizedBox(height: ScreenWidthHeight.height(4, context),),
                        ButtonLoginPage(context)
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding InputLoginPage({String label, Icon icon, bool isPass=false, TextEditingController controller}){
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 5), // changes position of shadow
              ),
            ]
        ),
        child: TextField(
          controller: controller,
          obscureText: isPass,
          decoration: InputDecoration(
            icon: icon!=null ? icon : null,
            labelText: label,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding ButtonLoginPage(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(left: 50, right: 50),
      child: RaisedButton(
        onPressed: () {
          if(TxtUsername.text.isEmpty || TxtPassword.text.isEmpty) {
            showAlertDialog(context, 'Please enter your Username and Password!');
            return null;
          }else{
            setState(() {
              isLoading = true;
            });
            CheckAuthentication(TxtUsername.text, TxtPassword.text);
          }
          return null;
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.all(0),
        child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width/1.2,
            child: Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                  ),
                )
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF000070),Color(0xFF57b0fd)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ]
            )
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context, String msg) {
    // set up the button
    Widget okButton = FlatButton(
      child: Container(
          width: 70,
          height: 30,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF000070),Color(0xFF57b0fd)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 5), // changes position of shadow
                ),
              ]
          ),
          child: Align(
              alignment: Alignment.center,
              child: Text("Ok", style: TextStyle(color: Colors.white), )
          )
      ),
      onPressed: () => Navigator.pop(context, false),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("$msg"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

