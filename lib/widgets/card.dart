import 'package:flutter/material.dart';

class card extends StatefulWidget {
  const card({Key? key}) : super(key: key);
  _cardState createState() => _cardState();
}

class _cardState extends State<card> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  children: [Text("Food :"), Text("food descripton")],
                ),
                Row(
                  children: [Text("Price :"), Text("Price amount")],
                ),
                Row(
                  children: [Text("Location :"), Text("location descripton")],
                ),
                Center(
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text("Accept"),
                  ),
                ),
                Positioned(
                  top: 400,
                  left: 200,
                  child: Icon(Icons.verified_user),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
