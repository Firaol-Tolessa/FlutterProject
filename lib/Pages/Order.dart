import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meetup/authServices/service.dart';

class order extends StatefulWidget {
  const order({Key? key}) : super(key: key);
  _orderState createState() => _orderState();
}

class _orderState extends State<order> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Authservices service = new Authservices();
  TextEditingController food = new TextEditingController();
  TextEditingController price = new TextEditingController();
  TextEditingController location = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TextField(
          controller: food,
          decoration: InputDecoration(labelText: 'FOOD'),
        ),
        TextField(
          controller: price,
          decoration: InputDecoration(labelText: 'PRICE'),
        ),
        TextField(
          controller: location,
          decoration: InputDecoration(labelText: 'LOCATION'),
        ),
        RaisedButton(
          onPressed: () async {
            await service.addData(_auth.currentUser!.uid, food.text,
                location.text, int.parse(price.text));
            // service.getOrder(_auth.currentUser!.uid);
          },
          child: Text("SUBMIT"),
        )
      ]),
    );
  }
}
