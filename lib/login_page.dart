import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/signup_page.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  bool _isLoading = false;

  signIn(String email, pass) async{
    String url = "http://10.0.2.2:9195/account/login";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {"email": email, "password":pass};
    var jsonResponse;
    var res = await http.post(url, body: body);

    if(res.statusCode == 200){
      jsonResponse = json.decode(res.body);

      print("Response status: ${res.statusCode}");

      print("Response status: ${res.body}");

      if(jsonResponse != null){
        setState(() {
          _isLoading = false;
        });

        sharedPreferences.setString("token", jsonResponse['token']);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (Route<dynamic> route) => false);
      }
    }else{
      setState(() {
        _isLoading = false;
      });
      print("Response status: ${res.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Login", style: TextStyle(fontSize: 48),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(hintText: "Email"),
                          ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: TextField(
                              controller: _passController,
                              obscureText: true,
                              decoration: InputDecoration(hintText: "Password"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Text(
                          "Sign in",
                          style: TextStyle(fontSize: 32, color: Colors.white)
                      ),
                      onPressed: _emailController.text == "" || _passController.text == ""
                          ? null : (){
                        setState(() {
                          _isLoading = true;
                        });
                        signIn(_emailController.text, _passController.text);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(child: Text('Forgot Password'),
                    onPressed: (){},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FlatButton(child: Text('Sign Up'),
                    onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                    },
                  ),
                ],
              ),
        ),
      ),
        );
  }
}
