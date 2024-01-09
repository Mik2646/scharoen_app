import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scharoen_app/models/OderItem.dart';
import 'package:scharoen_app/screens/Homepage.dart';
import 'package:scharoen_app/screens/Orderall.dart';
import 'package:scharoen_app/screens/Profile.dart';
import 'package:scharoen_app/screens/Teampage.dart';
import 'package:scharoen_app/screens/addOrder.dart';
import 'package:scharoen_app/screens/auth.dart';
import 'package:scharoen_app/service/database.dart';
import 'package:scharoen_app/models/Orderall.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ordermanufacture extends StatelessWidget {
  const ordermanufacture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Ordermanufacture? db = Ordermanufacture.instance;
    Stream<List<Orderitem>>? stream = db.getordermanufacture();

    return Container(
      child: StreamBuilder<List<Orderitem>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  // String dateTime = snapshot.data![index].date!.timeZoneName;
                  // DateTime date = DateTime.parse(dateTime);
                  // String formattedDate = DateFormat.yMd().format(date);
                  return Card(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, right: 10, left: 10),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'หมายเลขออเดอร์ : ' +
                                  snapshot.data![index].id.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                snapshot.data![index].orderitem_status
                                            .toString() ==
                                        'pending'
                                    ? '•'
                                    : snapshot.data![index].orderitem_status
                                                .toString() ==
                                            'inprogress'
                                        ? '•'
                                        : snapshot.data![index].orderitem_status
                                                    .toString() ==
                                                'Successfullycompleted'
                                            ? '•'
                                            : '•',
                                style: TextStyle(
                                  color: snapshot.data![index].orderitem_status
                                              .toString() ==
                                          'pending'
                                      ? Color.fromARGB(227, 232, 192, 47)
                                      : snapshot.data![index].orderitem_status
                                                  .toString() ==
                                              'inprogress'
                                          ? Colors.orange
                                          : snapshot.data![index]
                                                      .orderitem_status
                                                      .toString() ==
                                                  'Successfullycompleted'
                                              ? const Color.fromARGB(
                                                  255, 95, 218, 99)
                                              : Colors.black,
                                  fontSize: 40.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        //                      Positioned(
                        //   left: 250,
                        //   top: 70,
                        //   child: Container(
                        //     width: 90,
                        //     height: 90,
                        //     decoration: BoxDecoration(
                        //       image: DecorationImage(
                        //         image: AssetImage("images/roof.png"),
                        //         fit: BoxFit.fill,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(children: [
                            Text('เวลา ${snapshot.data![index].dates}'),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 214, 213, 213),

                                radius: 12,
                                // child: ClipOval(
                                //   child: Image.network(
                                //     'https://cdn-icons-png.flaticon.com/128/848/848043.png', // URL ของรูปภาพ
                                //     width: 100,
                                //     height: 100,
                                //     fit: BoxFit.cover,
                                //   ),),
                              ),
                              // Image.network(
                              //   "https://cdn-icons-png.flaticon.com/128/7033/7033331.png",
                              //   width: 100,
                              //   color: const Color.fromARGB(255, 139, 139, 137),
                              // ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "จาก ${snapshot.data![index].create_by}",
                                style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 151, 151, 151)),
                              ),
                              IconButton(
                                icon: Icon(Icons.navigate_next),
                                iconSize: 40,
                                color: Color.fromARGB(255, 112, 112, 112),
                                onPressed: () {
                                  // Navigate to the next page with the order ID
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NextPage(
                                        orderId: snapshot.data![index].id,
                                        // lengthCover:
                                        //     snapshot.data![index].length_cover,
                                        // colorRoof:
                                        //     snapshot.data![index].color_roof,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      ]),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  final String? orderId;
  final String? lengthCover;
  final String? colorRoof;
  CollectionReference orders = FirebaseFirestore.instance.collection("order");
  NextPage({Key? key, this.orderId, this.lengthCover, this.colorRoof})
      : super(key: key);

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation:
            2.5, // ตั้งค่า elevation เป็น 0.0 เพื่อป้องกันการปรากฎเงาด้านบน
        shadowColor:
            const Color.fromARGB(255, 0, 0, 0), // สีของเงาที่คุณต้องการ
        toolbarHeight: 70.0, // ตั้งค่าความสูงของ AppBar ตามที่ต้องการ
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // เปิด Drawer เมื่อปุ่มถูกกด
              },
            );
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              child: ClipOval(
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/128/848/848043.png', // URL ของรูปภาพ
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _auth.currentUser!.email.toString(),
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ), // ชื่อ
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 5),
            //   child: Text(
            //   isSwitchOn ? '•' : '•',
            //   style: TextStyle(
            //     color: isSwitchOn ? Colors.green : const Color.fromARGB(255, 103, 103, 103),
            //     fontSize: 38.0,
            //   ),
            //               ),
            // ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: Image.network(
                'https://cdn-icons-png.flaticon.com/128/4947/4947506.png',
                width: 37,
                height: 37,
                color: Color.fromARGB(255, 135, 135, 135),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Orderall()),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        // ส่วนของเมนูทางซ้ายสุด (Drawer)
        child: Column(
          children: [
            DrawerHeader(
              // decoration: BoxDecoration(
              //       color: Colors.grey,
              //     ),
              curve: Curves.fastEaseInToSlowEaseOut,

              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: 100,
                          child: Image.asset("images/logoscaroen.png")),
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(31, 255, 255, 255),
                        child: Image.network(
                            "https://cdn-icons-png.flaticon.com/128/848/848043.png"),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _auth.currentUser!.email.toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                      //        Text(
                      // isSwitchOn ? '•' : '•',
                      // style: TextStyle(
                      //   color: isSwitchOn ? Color(0xFF23E41F) : const Color.fromARGB(255, 103, 103, 103),
                      //   fontSize: 24.0,
                      // ),
                      //             ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              // leading: Icon(Icons.account_circle_outlined),
              title: Text('หน้าเเรก'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Authenticationsceen()),
                );
              },
            ),
            ListTile(
              // leading: Icon(Icons.account_circle_outlined),
              title: Text('โปรไฟล์'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
            ListTile(
              title: Text('พนักงาน'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyWidget()),
                );
              },
            ),
            ListTile(
              title: Text('ออเดอร์ทั้งหมด'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Orderall()),
                );
              },
            ),
            // ListTile(
            //   title: Text('เพิ่มรายการผลิต'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) {
            //         return addOrder(
            //           orderIds: orderId,
            //         );
            //       }),
            //     );
            //   },
            // ),
            SizedBox(
              height: 300,
            ),
            Text(
              "By s.charoen",
              style: TextStyle(color: const Color.fromARGB(255, 172, 172, 172)),
            )
          ],
        ),
      ),
      body: StreamBuilder(
          stream:
              orders.where("order_itemId", isEqualTo: "$orderId").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text("ไม่พบรายการ"),
              );
            }
            if (snapshot.hasData) {
              return Column(
                children: [
                  Container(
                    width: 383,
                    height: 696,
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
                            '${orderId}',
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
                            '⎯ สี${snapshot.data!.docs[0]['color_roof']}',
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
                        Positioned(
                          left: 25,
                          top: 166,
                          child: Text(
                            'รายการผลิต',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Josefin Sans',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 45,
                          top: 211,
                          child: Column(
                            children: [
                              ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 310,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '1.',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Josefin Sans',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                        Checkbox(
                                          value: true,
                                          onChanged: (bool? value) {
                                            value = true;
                                          },
                                          activeColor: Colors.green,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      bottomNavigationBar: Container(
        height: 80,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'จาก นายอัครชัย วารีรัตน์',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NextPage2()),
                      );
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(
                          1), // ตั้งค่า elevation เป็น 0 (ไม่มีเงา)
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NextPage2 extends StatelessWidget {
  final String? orderId;

  NextPage2({
    Key? key,
    this.orderId,
  }) : super(key: key);
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 2.5,
        shadowColor:
            const Color.fromARGB(255, 0, 0, 0), // สีของเงาที่คุณต้องการ
        toolbarHeight: 70.0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              child: ClipOval(
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/128/848/848043.png', // URL ของรูปภาพ
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _auth.currentUser!.email.toString(),
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ), // ชื่อ
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 5),
            //   child: Text(
            //   isSwitchOn ? '•' : '•',
            //   style: TextStyle(
            //     color: isSwitchOn ? Colors.green : const Color.fromARGB(255, 103, 103, 103),
            //     fontSize: 38.0,
            //   ),
            //               ),
            // ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: Image.network(
                'https://cdn-icons-png.flaticon.com/128/4947/4947506.png',
                width: 37,
                height: 37,
                color: Color.fromARGB(255, 135, 135, 135),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Orderall()),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        // ส่วนของเมนูทางซ้ายสุด (Drawer)
        child: Column(
          children: [
            DrawerHeader(
              // decoration: BoxDecoration(
              //       color: Colors.grey,
              //     ),
              curve: Curves.fastEaseInToSlowEaseOut,

              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: 100,
                          child: Image.asset("images/logoscaroen.png")),
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(31, 255, 255, 255),
                        child: Image.network(
                            "https://cdn-icons-png.flaticon.com/128/848/848043.png"),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _auth.currentUser!.email.toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                      //        Text(
                      // isSwitchOn ? '•' : '•',
                      // style: TextStyle(
                      //   color: isSwitchOn ? Color(0xFF23E41F) : const Color.fromARGB(255, 103, 103, 103),
                      //   fontSize: 24.0,
                      // ),
                      //             ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              // leading: Icon(Icons.account_circle_outlined),
              title: Text('หน้าเเรก'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Authenticationsceen()),
                );
              },
            ),
            ListTile(
              // leading: Icon(Icons.account_circle_outlined),
              title: Text('โปรไฟล์'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
            ListTile(
              title: Text('พนักงาน'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyWidget()),
                );
              },
            ),
            ListTile(
              title: Text('ออเดอร์ทั้งหมด'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Orderall()),
                );
              },
            ),
            // ListTile(
            //   title: Text('เพิ่มรายการผลิต'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) {
            //         return addOrder(
            //           orderIds: orderId,
            //         );
            //       }),
            //     );
            //   },
            // ),
            SizedBox(
              height: 300,
            ),
            Text(
              "By s.charoen",
              style: TextStyle(color: const Color.fromARGB(255, 172, 172, 172)),
            )
          ],
        ),
      ),
      body: ListView(children: [
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
                      '${orderId}',
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Orderall()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ]),
      bottomNavigationBar: Container(
        height: 80,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'จาก นายอัครชัย วารีรัตน์',
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
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text('ยกเลิก'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  // for (var i = 0; i < addorders.length; i++) {
                                  //   await addorderFirebase(
                                  //       addorders[i], widget.orderIds);
                                  // }
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('เพิ่มออเดอร์สำเร็จ'),
                                      backgroundColor:
                                          Color.fromARGB(255, 104, 255, 53),
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

            // ),
          ],
        ),
      ),
    );
  }
}
