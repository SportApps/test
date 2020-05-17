import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class User_Image_Picker extends StatefulWidget {
  User_Image_Picker(this.imagePickfn);

  final Function(File pickedImage) imagePickfn;

  @override
  _User_Image_PickerState createState() => _User_Image_PickerState();
}

class _User_Image_PickerState extends State<User_Image_Picker> {
  File _pickedImage;

  void _pickImage() async {
    // Here we open the camara, take a foto and sotre it inside the pickedImage variable.
    final pickedImage = await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150,);

    // We change the value of _pickedImage when the foto is taken.
    setState(() {
      _pickedImage = pickedImage;
    });
    widget.imagePickfn(pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 80,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        FlatButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.camera, color: Theme.of(context).primaryColor),
          label: Text(
            "Add Image",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
