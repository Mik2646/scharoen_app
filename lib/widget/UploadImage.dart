import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:io';
import 'package:scharoen_app/models/Employee.dart';
import 'package:scharoen_app/screens/Orderall.dart';
import 'package:scharoen_app/widget/ordermanufacture.dart';

class UploadImageScreen extends StatefulWidget {
  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  final TextEditingController _imageController = TextEditingController();
  bool isChecked = false;
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
        Column(children: [
          Column(
            children: [
              Container(
                width: 383,
                height: 196,
                child: Stack(
                  children: [
                    Positioned(
                      left: 250,
                      top: 70,
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/roof.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 30,
                      child: Text(
                        'หมายเลขออเดอร์ :',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Josefin Sans',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 180,
                      top: 35,
                      child: Text(
                        '',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Josefin Sans',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      top: 79,
                      child: Text(
                        '⎯ สี',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Josefin Sans',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 352,
                      top: 40,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: ShapeDecoration(
                          color: Color(0xFFFDA726),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 292,
                height: 179,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFABABAB)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Image.network(
                          'https://cdn-icons-png.flaticon.com/128/7245/7245585.png',
                          width: 37,
                          height: 37,
                          color: Color.fromARGB(255, 135, 135, 135),
                        ),
                        onPressed: () {
                          selectFile();
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ]),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    PageTransition(
                      type: PageTransitionType
                          .leftToRight, // กำหนดประเภทของ transition
                      child: NextPage(),
                    ),
                  );
                },
                child: Text(
                  "รายการผลิตทั้งหมด",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: const Color.fromARGB(255, 134, 134, 134)),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 130,),
        Row
        (mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
           activeColor: Color.fromARGB(135, 118, 201, 46),
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            Text("ยืนยันการตรวจสอบ",style: TextStyle(color: const Color.fromARGB(255, 81, 81, 81)),),
          ],
        )
      ],
    );
  }
}
