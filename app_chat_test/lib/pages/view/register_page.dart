import 'package:app_chat_test/pages/services/auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isObscureText = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _authService =AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  getBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
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
                "Register",
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
                  prefixIcon: const Icon(
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
                    _authService.registerWithEmailPassword( context,emailController.text.trim(), passwordController.text.trim());
                  }else{
                    print('email or passwork invalid');
                  }


                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: Colors.blue),
                  child: const Text("Register",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold,
                        fontSize: 20
                      )),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: (){

                },
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text("Back",
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
}
