import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> registerNewUser(
      String email, String fullName, String password) async {
    String res = 'something went wrong';

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection('buyers').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'profileImage': "",
        'email': email,
        'uid': userCredential.user!.uid,
        'pinCode': "",
        'locality': '',
        'city': '',
        'state': "",
      });

      res = 'success';
    } catch (e) {}

    return res;
  }
}
