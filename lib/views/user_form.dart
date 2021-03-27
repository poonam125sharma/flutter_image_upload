import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';


class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {

  final _formKey = GlobalKey<FormState>();
  File file;
  final _picker = ImagePicker();
  final phpEndpoint = 'http://192.168.43.15/Flutter/Self/Image_Upload/api/php/image.php';

  Future _choose() async {
    PickedFile _pickedFile = await _picker.getImage(source: ImageSource.camera);
    print(_pickedFile);
    if(_pickedFile != null) {
      file = File(_pickedFile.path);
    }
  }

  void _upload() async {
    if(file == null) return;
    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;

    http.post(phpEndpoint, body: {
      'image': base64Image,
      'name': fileName
    }).then((res) {
      print(res.body);
      print(res.statusCode);
    }).catchError((err) {
      print(err);
    });
  }
  
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
                  RaisedButton(
                    onPressed: _choose,
                    child: Text('Choose Image'),
                  ),
                  SizedBox(height: 20,),
                  RaisedButton(
                    onPressed: _upload,
                    child: Text('Upload Image'),
                  ),
                  SizedBox(height: 20,),
                  file == null ? Text('No Image Selected') : Image.file(file)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}