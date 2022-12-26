import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meetup/Pages/Order.dart';
import 'package:meetup/Pages/home.dart';
import 'package:meetup/Pages/login.dart';
import 'package:meetup/Pages/meetup.dart';
import 'package:meetup/Pages/myOrders.dart';
import 'package:meetup/Pages/register.dart';
//de
import 'package:meetup/Pages/test.dart';
import 'package:meetup/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meetup/widgets/card.dart';

Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
    routes: {
      '/login': (context) => Login(),
      '/register': (context) => Register(),
      '/meetup': (context) => Home(),
      '/order': (context) => order(),
      '/home': (context) => Screen(),
      '/Screen': (context) => Screen(),
    },
  ));
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

//  RaisedButton(
//         onPressed: () async {
//           CollectionReference col =
//               FirebaseFirestore.instance.collection('col');
//           DocumentReference doc = col.doc('6QDobLTC4ZNsqnJYeKFM');
//           var city = <String, dynamic>{
//             'name': 'addisababa',
//             'country': 'ethiopia',
//             'population': 123456789
//           };
//           // col.add(city).then((DocumentReference d) => {print(d.id)});
//           // print(col.id);
//           // print(col.path);
//           // print(col.parameters);
//           //

//           // col.get().then((value) {
//           //   for (dynamic doc in value.docs) {
//           //     print(doc.id);
//           //     print(doc.data());
//           //   }
//           // });

//           //This can be used to create new orders
//           col.doc('orders').collection('users').add(city);

//           ///This can be used to access the orders
//           col.doc('orders').collection('users').get().then((value) {
//             for (dynamic doc in value.docs) {
//               print(doc.id);
//             }
//           });
//         },
//       ),
