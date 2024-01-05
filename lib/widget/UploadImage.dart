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

  Employee employee = Employee();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      employee.imageUrl = pickedFile != null ? File(pickedFile.path) : null;
      _imageController.text = employee.imageUrl != null ? employee.imageUrl!.path : '';
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
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 16.0),
            if (employee.imageUrl != null)
              Image.file(
                employee.imageUrl!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
          ],
        
      
    );
  }
}
