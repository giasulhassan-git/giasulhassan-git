import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class NewBox extends StatefulWidget {
  const NewBox({Key? key}) : super(key: key);

  @override
  State<NewBox> createState() => _NewBoxState();
}

class _NewBoxState extends State<NewBox> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  String Date = DateFormat("MMMM, dd, yyyy").format(DateTime.now());
  String Time = DateFormat("hh:mm:ss a").format(DateTime.now());

  TextEditingController nickname = TextEditingController();
  TextEditingController CurrentIn = TextEditingController();
  TextEditingController PreviousIn = TextEditingController();
  TextEditingController CurrentOut = TextEditingController();
  TextEditingController PreviousOut = TextEditingController();

  TextEditingController Onehundred = TextEditingController();
  TextEditingController Fivehundred = TextEditingController();
  TextEditingController Onethousand = TextEditingController();

  int? currentin=0, previousin=0, Totalin=0  ;
  int? currentout=0, previousout=0, Totalout=0  ;
  int? difference=0 ;
  int? PostIn=0, PostOut=0 ;
  String Nickname= "loading" ;

  int? OHundred=0, FHundred=0, OThousand=0;
  int? OneHundred=0, FiveHundred=0, OneThousand=0;
  int? BoxTotal=0;

  OurIn() {
    setState(() {

      Nickname = nickname.text;

      currentin = int.parse(CurrentIn.text);
      previousin = int.parse(PreviousIn.text);
      currentout = int.parse(CurrentOut.text);
      previousout = int.parse(PreviousOut.text);

      OHundred = int.parse(Onehundred.text);
      FHundred = int.parse(Fivehundred.text);
      OThousand = int.parse(Onethousand.text);


      ///  Our Total In
      Totalin = (currentin! - previousin!) * 50;
      ///  Our Total Out
      Totalout = (currentout! - previousout!) * 50;
      ///  Total Difference is
      difference = Totalin! - Totalout! ;
      ///  Our Post In
      PostIn = currentin! - previousin! ;
      ///  Our Post Out
      PostOut = currentout! - previousout! ;

      /// Number of Players (100 Dollar)
      OneHundred = OHundred! * 100 ;
      /// Number of Players (100 Dollar)
      FiveHundred = FHundred! * 500 ;
      /// Number of Players (100 Dollar)
      OneThousand = OThousand! * 1000 ;

      /// Box Total
      BoxTotal = OneHundred! + FiveHundred! + OneThousand! ;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    MediaQuery.of(context).size.width;
    CollectionReference users =
    FirebaseFirestore.instance.collection('BoxRecords');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
            'Add New Box'
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10),
              TextFormField(
                controller: nickname,
                decoration: InputDecoration(
                  labelText: "Nickname",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: (value) {
                  Nickname = (value) ;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please add some value';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: CurrentIn,
                decoration: InputDecoration(
                  labelText: "Enter current In",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: (value) {
                  currentin = int.parse(value) ;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please add some value';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: PreviousIn,
                decoration: InputDecoration(
                  labelText: "Enter Previous In",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: (value) {
                  previousin = int.parse(value) ;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please add some value';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: CurrentOut,
                decoration: InputDecoration(
                  labelText: "Enter Current Out",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: (value) {
                  currentout = int.parse(value) ;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please add some value';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: PreviousOut,
                decoration: InputDecoration(
                  labelText: "Enter Previous Out",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: (value) {
                  previousout = int.parse(value) ;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please add some value';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: Onehundred,
                decoration: InputDecoration(
                  labelText: "Number of Players (100)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: (value) {
                  OneHundred = int.parse(value) ;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please add some value';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: Fivehundred,
                decoration: InputDecoration(
                  labelText: "Number of Players (500)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: (value) {
                  FiveHundred = int.parse(value) ;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please add some value';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: Onethousand,
                decoration: InputDecoration(
                  labelText: "Number of Players (1000)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: (value) {
                  OneThousand = int.parse(value) ;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please add some value';
                  }
                  return null;
                },
              ),


              const SizedBox(height: 10),
              ElevatedButton(onPressed: () {
                OurIn();
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  textStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),
                child: Text('Calculate'),
              ),

              SizedBox(height: 20),
              Text('Nickname is $Nickname'),
              Text('Total In : $Totalin'),
              Text('Total Out : $Totalout'),
              Text('Difference : $difference'),
              Text('Post In : $PostIn'),
              Text('Post Out : $PostOut'),
              Text('Total (One Hundred) : $OneHundred'),
              Text('Total (Five Hundred) : $FiveHundred'),
              Text('Total (One Thousand) : $OneThousand'),
              SizedBox(height: 20),
              Text('Box Total : $BoxTotal'),
              SizedBox(height: 60),

              Text("If you're done with Values, \n"
                  "Please Save them to Records."),
              SizedBox(height: 10),

              ElevatedButton(onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Data Saved to cloud \n'
                          'Please visit your Home Screen'),
                    ),
                  );

                  users
                      .add({
                    'Nickname' : Nickname,
                    'CurrentIn': currentin,
                    'PreviousIn': previousin,
                    'CurrentOut' : currentout,
                    'PreviousOut' : previousout,

                    'TotalIn' : Totalin,
                    'TotalOut' : Totalout,
                    'Differnce' : difference,
                    'PostIn' : PostIn,
                    'PostOut' : PostOut,
                    'Date' : Date,
                    'Time' : Time,
                    'Players(100)' : OneHundred,
                    'Players(500)' : FiveHundred,
                    'Players(1000)' : OneThousand,
                    'BoxTotal' : BoxTotal,
                    'UserEmail' : user.email,

                  }).then((value) => print('Data Saved successfully!'))
                      .catchError((error) => print('Failed to add data: $error'));
                }
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  textStyle: TextStyle(
                    fontSize: 16,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Save'),
              ),


            ],
          ),
        ),
      ),
    );
  }
}


