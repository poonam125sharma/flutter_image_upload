import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../helpers/db_helper.dart';
import '../models/image.dart';


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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(Icons.arrow_back, color: Colors.black,),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: null,
              child: SvgPicture.asset('assets/hamburger-menu.svg'),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            SvgPicture.asset('assets/image-upload.svg', width: MediaQuery.of(context).size.height / 1.4,),
            SizedBox(height: 20,),
            Text(
              'Upload Image',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20,),
            Text(
              'Click a picture or Browse the images you want to upload',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,),
            ),
            SizedBox(height: 20,),
            Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    // backgroundColor: Color(0xFFb6b1ff),
                    backgroundColor: Color(0xFF6159e6),
                    child: IconButton(
                      icon: SvgPicture.asset('assets/camera.svg'),
                      onPressed: null,
                      padding: EdgeInsets.all(8),
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    // backgroundColor: Color(0xFFb6b1ff),
                    backgroundColor: Color(0xFF6159e6),
                    child: IconButton(
                      icon: SvgPicture.asset('assets/gallery.svg'),
                      onPressed: null,
                      padding: EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
              /*child: Column(
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
              ),*/
            ),
          ],
        ),
      ),
    );
  }
}