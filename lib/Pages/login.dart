import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meetup/authServices/service.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  Authservices _auth = new Authservices();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Color(0xff3b7a3e),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/register");
                  },
                  child: Icon(
                    Icons.app_registration_rounded,
                    size: 26.0,
                  ),
                ),
                Text("Register", style: TextStyle(fontSize: 20)),
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
                await _auth.signInWithEmailAndPass(email.text, password.text);
            if (user != null) {
              Navigator.pushNamed(context, '/meetup');
            }
          },
          child: Text("SIGN IN"),
        )
      ]),
    );
  }
}
