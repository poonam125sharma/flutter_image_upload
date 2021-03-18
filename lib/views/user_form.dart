import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {

  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            Text('Upload Image in Flutter',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20,),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}