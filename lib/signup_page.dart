import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/login_page.dart';
import 'package:http/http.dart' as http;

import 'models/user.dart';

class SignUpPage extends StatefulWidget {

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _roleIDController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _DOBController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Future<User>userSignUp(String email, String password, String fullname,String roleID, String phone, String address, String DOB, String gender) async {
    const url = "http://10.0.2.2:9195/account/register";
    Map<String, dynamic> requestPayload = {
      "email": email,
      "password": password,
      "fullname": fullname,
      "roleID": roleID,
      "phone": phone,
      "address": address,
      "DOB": DOB,
      "gender": gender,
    };

    final http.Response response = await http.post(url,
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode(requestPayload));

    if(response.statusCode == 201){
      return User.fromJson(json.decode(response.body));
    }else{
      throw Exception("Fail to sign up user");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Form(
            key: _key,
            child: Column(
              children: [
                Text(
                    'Sign up',
                    style: TextStyle(fontSize: 48),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,
                  validator: (val){
                    if(val!.isEmpty)
                      return 'Email Empty';
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Email",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: (val){
                    if(val!.isEmpty)
                      return 'Password Empty';
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Password",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.text,
                  validator: (val){
                    if(val!.isEmpty)
                      return "Confirm password Empty";
                    if(val != _passwordController.text)
                      return "Two password not match";
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    hintText: "Confirm Password",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _fullnameController,
                  validator: (val){
                    if(val!.isEmpty)
                      return 'Fullname Empty';
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Fullname",
                    hintText: "Fullname",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _roleIDController,
                  validator: (val){
                    if(val!.isEmpty)
                      return 'Empty';
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "roleID",
                    hintText: "roleID",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _phoneController,
                  validator: (val){
                    if(val!.isEmpty)
                      return 'Phone Empty';
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Phone",
                    labelText: "Phone",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _addressController,
                  validator: (val){
                    if(val!.isEmpty)
                      return 'Address Empty';
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Address",
                    labelText: "Adress",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _DOBController,
                  validator: (val){
                    if(val!.isEmpty)
                      return 'Day of Birthday Empty';
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Day Of Birthday",
                    labelText: "Day Of Birthday",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _genderController,
                  validator: (val){
                    if(val!.isEmpty)
                      return 'Gender Empty';
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Gender",
                    labelText: "Gender",
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
                        "Sign Up",
                        style: TextStyle(fontSize: 32, color: Colors.white)
                    ),
                    onPressed: (){
                      setState(() {
                        _key.currentState!.validate();
                        userSignUp(
                          _emailController.text,
                          _passwordController.text,
                          _fullnameController.text,
                          _roleIDController.text,
                          _phoneController.text,
                          _addressController.text,
                          _DOBController.text,
                          _genderController.text,
                        );
                      }
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(child: Text('Already have an account'),
                  onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
