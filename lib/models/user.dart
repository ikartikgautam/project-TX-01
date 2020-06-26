import 'dart:convert';

class User {
  final String uid;

  User({this.uid});
}

class UserDetailsModel{

UserDetailsModel({this.uid,this.profileId,this.userName,this.email,this.phone});

  String uid;
  String profileId;
  String userName;
  String email;
  String phone;

getUserDetailsModelJSON(){
return jsonEncode({"uid":uid,"profileId":profileId,"userName":userName,"email":email,"phone":phone});
}

}