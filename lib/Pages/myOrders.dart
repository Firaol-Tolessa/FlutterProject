import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../authServices/service.dart';

class myOrders extends StatefulWidget {
  const myOrders({Key? key}) : super(key: key);
  _myOrdersState createState() => _myOrdersState();
}

class _myOrdersState extends State<myOrders> {
  Authservices service = new Authservices();
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<Widget> myOrders = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Column(children: myOrders),
        RaisedButton(onPressed: (() async {
          await service.signInWithEmailAndPass("abc@gmail.com", "1234567890");
          print(_auth.currentUser!.uid);
          await FirebaseFirestore.instance
              .collection('meetup')
              .doc('ORDERS')
              .collection(_auth.currentUser!.uid)
              .get()
              .then((value) {
            for (dynamic doc in value.docs) {
              print(doc.id);

              var obj = (doc.data() as Map<String, dynamic>);
              setState(() {
                var Uid;
                var Location;
                var Price;
                var Food;
                obj.forEach((key, value) {
                  if (key == 'uid') {
                    Uid = value;
                  } else if (key == 'location') {
                    Location = value;
                  } else if (key == 'food') {
                    Food = value;
                  } else if (key == 'price') {
                    Price = value;
                  }
                });
                myOrders.add(Container(
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80)),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.green, Colors.blue],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(80),
                                bottomRight: Radius.circular(80))),
                        padding:
                            EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Text("FOOD TYPE:$obj['id']"),
                            //
                            ListTile(
                              leading: Icon(
                                Icons.supervised_user_circle_rounded,
                                color: Colors.amber,
                                size: 80,
                              ),
                              title: Column(
                                children: [
                                  Text("FOOD:$Food"),
                                ],
                              ),
                              subtitle: Column(children: [
                                Text("LOCATION:$Location"),
                                Text("PRICE:$Price"),
                              ]),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            RaisedButton(
                                onPressed: (() {
                                  setState(() async {
                                    await FirebaseFirestore.instance
                                        .collection('meetup')
                                        .doc('ORDERS')
                                        .collection(_auth.currentUser!.uid)
                                        .get()
                                        .then((value) {
                                      for (var document in value.docs) {
                                        if (document.id == doc.id) {
                                          DocumentReference d =
                                              FirebaseFirestore.instance
                                                  .collection('meetup')
                                                  .doc('ORDERS')
                                                  .collection(
                                                      _auth.currentUser!.uid)
                                                  .doc(document.id);
                                          d.delete();
                                        }
                                      }
                                    });
                                  });
                                }),
                                child: Text("DELETE"))
                          ],
                        ),
                      )),
                ));
              });
            }
          });
        }))
      ]),
    );
  }
}
