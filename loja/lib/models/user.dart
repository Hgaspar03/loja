import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja/models/address.dart';

class LocalUser {
  LocalUser(
      {this.id, this.nome, this.email, this.password, this.conformPassword});
  LocalUser.fromDocument(DocumentSnapshot document) {
    id = document.id;
    nome = document.data()['name'] as String;
    email = document.data()['email'] as String;
    if (document.data().containsKey('address')) {
      address =
          Address.fromMap(document.data()['address'] as Map<String, dynamic>);
    }
  }

  String id;
  String nome;
  String email;
  String password;
  String conformPassword;
  bool admin = false;

  Address address;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  CollectionReference get cartRef => firestoreRef.collection('cart');

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': nome,
      'email': email,
      if (address != null) 'address': address.toMap(),
    };
  }

  void setAddress(Address address) {
    this.address = address;
    saveData();
  }
}
