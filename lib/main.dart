import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rigg_i_gaming/screens/AuthPage.dart';
import 'package:rigg_i_gaming/screens/VerifyEmail.dart';
import 'package:rigg_i_gaming/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rigg_i_gaming/Utils/utils.dart';
import 'package:rigg_i_gaming/screens/login.dart';

import 'Utils/utils.dart';

Future <void>main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(RiggApp());
}

Future initialization(BuildContext? context) async {
  ///Load Resources
  await Future.delayed(Duration(seconds: 2));
}

final navigatorKey = GlobalKey<NavigatorState>();

class RiggApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.purple,
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Something went Wrong!'));
              } else if (snapshot.hasData) {
                return VerifyEmailPage();
              } else {
                return (AuthPage());
              }
            }),
      );
}
