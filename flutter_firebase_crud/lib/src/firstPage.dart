import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  createState() {
    return _FirstPage();
  }
}
  final databaseReference = FirebaseDatabase.instance.reference();

class _FirstPage extends State<FirstPage> {
  final _formKey = GlobalKey<FormState>();
  final redColor = const Color(0XFFE44236);
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: redColor,
            title: Text('CRUD OPERATIONS'),
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Enter Name', prefixIcon: Icon(Icons.ac_unit)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Enter Phone Number',
                      prefixIcon: Icon(Icons.phone)),
                ),
              ),
              RaisedButton(
                onPressed: (){
                  createRecord();
                },
                child: Text('CREATE'),
              ),
              RaisedButton(
                onPressed: (){
                  getData();
                },
                child: Text('READ'),
              ),
              RaisedButton(
                onPressed: (){
                  updateData();
                },
                child: Text('UPDATE'),
              ),
              RaisedButton(
                onPressed: (){
                  deleteData();
                },
                child: Text('DELETE'),
              )
            ],
          ),
        ));
  }

void createRecord(){
  databaseReference.child("3").set({
    'title': 'Mastering EJB',
    'description': 'Programming Guide for J2EE'
  });
  // databaseReference.child("4").set({
  //   'title': 'Flutter in Action',
  //   'description': 'Complete Programming Guide to learn Flutter'
  // });
}

void getData(){
  databaseReference.once().then((DataSnapshot snapshot) {
    print('Data : ${snapshot.value}');
  });
}

void updateData(){
    databaseReference.child('1').update({
      'description': 'J2EE complete Reference'
    });
  }

  void deleteData(){
    databaseReference.child('1').remove();
  }

}
