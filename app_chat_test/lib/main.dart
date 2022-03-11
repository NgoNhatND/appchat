import 'dart:math';

import 'package:app_chat_test/pages/provider_my/login_provider.dart';
import 'package:app_chat_test/pages/view/chat_page.dart';
import 'package:app_chat_test/pages/view/login_page.dart';
import 'package:app_chat_test/pages/ultil/my_shared_prefere.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  final configurations = Configurations();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
    //   name: 'appchat',
      options: FirebaseOptions(
          apiKey: configurations.apiKey,
          appId: configurations.appId,
          messagingSenderId: configurations.messagingSenderId,
          projectId: configurations.projectId)

  );
  final prefs = await SharedPreferences.getInstance();
    // var email = MySharedPrefere.getEmail();
    var email = prefs.getString('mail');
    print('${email}---------');

  runApp(

      MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => LoginProvider()),
          ],
          child: MyApp( email1: email))
        // email==null?LoginPage():ChatPage()
        ,
      )
  );
}
class MyApp extends StatelessWidget {
   var email1 ;
   MyApp({Key? key, required this.email1}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: email1==null?LoginPage():ChatPage(),
    );
  }
}

class Configurations {
  static const _apiKey = "AIzaSyBq05TXDaOZimQXEQLAscm9PGRNacFKRds";
  static const _authDomain = "appchat-76c3c.firebaseapp.com";
  static const _projectId = "appchat-76c3c";
  static const _storageBucket = "appchat-76c3c.appspot.com";
  static const _messagingSenderId ="216068278464";
  static const _appId = "1:216068278464:android:be1e6cef320f4e24c44525";

//Make some getter functions
  String get apiKey => _apiKey;
  String get authDomain => _authDomain;
  String get projectId => _projectId;
  String get storageBucket => _storageBucket;
  String get messagingSenderId => _messagingSenderId;
  String get appId => _appId;
}

