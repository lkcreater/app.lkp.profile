import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class UrlApi{
  String _host = 'http://192.168.1.105/api/index.php?r=';
  int statusCode;
  String body;

  // ignore: missing_return
  String getUrl(String route)
  {
    return this._host + route;
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> Post(String url, var body) async {
    try {
      dynamic response = await http.post( this.getUrl('users/login'), body: body);
      this.statusCode = response.statusCode;
      this.body = response.body;
      //print('Response status: ${response.statusCode.runtimeType}');
      //print('Response body: ${response.body.runtimeType}');
    }catch(e) {
      ToastAlert('OS Error: Connection refused');
      print(e);
    }
  }

  // ignore: non_constant_identifier_names
  void ToastAlert(String msg){
    Fluttertoast.showToast(
        msg: '$msg',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}