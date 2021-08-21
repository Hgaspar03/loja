import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja/models/user.dart';
import 'package:loja/models/user_manager.dart';

class AdminUsersManager extends ChangeNotifier {
  List<LocalUser> users = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription _subscription;

  void updateUser(UserManager usermanager) {
    if (usermanager.admEnabled) {
      _subscription?.cancel();
      _listenToUsers();
    } else {
      users.cast();
      notifyListeners();
    }
  }

  void _listenToUsers() {
    _subscription =
        firestore.collection('users').snapshots().listen((snapshot) {
      users = snapshot.docs.map((e) => LocalUser.fromDocument(e)).toList();
      users
          .sort((a, b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));
    });

    notifyListeners();
  }

  List<String> get names => users.map((e) => e.nome).toList();

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
