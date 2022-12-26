import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meetup/Pages/test.dart';
import 'package:meetup/authServices/service.dart';
import 'package:meetup/widgets/card.dart';
import 'package:like_button/like_button.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  Authservices service = new Authservices();
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<Widget> cards = [];
  List<Widget> accepted = [];
  List<String> users = [];

  List<String> orders = [];

  bool isliked = false;
  dynamic data;
  Map<String, String> cardList = {};
  Map<String, String> test = {};
  List<Widget> items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Column(children: cards),
      RaisedButton(
        onPressed: (() async {
          DocumentReference order = await FirebaseFirestore.instance
              .collection('meetup')
              .doc('ORDERS');

          DocumentReference accepts = await FirebaseFirestore.instance
              .collection('meetup')
              .doc('ACCEPTS');

          await FirebaseFirestore.instance
              .collection('USERS')
              .get()
              .then((value) {
            for (var d in value.docs) {
              users.add(d.id);
            }
          });

          // This lists all the orders and appends them into orders list
          for (var user in users) {
            order.collection(user).get().then((value) {
              for (dynamic order in value.docs) {
                // print("${order.id}  :Found ");
                orders.add(order.id);
              }
            });
          }
          //print(order);

          for (String order in orders) {
            await accepts.collection(order).get().then((value) {
              //accepted user in the order
              for (dynamic user in value.docs) {
                // print(user.id + " : " + order);
                test.putIfAbsent(user.id, () => order);
                //test[user.id] = order;
              }
            });
          }
          // print("The orderer is : " +
          //     test['IiUevkWN73XSHYITobjMXeqtB1U2'].toString());
          // print(test.isEmpty);

          for (String user in users) {
            List<Widget> likes = [];
            order.collection(user).get().then((value) {
              for (dynamic docd in value.docs) {
                // print('Printing values for  : ${docd.id}');

                // cardList.addAll({docd.id: user});
                var obj = (docd.data() as Map<String, dynamic>);
                //    print(cardList);
                // var data = service.getData(FirebaseFirestore.instance
                //     .collection('meetup')
                //     .doc('ACCEPTS')
                //     .collection(docd.id));
                //

                setState(() {
                  var Uid;
                  var Location;
                  var Price;
                  var Food;
                  row(user);
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
                  if (user != _auth.currentUser!.uid) {
                    test.forEach((key, value) {
                      print("$key : $value");
                    });
                    test.forEach((key, value) {
                      //   print("Key $value : ${docd.id} ");
                      if (test.containsValue(docd.id)) {
                        print(value);
                        likes.add(Text(key));
                      } else {
                        print("@!");
                      }
                    });
                    cards.add(Card(
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
                            padding: EdgeInsets.symmetric(
                                vertical: 50, horizontal: 50),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Text("FOOD TYPE:$obj['id']"),
                                  //

                                  ListTile(
                                    onTap: () async {
                                      await service.addAccept(
                                          _auth.currentUser!.uid, docd.id);
                                      print(_auth.currentUser!.uid +
                                          ' orderd ' +
                                          docd.id);
                                      //access to the order.doc file
                                      // insert the current user id to the accepted tab

                                      isliked = !isliked;
                                      // print(isliked);
                                    },
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
                                  LikeButton(
                                    size: 20,
                                    likeCountAnimationDuration:
                                        Duration(milliseconds: 1000),
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      setState(() {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text('Accepts'),
                                            content: Column(children: likes),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Go Back'))
                                            ],
                                          ),
                                        );
                                      });
                                    },
                                    child: Text("Likes"),
                                  ),

                                  // DropdownButton(
                                  //   onTap: () {

                                  //   },
                                  //   isExpanded: true,
                                  //   icon: const Icon(Icons.keyboard_arrow_down),
                                  //   // Array list of items
                                  //   items: item.map((String item) {
                                  //     return DropdownMenuItem(
                                  //       value : test.containsValue(user),
                                  //       child: Text(items),
                                  //     );
                                  //   }).toList(),
                                  //   onChanged: (value) {},
                                  // ),
                                  // // Row(
                                  // //   children: row(docd.id),
                                  // )
                                ]))));
                  } else {
                    cards.add(Container(
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
                                padding: EdgeInsets.symmetric(
                                    vertical: 50, horizontal: 50),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Column(
                                        children: row(user),
                                      )
                                    ])))));
                  }
                });
              }
            });
            // print(doc.id);
            // FirebaseFirestore.instance.();
          }
        }),
      )
    ]));

    //     print(obj['price']);
    //   }
    // });
    // print(cards);
    // return ListView(
    //   children: cards,

    // );
    // }
  }

  List<Widget> row(String order) {
    test.forEach(
      (key, value) {
        if (value == order) {
          print("found $value  == $order");
          print("added $key");
          items.add(Text(key));
        }
      },
    );

    return items;
  }
}
