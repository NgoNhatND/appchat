import 'package:app_chat_test/pages/model/data_future.dart';
import 'package:app_chat_test/pages/provider_my/login_provider.dart';
import 'package:app_chat_test/pages/ultil/my_dialog.dart';
import 'package:app_chat_test/pages/view/register_page.dart';
import 'package:app_chat_test/pages/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isObscureText = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _authService =AuthService();



  var data_test ='start future';
  getdata()async{
   await DataFuture.testFunction().then((value) {
       data_test=value;
      print('${data_test}--------------2222222');
    });
   print('${data_test}--------------333333');
  }
  @override
  void initState() {
    super.initState();
    //
    // DataFuture.testFunction().then((value) {
    //    data_test=value;
    //   print('${data_test}--------------111111');
    // }

    // );
    getdata();
    print('${data_test}--------------');


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: getBody(context),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  getBody(BuildContext context1) {
    final loginProvider = Provider.of<LoginProvider>(context1);
    String notifiMessage ='';
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.blue,
                  ),
                  labelStyle: TextStyle(color: Colors.blue),
                  label: Text('Email')),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.lightBlue,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                    child: Icon(
                        isObscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.blue),
                  ),
                  label: Text("Password"),
                  labelStyle: TextStyle(color: Colors.blue)),
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {},
                child: const Text("Forgot Password?",
                    style: TextStyle(
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w400,
                        fontSize: 14)),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: (){
                  if(emailController.text.isNotEmpty&&passwordController.text.isNotEmpty){
                    // _authService.signInWithEmailPassword(context, emailController.text.trim(), passwordController.text.trim());
                    loginProvider.logInUser(context, emailController.text.trim(), passwordController.text.trim());
                    emailController.clear();
                    passwordController.clear();
                    notifiMessage = loginProvider.notifi;
                  }else{
                    // print('email or passwork invalid');
                    notifiMessage = 'email or passwork invalid';
                    MyDialog.showMyDialog(context: context, message: 'email or passwork invalid');
                    // print('${notifiMessage}------loginpage');
                  }

                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: Colors.blue),
                  child: const Text("Login",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold,
                        fontSize: 20
                      )),
                ),
              ),
            ),
            widgetNotifi(loginProvider,notifiMessage),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: (){
                  print('helol');
                },
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text("SingUp",
                            style: TextStyle(
                                color: Colors.blue, fontWeight: FontWeight.normal,
                                fontSize: 16
                            )),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  widgetNotifi(LoginProvider loginProvider, String notifiMessage) {
    if(notifiMessage=='Login sucess'){
      return Container();
    }else{
      return Container(
        child: Text(notifiMessage,style: TextStyle(color: Colors.red),),

      );
    }
    // print('${loginProvider.notifi}---------loginPage');
    return Container();
  }
}
