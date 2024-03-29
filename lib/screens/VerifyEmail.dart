import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rigg_i_gaming/Utils/utils.dart';
import 'package:rigg_i_gaming/screens/home.dart';

class VerifyEmailPage extends StatefulWidget {
  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    /// User need to be created before!
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified){
      sendVerificationEmail();
      
      timer = Timer.periodic(
          Duration(seconds: 3),
              (_) =>  checkEmailVerified(),
      );
    }
  }

  @override
  void dispose(){
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async{
    // call after email Verification!
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if(isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async{
    /// call after email verification!
    await FirebaseAuth.instance.currentUser!.reload();
    try{
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    }catch (e){
      Utils.showSnackBar(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomePage()
      : Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text("Verify Email"),
        ),
         body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'A verification email has been sent to your Email',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                // ElevatedButton.icon(
                //   style: ElevatedButton.styleFrom(
                //       minimumSize: Size.fromHeight(50),
                //       backgroundColor: Colors.purple),
                //   icon: Icon(Icons.email_outlined, size: 32),
                //   label: Text(
                //     'Resend Email',
                //     style: TextStyle(fontSize: 24),
                //   ),
                //   onPressed: sendVerificationEmail
                // ),
                SizedBox(height: 24),
                TextButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                  ),
                  child: Text("Cancel", style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () => FirebaseAuth.instance.signOut(),
                ),
              ]
            ),
         ),
      );
}
