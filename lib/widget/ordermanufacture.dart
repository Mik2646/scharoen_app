import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scharoen_app/models/OderItem.dart';
import 'package:scharoen_app/screens/Orderall.dart';
import 'package:scharoen_app/screens/Profile.dart';
import 'package:scharoen_app/screens/Teampage.dart';
import 'package:scharoen_app/screens/auth.dart';
import 'package:scharoen_app/service/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scharoen_app/widget/UploadImage.dart';

class ordermanufacture extends StatelessWidget {
  bool? statusUser;
  String? username;
  ordermanufacture({
    Key? key,
    this.statusUser,
    this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Ordermanufacture? db = Ordermanufacture.instance;
    Stream<List<Orderitem>>? stream = db.getordermanufacture();

    return Container(
      child: StreamBuilder<List<Orderitem>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("ไม่มีออเดอร์"),
            );
          }
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
                            Text('วันที่ ${snapshot.data![index].dates}'),
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
                                        username: username,
                                        statusUser: statusUser,
                                        orderId: snapshot.data![index].id,
                                        statusorder: snapshot
                                            .data![index].orderitem_status,
                                        create_by:
                                            snapshot.data![index].create_by,
                                        date: snapshot.data![index].dates,

                                        // lengthCover:
                                        //     snapshot.data![index].length_cover,
                                        // colorRoof:
                                        //     snapshot.data![index].color_roof,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                  onPressed: () async {
                                    CollectionReference? orderItem =
                                        FirebaseFirestore.instance
                                            .collection("oder_item");
                                    CollectionReference? orders =
                                        FirebaseFirestore.instance
                                            .collection("order");
                                    await orderItem
                                        .where("id",
                                            isEqualTo: snapshot.data![index].id)
                                        .get()
                                        .then((value) {
                                      for (var element in value.docs) {
                                        orderItem.doc(element.id).delete();
                                      }
                                    });
                                    await orders
                                        .where("order_itemId",
                                            isEqualTo: snapshot.data![index].id)
                                        .get()
                                        .then((value) {
                                      for (var element in value.docs) {
                                        orders.doc(element.id).delete();
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                        )
                      ]),
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  final String? orderId;
  bool isChecked = false;
  final String? lengthCover;
  final String? colorRoof;
  final bool? statusUser;
  final String? username;
  final String? statusorder;
  final String? create_by;
  final String? date;
  CollectionReference orders = FirebaseFirestore.instance.collection("order");
  NextPage(
      {Key? key,
      this.statusUser,
      this.orderId,
      this.lengthCover,
      this.colorRoof,
      this.statusorder,
      this.username,
      this.create_by,
      this.date})
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
                  ("${username}"),
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ), // ชื่อ
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                statusUser! ? '•' : '•',
                style: TextStyle(
                  color: statusUser!
                      ? Color(0xFF23E41F)
                      : const Color.fromARGB(255, 103, 103, 103),
                  fontSize: 38.0,
                ),
              ),
            ),
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
                        ("${username}"),
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        statusUser! ? '•' : '•',
                        style: TextStyle(
                          color: statusUser!
                              ? Color(0xFF23E41F)
                              : const Color.fromARGB(255, 103, 103, 103),
                          fontSize: 24.0,
                        ),
                      ),
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
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 28.0, right: 28, top: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "หมายเลขออเดอร์ : ${orderId}",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            statusorder.toString() == 'pending'
                                ? '•'
                                : statusorder.toString() == 'inprogress'
                                    ? '•'
                                    : statusorder.toString() ==
                                            'Successfullycompleted'
                                        ? '•'
                                        : '•',
                            style: TextStyle(
                              color: statusorder.toString() == 'pending'
                                  ? Color.fromARGB(227, 232, 192, 47)
                                  : statusorder.toString() == 'inprogress'
                                      ? Colors.orange
                                      : statusorder.toString() == 'completed'
                                          ? const Color.fromARGB(
                                              255, 95, 218, 99)
                                          : Colors.black,
                              fontSize: 40.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                              "⎯  ${snapshot.data!.docs[0]['color_roof']} ${snapshot.data!.docs[0]['size_roof']}  ${snapshot.data!.docs[0]['brand_roof']}"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 85,
                            height: 85,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/roof.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "รายการผลิต",
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 200,
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${index + 1}.    ${snapshot.data!.docs[index]['typeroof']} ${snapshot.data!.docs[index]['length_roof']} ซม. จำนวน  ${snapshot.data!.docs[index]['amount_roof']}  เเผ่น",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  MyCheckboxWidget(),
                                ],
                              );
                            }),
                      ),
                      Row(
                        children: [
                          Text(
                            "เพิ่มเติม",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 200,
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${snapshot.data!.docs[index]['note']} "),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                ),
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
                  'จาก ${create_by}',
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
                        MaterialPageRoute(
                            builder: (context) => NextPage2(
                                  orderId: orderId,
                                  username: username,
                                  statusUser: statusUser,
                                  colorRoof: colorRoof,
                                  date: date,
                                  create_by: create_by,
                                  statusorder: statusorder,
                                )),
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
  final bool? statusUser;
  final String? username;
  final String? colorRoof;
  final String? create_by;
  final String? date;
  final String? statusorder;
  NextPage2({
    Key? key,
    this.colorRoof,
    this.orderId,
    this.statusUser,
    this.username,
    this.create_by,
    this.date,
    this.statusorder,
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
                  ("${username!}"),
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ), // ชื่อ
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                statusUser! ? '•' : '•',
                style: TextStyle(
                  color: statusUser!
                      ? Color(0xFF23E41F)
                      : const Color.fromARGB(255, 103, 103, 103),
                  fontSize: 38.0,
                ),
              ),
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
                        ("${username}"),
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        statusUser! ? '•' : '•',
                        style: TextStyle(
                          color: statusUser!
                              ? Color(0xFF23E41F)
                              : const Color.fromARGB(255, 103, 103, 103),
                          fontSize: 24.0,
                        ),
                      ),
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
      body: UploadImageScreen(
          orderId: orderId,
          colorRoof: colorRoof,
          create_by: create_by,
          date: date,
          statusorder: statusorder),

      // ),
    );
  }
}

class MyCheckboxWidget extends StatefulWidget {
  @override
  _MyCheckboxWidgetState createState() => _MyCheckboxWidgetState();
}

class _MyCheckboxWidgetState extends State<MyCheckboxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Color.fromARGB(255, 17, 175, 14),
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
