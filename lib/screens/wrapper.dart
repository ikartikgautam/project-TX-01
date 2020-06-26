import 'package:flutter/material.dart';
import 'package:musestar/models/user.dart';
import 'package:musestar/screens/auth/auth.dart';
import 'package:musestar/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user==null){
      return Auth();
    }
    else{
      return Home();
    }
  }
}
