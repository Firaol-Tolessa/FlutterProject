import 'package:firebase_auth/firebase_auth.dart';
import 'package:meetup/authServices/service.dart';

class test {
  FirebaseAuth auth = FirebaseAuth.instance;
  Authservices service = new Authservices();
  void runing() {
    service.getOrder(auth.currentUser!.uid);
  }
}
