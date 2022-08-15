import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rigg_i_gaming/screens/NewBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rigg_i_gaming/screens/UserProfile.dart';

class HomePage extends StatelessWidget {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Stream<QuerySnapshot> users =
  FirebaseFirestore.instance.collection('BoxRecords').snapshots();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
          title: Text('All Box Records'),
          backgroundColor: Colors.purple,
          actions: [
            IconButton(
              onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserProfile()));
                },
              icon: Icon(Icons.supervised_user_circle),
            ),
            IconButton(
              onPressed: () =>
                FirebaseAuth.instance.signOut(),
              icon: Icon(Icons.logout),
            ),
          ]
      ),
      body: SingleChildScrollView(
          child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    height: mq.size.height,
              ),
              child: Container(
                    height: double.maxFinite,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: users,
                    builder: (
                        BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot,
                        ) {
                      if (snapshot.hasError){
                        return Text('Something went Wrong.');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('Loading');
                      }

                      final data = snapshot.requireData;

                      return ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            contentPadding: EdgeInsets.all(15),
                            title: Text(
                                '${data.docs[index]['Nickname']} \n\n'
                                'Post In:          ${data.docs[index]['PostIn']} \n'
                                'Post Out:       ${data.docs[index]['PostOut']} \n'
                                'Difference:    ${data.docs[index]['Differnce']} \n'
                                    'Box Total:       ${data.docs[index]['BoxTotal']}\n',
                              style: TextStyle(
                                color: CupertinoColors.black
                              ),
                            ),

                            subtitle: Text(
                                'Posted on ${data.docs[index]['Date']} \n'
                                    'at ${data.docs[index]['Time']}'
                            ),

                          );
                        },
                        itemCount: data.size,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: Colors.black,
                          );
                        },
                      );
                    },
                  )
              ),
            )
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NewBox()));
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
