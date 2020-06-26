import 'package:firebase_auth/firebase_auth.dart';
import 'package:musestar/models/user.dart';
import 'package:musestar/services/rds_server_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RdsServerService _rds = RdsServerService();

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  Future signInAnnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Error => ' + e.toString());
      return null;
    }
  }

  Future SignInEmailPass(String email, String pass) async {
    try {
      AuthResult result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;
      _userFromFirebaseUser(user);
    } catch (e) {
      print('Error => ' + e.toString());
      return null;
    }
  }

  Future SignUpEmailPass(String email, String pass, String museId, String name,
      String phone) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      FirebaseUser user = result.user;

      UserDetailsModel _detailsModel = UserDetailsModel(
          uid: user.uid,
          profileId: museId,
          email: email,
          userName: name,
          phone: phone);

      String response = await _rds.postUserData(_detailsModel);

      if (response != null) {
        _userFromFirebaseUser(user);
      } else {
        print('ERROR => ' + response);
      }
    } catch (e) {
      print('Error => ' + e.toString());
      return null;
    }
  }

  Future SignOut() async {
    try {
      dynamic result = _auth.signOut();
      print('Sign out => ' + result.toString());
      return true;
    } catch (e) {
      print('Error => ' + e);
    }
  }
}
