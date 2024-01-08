import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scharoen_app/models/Employee.dart';
import 'package:scharoen_app/screens/Orderall.dart';
import 'package:scharoen_app/screens/Profile.dart';
import 'package:scharoen_app/screens/addEmployee.dart';
import 'package:scharoen_app/screens/addOrder.dart';
import 'package:scharoen_app/service/Authentication.dart';
import 'package:scharoen_app/widget/BottomMenu.dart';
import 'package:scharoen_app/screens/Teampage.dart';
import 'package:scharoen_app/widget/ordermanufacture.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    super.key,
    required AuthenticationService auth,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // final AuthenticationService auth;
  int employeeCount = 10;
  bool isSwitchOn = false;
  String? orderId;
  String? counts = "000";
  CollectionReference? user = FirebaseFirestore.instance.collection("employee");
  Employee? employees = Employee();
  String? fullname;
  void updateStatus(bool? status) async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      await user
          ?.where("email", isEqualTo: currentUser.email)
          .get()
          .then((value) {
        for (var element in value.docs) {
          setState(() {
            fullname = "${element['name']} ${element['lastname']}";
          });
          user?.doc(element.id).update({"status": status});
        }
      });
    }
  }

  void getUser() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      if (currentUser.email != null) {
        var email = currentUser.email;
        await user?.where("email", isEqualTo: email).get().then((value) {
          for (var element in value.docs) {
            setState(() {
              fullname = "${element['name']} ${element['lastname']}";
            });
          }
        });
      }
    } else {
      return;
    }
  }

  Future addOrderId() async {
    await FirebaseFirestore.instance
        .collection("oder_item")
        .get()
        .then((value) {
      setState(() {
        orderId = "$counts${value.size}";
      });
    });
    var now = DateTime.now();
    var dfm = DateFormat('dd-MM-yyyy');
    String dateFormat = dfm.format(now);
    await FirebaseFirestore.instance.collection("oder_item").add({
      "id": "$orderId",
      "date": dateFormat,
      "orderitem_status": "pending",
      "create_by": fullname
    });
  }

  void initState() {
    super.initState();
    getUser();
  }

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
                  fullname!,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ), // ชื่อ
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                isSwitchOn ? '•' : '•',
                style: TextStyle(
                  color: isSwitchOn
                      ? Colors.green
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
                  MaterialPageRoute(builder: (context) => const Orderall()),
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
                        fullname!,
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        isSwitchOn ? '•' : '•',
                        style: TextStyle(
                          color: isSwitchOn
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
            ListTile(
              title: Text('เพิ่มรายการผลิต'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    addOrderId();
                    return addOrder(
                      orderIds: orderId,
                    );
                  }),
                );
              },
            ),
            SizedBox(
              height: 350,
            ),
            Text(
              "By s.charoen",
              style: TextStyle(color: const Color.fromARGB(255, 172, 172, 172)),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ordermanufacture(),
      ),
      //  Padding(
      //   padding: const EdgeInsets.all(18.0),
      //   child: StreamBuilder<Object>(
      //       stream: null,
      //       builder: (context, snapshot) {
      //         return ordermanufacture();
      //       }),
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              addOrderId();
              return addOrder(
                orderIds: orderId,
              );
            }),
          );
        },
        child: Icon(
          Icons.add,
          color: Color.fromARGB(255, 136, 135, 135),
          size: 40,
        ), // ไอคอนบวก
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      bottomNavigationBar: BottomMenu(
          bottomMenuEmployeeCount: employeeCount,
          isSwitchOn: isSwitchOn,
          onSwitchChanged: (value) {
            setState(() {
              isSwitchOn = value;
            });
            updateStatus(isSwitchOn);
          }),
    );
  }
}
