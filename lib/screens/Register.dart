import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rigg_i_gaming/main.dart';
import 'dart:async';
import 'package:rigg_i_gaming/Utils/utils.dart';
import 'package:rigg_i_gaming/screens/home.dart';

class Register extends StatefulWidget {
  final VoidCallback onClickedLogin;

  const Register({
    Key? key,
    required this.onClickedLogin,
  }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text('Register'),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('assets/images/banner.jpg'),
                  ),
                  SizedBox(height: 40),
                  TextField(
                    controller: emailController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: 'Email Address'),
                  ),
                  TextFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
                        ? 'Enter min, 6 Characters!'
                        : null,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                        backgroundColor: Colors.purple),
                    icon: Icon(Icons.account_circle, size: 32),
                    label: Text(
                      'Register',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: RegisterNow,
                  ),
                  SizedBox(height: 24),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        text: "Already have an account? ",
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedLogin,
                            text: 'Login',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                ],
              ),
            )),
      );

  Future RegisterNow() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    // Navigator.of(context) not  working!
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
