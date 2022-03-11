import 'dart:math';

import 'package:app_chat_test/pages/view/chat_page.dart';
import 'package:app_chat_test/pages/ultil/my_shared_prefere.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String notifi ='';
   Future signInWithEmailPassword(BuildContext context,String email, String password, Function mycallback) async {

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      print('Login sucess');
      toChatPage(email,  context);
      notifi='Login sucess';

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        notifi='No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        notifi='Wrong password provided for that user.';
      }
    }
      mycallback(notifi);


  }



   Future registerWithEmailPassword(BuildContext context,String email, String password) async {

    try {
      var res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      toChatPage(email, context);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }



  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  void toChatPage(String email, BuildContext context) {
    MySharedPrefere.setEmail(email);

    Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage()));
  }

}