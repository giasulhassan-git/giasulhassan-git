import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Stream<QuerySnapshot> users =
  FirebaseFirestore.instance.collection('BoxRecords').snapshots();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Profile'
        ),
        backgroundColor: Colors.purple,
      ),

      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Signed in as',
              style: TextStyle(
                  fontSize: 18
              ),
            ),
            Text(
              user.email!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18
              ),
            ),
            SizedBox(height: 49)
          ],
        ),
      )
    );
  }
}
