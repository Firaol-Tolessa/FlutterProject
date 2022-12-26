import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Authservices {
  List<String> accepts = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      final User? user = result.user;
      return user;
    } catch (e) {
      print("not found");
    }
  }

  Future signOut() async {
    Future result = _auth.signOut();
  }

  Future registerWithEmailAndPass(String email, String password) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User? user = result.user;
    return user;
  }

  Future signInWithEmailAndPass(String email, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    final User? user = result.user;
    return user;
  }

  Future addUser(String uid, String name) async {
    final CollectionReference user =
        FirebaseFirestore.instance.collection('meetup');
    return await user
        .doc('USERS')
        .collection(uid)
        .doc(Timestamp.now().toString())
        .set({'uid': uid, 'name': name});
  }

  Future addData(String uid, String food, String location, int price) async {
    final CollectionReference user =
        FirebaseFirestore.instance.collection('meetup');

    return await user.doc('ORDERS').collection(uid).add(<String, dynamic>{
      'uid': uid,
      'food': food,
      'location': location,
      'price': price,
    });
  }

  Future addAccept(String acceptedUser, String order) async {
    final DocumentReference user =
        FirebaseFirestore.instance.collection('meetup').doc('ACCEPTS');
    return await user
        .collection(order)
        .doc(acceptedUser)
        .set({'UserAccepted': acceptedUser});
  }

  Future getOrder(String uid) async {
    List<Widget> cards = [];
    await FirebaseFirestore.instance
        .collection('meetup')
        .doc('ORDERS')
        .collection(uid)
        .get()
        .then((value) {
      for (dynamic doc in value.docs) {
        print(doc.id);
        var obj = doc.data() as Map<String, dynamic>;
        obj.forEach((key, value) {
          print("$key : $value");
          cards.add(Card(
              color: Colors.amber,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text("$key : $value"),
              ])));
        });
      }
    });
    return cards;
  }

  Future<void> getData(CollectionReference _collectionRef) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.id).toList();

    accepts.addAll(allData);
    print(allData);
    //return accepts;
  }

  Widget _buildChip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Text(label[0].toUpperCase()),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
    );
  }
}
