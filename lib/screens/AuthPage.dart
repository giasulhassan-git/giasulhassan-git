import 'package:flutter/material.dart';
import 'package:rigg_i_gaming/screens/login.dart';
import 'package:rigg_i_gaming/screens/Register.dart';

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? Login(
          onClickedSignUp: toggle,
        )
      : Register(onClickedLogin: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
