import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meetup/authServices/service.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  Authservices _auth = new Authservices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        backgroundColor: Color(0xff3b7a3e),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/login");
                  },
                  child: Icon(
                    Icons.login,
                    size: 26.0,
                  ),
                ),
                Text("Login", style: TextStyle(fontSize: 20)),
              ],
            ),
          )
        ],
      ),
      body: Column(children: [
        TextField(
          controller: email,
          decoration: InputDecoration(
            label: Text("Email"),
          ),
        ),
        TextField(
          controller: password,
          obscureText: true,
          decoration: InputDecoration(
            label: Text("Password"),
          ),
        ),
        RaisedButton(
          onPressed: () async {
            User? user =
                await _auth.registerWithEmailAndPass(email.text, password.text);

            if (user != null) {
              _auth.addUser(auth.currentUser!.uid, auth.currentUser!.email!);
              Navigator.pushNamed(context, '/login');
            }
          },
          child: Text("REGISTER"),
        )
      ]),
    );
  }
}
