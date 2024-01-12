import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'dart:io';
import 'package:scharoen_app/screens/auth.dart';
import 'package:scharoen_app/widget/ordermanufacture.dart';

class UploadImageScreen extends StatefulWidget {
  UploadImageScreen(
      {super.key,
      this.orderId,
      this.colorRoof,
      this.create_by,
      this.date,
      this.statusUser,
      this.statusorder});
  String? orderId;
  String? colorRoof;
  String? create_by;
  String? date;
  bool? statusUser;
  String? statusorder;
  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  bool isChecked = false;
  PlatformFile? image;
  UploadTask? uploadTask;
  String? imageUrl;
  CollectionReference? orderItem =
      FirebaseFirestore.instance.collection("oder_item");

  Future selectFile() async {
    final img = await FilePicker.platform.pickFiles();
    if (img == null) return;
    setState(() {
      image = img.files.first;
    });
  }

  Future<void> updateImage(String? imageurl) async {
    await orderItem?.where("id", isEqualTo: widget.orderId).get().then((value) {
      for (var element in value.docs) {
        if (element.exists) {
          orderItem
              ?.doc(element.id)
              .update({"image": imageurl, "orderitem_status": "completed"});
        } else {
          return;
        }
      }
    });
  }

  Future<void> uploadImage() async {
    if (image == null) return;
    final path = "image/${image?.name}";
    final file = File(image!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask?.whenComplete(() {});
    final imgUrl = await snapshot!.ref.getDownloadURL();
    setState(() {
      imageUrl = imgUrl.toString();
    });
    await updateImage(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        'หมายเลขออเดอร์ : ${widget.orderId}',
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
                        'วันที่ ${widget.date}',
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
                      top: 10,
                      child:     Text(
                            widget.statusorder.toString() == 'pending'
                                ? '•'
                                : widget.statusorder.toString() == 'inprogress'
                                    ? '•'
                                    : widget.statusorder.toString() ==
                                            'Successfullycompleted'
                                        ? '•'
                                        : '•',
                            style: TextStyle(
                              color:widget.statusorder.toString() == 'pending'
                                  ? Color.fromARGB(227, 232, 192, 47)
                                  : widget.statusorder.toString() == 'inprogress'
                                      ? Colors.orange
                                      : widget.statusorder.toString() ==
                                              'completed'
                                          ? const Color.fromARGB(
                                              255, 95, 218, 99)
                                          : Colors.black,
                              fontSize: 40.0,
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
                  image: DecorationImage(
                      image: FileImage(File(image != null
                          ? "${image!.path}"
                          : "image/roof.png"))),
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
                        onPressed: () async {
                          await selectFile();
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
        SizedBox(
          height: 70,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              activeColor: Color.fromARGB(255, 17, 175, 14),
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            Text(
              "ยืนยันการตรวจสอบ",
              style: TextStyle(color: const Color.fromARGB(255, 81, 81, 81)),
            ),
          ],
        ),
        SizedBox(height: 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'จาก ${widget.create_by}',
              style: TextStyle(
                color: Color(0xFF808080),
                fontSize: 14,
                fontFamily: 'Josefin Sans',
                height: 0,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              child: ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('ยืนยันการตรวจสอบ'),
                        content: Text('คุณต้องการยืนยันการตรวจสอบหรือไม่?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('ยกเลิก'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await uploadImage();

                              Navigator.of(context).pop(); // Close the dialog
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('สำเร็จ!'),
                                  backgroundColor:
                                      Colors.grey,
                                ),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Authenticationsceen()),
                              );
                            },
                            child: Text(
                              'ยืนยัน',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(
                      1), // ตั้งค่า elevation เป็น 0 (ไม่มีเงา)
                ),
                child: Text(
                  'Finish',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
