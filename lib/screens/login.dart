import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rigg_i_gaming/Utils/utils.dart';
import 'package:rigg_i_gaming/main.dart';
import 'package:rigg_i_gaming/screens/ForgetPassword.dart';

class Login extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const Login({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
          title: Text("Login"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/loginbanner.jpg'),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                ),
              ),
              SizedBox(height: 4),
              TextField(
                controller: passwordController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    backgroundColor: Colors.purple),
                icon: Icon(Icons.lock_open, size: 32),
                label: Text(
                  'Login',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: SignIn,
              ),
              SizedBox(height: 20),
              GestureDetector(
                child: Text(
                  'Forget Password?',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16,
                  ),
                ),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ForgetPasswordPage()),
                ),
              ),
              SizedBox(height: 14),
              RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    text: "Don't have an account? ",
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                        text: 'Register',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              )
            ],
          ),
        ),
      );

  Future SignIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    // Navigator.of(context) not  working!
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
