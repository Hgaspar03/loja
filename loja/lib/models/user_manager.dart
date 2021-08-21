import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loja/common/helpers/firebase_errors.dart';
import 'package:loja/models/user.dart';

class UserManager extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  LocalUser user;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserManager() {
    Firebase.initializeApp();
    _loadCurrentUser();
  }

  bool _loading = false;
  bool get loading => _loading;
  bool get isLoggedIn => user != null;

  Future<void> signIn(
      {LocalUser user, Function onFail, Function onSucess}) async {
    loading = true;
    try {
      UserCredential result = (await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password));

      await _loadCurrentUser(firebaseUser: result.user);

      onSucess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }

    loading = false;
  }

  Future<void> signUp(
      {LocalUser user, Function onFail, Function onSucess}) async {
    loading = true;
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      user.id = result.user.uid;
      this.user = user;
      await user.saveData();
      onSucess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }

    loading = false;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // ignore: deprecated_member_use
  Future<void> _loadCurrentUser({User firebaseUser}) async {
    User currentUser = firebaseUser ?? auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').doc(currentUser.uid).get();
      user = LocalUser.fromDocument(docUser);

      var docAdmin = await firestore.collection('admins').doc(user.id).get();

      if (docAdmin.exists) {
        user.admin = true;
      }

      notifyListeners();
    }
  }

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }

  bool get admEnabled => user != null && user.admin;
}
