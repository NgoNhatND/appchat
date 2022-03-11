import 'package:shared_preferences/shared_preferences.dart';

class MySharedPrefere{
  // final prefs = await SharedPreferences.getInstance();

  static Future<void> setEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await  prefs.setString('mail', email);
  }
  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
     String? mail =  prefs.getString('mail')??'';
    return mail;
  }
  static Future<void> removeEmail() async {
    final prefs = await SharedPreferences.getInstance();
     await  prefs.remove('mail');

  }
  // String pt213(){
  //   return '';
  // }

}