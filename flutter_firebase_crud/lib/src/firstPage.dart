import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  createState() {
    return _FirstPage();
  }
}

final databaseReference = FirebaseDatabase.instance.reference();

class _LoginData {
  String name = '';
  String phoneNumber = '';
}

class _FirstPage extends State<FirstPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final redColor = const Color(0XFFE44236);
  _LoginData _data = new _LoginData();
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
                      onSaved: (String value) {
                        this._data.name = value;
                      },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Enter Phone Number',
                      prefixIcon: Icon(Icons.phone)),
                      onSaved: (String value) {
                        this._data.phoneNumber = value;
                      },
                ),
              ),
              RaisedButton(
                onPressed: () {
                  this.createRecord();
                },
                child: Text('CREATE'),
              ),
              RaisedButton(
                onPressed: () {
                  getData();
                },
                child: Text('READ'),
              ),
              RaisedButton(
                onPressed: () {
                  updateData();
                },
                child: Text('UPDATE'),
              ),
              RaisedButton(
                onPressed: () {
                  deleteData();
                },
                child: Text('DELETE'),
              ),
            ],
          ),
        ));
  }

  void createRecord() {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      print('Printing the login data.');
      print('Email: ${_data.name}');
      print('Password: ${_data.phoneNumber}');
    }
    databaseReference.push().set({
      'Name': this._data.name,
      'Phone Number': this._data.phoneNumber
    });
  }

  void getData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

  void updateData() {
    databaseReference
        .child('1')
        .update({'description': 'J2EE complete Reference'});
  }

  void deleteData() {
    databaseReference.child('1').remove();
  }
}
