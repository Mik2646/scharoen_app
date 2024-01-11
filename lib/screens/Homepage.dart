import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scharoen_app/models/Employee.dart';
import 'package:scharoen_app/screens/Orderall.dart';
import 'package:scharoen_app/screens/Profile.dart';
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
  int employeeCount = 0;
  bool isSwitchOn = false;
  String? role;
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
    getCount();
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
              isSwitchOn = element['status'];
              role = element['role'];
            });
          }
          print(role);
        });
      }
    } else {
      return;
    }
  }

  void getCount() async {
    await user?.where("status", isEqualTo: true).get().then((value) {
      setState(() {
        employeeCount = value.size;
      });
      print(value.size);
    });
  }

  // Future addOrderId() async {
  //   await FirebaseFirestore.instance
  //       .collection("oder_item")
  //       .get()
  //       .then((value) {
  //     if (value != null) {
  //       int size = value.size;
  //       size ??= 0;
  //       setState(() {
  //         orderId = "$counts$size";
  //       });
  //     }
  //   });
  //   var now = DateTime.now();
  //   var dfm = DateFormat('dd-MM-yyyy');
  //   String dateFormat = dfm.format(now);
  //   await FirebaseFirestore.instance.collection("oder_item").add({
  //     "id": "$orderId",
  //     "date": dateFormat,
  //     "orderitem_status": "pending",
  //     "create_by": fullname
  //   });
  // }
  @override
  void initState() {
    super.initState();
    getCount();
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
                      ?Color(0xFF23E41F)
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
                  MaterialPageRoute(
                      builder: (context) => MyWidget(
                            role: role,
                          )),
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
            //         // addOrderId();
            //         return addOrder(
            //           fullname: fullname,
            //         );
            //       }),
            //     );
            //   },
            // ),
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
        child: !isSwitchOn
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset("images/logoscaroen.png",color: const Color.fromARGB(255, 227, 227, 227),),
                    Text("ไม่ได้ทำงาน... ",style: TextStyle(color: Colors.grey),),
                  ],
                ),
              )
            : ordermanufacture(statusUser: isSwitchOn,username:fullname),
      ),
      //  Padding(
      //   padding: const EdgeInsets.all(18.0),
      //   child: StreamBuilder<Object>(
      //       stream: null,
      //       builder: (context, snapshot) {
      //         return ordermanufacture();
      //       }),
      // ),
floatingActionButton: role == "พนักงานขาย" || role == "ผู้บริหาร"
  ? FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            // addOrderId();
            return addOrder(
              fullname: fullname,
            );
          }),
        );
      },
      child: Icon(
        Icons.add,
        color: Color.fromARGB(255, 136, 135, 135),
        size: 40,
      )// ไอคอนบวก
    )
  : Text(""),

      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      bottomNavigationBar: BottomMenu(
          bottomMenuEmployeeCount: employeeCount,
          isSwitchOn: isSwitchOn,
          onSwitchChanged: (value) async {
            setState(() {
              isSwitchOn = value;
            });
            updateStatus(isSwitchOn);
          }),
    );
  }
}
