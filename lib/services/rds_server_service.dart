import 'package:flutter/material.dart';
import 'package:musestar/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String _baseUrl = 'https://ekklzd4mw7.execute-api.ap-south-1.amazonaws.com/dev';
//http://172.20.10.4:3000

UserDetailsModel _usersModel = UserDetailsModel();

class RdsServerService {
  postUserData(dynamic obj) async {
    dynamic response = '';
    await http
        .post(_baseUrl + '/postNewUser',
            headers: {"Content-Type": "application/json"},
            body: obj.getUserDetailsModelJSON())
        .then((res) => {response = res});
    return response.toString();
  }

  testConnection() async {
    await http.get(_baseUrl + '/getUsers').then((value) => print(value.body));
  }
}
