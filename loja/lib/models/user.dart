import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({this.id, this.email, this.password, this.conformPassword});
  User.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    nome = document.data['name'] as String;
    email = document.data['email'] as String;
  }

  String id;
  String nome;
  String email;
  String password;
  String conformPassword;
  bool admin = false;

  DocumentReference get firestoreRef =>
      Firestore.instance.document('users/$id');

  CollectionReference get cartRef => firestoreRef.collection('cart');

  Future<void> saveData() async {
    await firestoreRef.setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': nome,
      'email': email,
    };
  }
}
