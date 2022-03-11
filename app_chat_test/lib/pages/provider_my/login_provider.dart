import 'package:app_chat_test/pages/ultil/my_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class LoginProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;
  String notifi='';

  int get count => _count;
  final AuthService authService = AuthService();

  void increment() {
    _count++;
    notifyListeners();
  }
  void logInUser(BuildContext context,String email,String password )async {
    authService.signInWithEmailPassword(context, email, password,(data){
      notifi=data;
        switch(data){
          case '':
            MyDialog.showMyDialog(context: context, message: 'email or passwork invalid');
            break;
          case 'Login sucess':
            // MyDialog.showMyDialog(context: context, message: 'email or passwork invalid');
            break;

        }
        if(data==''){
          MyDialog.showMyDialog(context: context, message: 'email or passwork invalid');
        }else if(data=='Login sucess'){
          //to screenChat
        }else{
          MyDialog.showMyDialog(context: context, message: data);
        }
    });
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }
}
