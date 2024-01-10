import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:scharoen_app/models/Employee.dart';

class UploadImageScreen extends StatefulWidget {
  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  final TextEditingController _imageController = TextEditingController();

  PlatformFile? image;
  UploadTask? uploadTask;
  String? imageUrl;
  Future selectFile() async {
    final img = await FilePicker.platform.pickFiles();
    if (img == null) return;
    setState(() {
      image = img.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _imageController,
          decoration: InputDecoration(labelText: 'Image Path'),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: selectFile,
          child: Text('Pick Image'),
        ),
        // SizedBox(height: 16. 0),
        // if (employee.imageUrl != null)
        //   Image.file(
        //     employee.imageUrl!,
        //     height: 200,
        //     width: 200,
        //     fit: BoxFit.cover,
        //   ),
      ],
    );
  }
}
