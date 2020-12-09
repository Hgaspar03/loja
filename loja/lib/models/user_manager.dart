import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loja/models/user.dart';
import 'package:loja/common/helpers/firebase_errors.dart';

class UserManager extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;
  Firestore firestore = Firestore.instance;

  UserManager() {
    _loadCurrentUser();
  }

  bool _loading = false;
  bool get loading => _loading;
  bool get isLoggedIn => user != null;

  Future<void> signIn({User user, Function onFail, Function onSucess}) async {
    loading = true;
    try {
      AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      await _loadCurrentUser(firebaseUser: result.user);

      onSucess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }

    loading = false;
  }

  Future<void> signUp({User user, Function onFail, Function onSucess}) async {
    loading = true;
    try {
      AuthResult result = await auth.createUserWithEmailAndPassword(
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

  Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async {
    FirebaseUser currentUser = firebaseUser ?? auth.currentUser();
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').document(currentUser.uid).get();
      user = User.fromDocument(docUser);
      print(user.nome);
      notifyListeners();
    }
  }
}
