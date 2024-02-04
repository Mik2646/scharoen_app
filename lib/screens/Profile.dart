import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scharoen_app/models/Employee.dart';
import 'package:scharoen_app/screens/auth.dart';
import 'package:scharoen_app/service/Authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late AuthenticationService auth;
  final _auth = FirebaseAuth.instance;
  late Stream<User?> user;
  late String userEmail = '';
  Employee? empoly = Employee();

  void getCurrentUserEmail() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      setState(() {
        userEmail = currentUser.email!;
      });
    } else {
      setState(() {
        userEmail = 'User is not logged in';
      });
    }
  }

  Future getUser(String? email) async {
    await FirebaseFirestore.instance
        .collection("employee")
        .where("email", isEqualTo: email)
        .get()
        .then((value) {
      for (var element in value.docs) {
        setState(() {
          empoly?.email = element['email'];
          empoly?.id = element['id'];
          empoly?.lastname = element['lastname'];
          empoly?.role = element['role'];
          empoly?.firstname = element['name'];
          empoly?.phone = element['phone'];
          empoly?.address = element['address'];
          empoly?.imageUrl = element['profile_img']
          ;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    auth = AuthenticationService();
    user = auth.authStateChanges();
    getCurrentUserEmail();
    getUser(userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('โปรไฟล์'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: Image.network(
                'https://cdn-icons-png.flaticon.com/128/126/126467.png',
                width: 27,
                height: 27,
                color: Color.fromARGB(255, 135, 135, 135),
              ),
              onPressed: () {
                _showDialoglogout(context);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
         CircleAvatar(
  backgroundColor: const Color.fromARGB(31, 255, 255, 255),
  radius: 50,
  backgroundImage: NetworkImage("${empoly?.imageUrl}"),
  // ใส่กรอบ
  foregroundColor: Colors.black, // สีของกรอบ
  child: Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.grey, // สีของกรอบ
        width: 1.5, // ความหนาของกรอบ
      ),
    ),
  ),
),

            SizedBox(height: 16),
            Text(
              "${empoly?.firstname} ${empoly?.lastname}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400
              ),
            ),
            Text(
              "${empoly?.role}",
              style: TextStyle(
                fontSize: 18,
                color: const Color.fromARGB(255, 130, 130, 130),
              ),
            ),
            SizedBox(height: 24),
            _buildInfoCard('รหัสพนักงาน', "${empoly?.id}"),
            _buildInfoCard('อีเมล์', "${empoly?.email}"),
            _buildInfoCard('เบอร์โทร', "${empoly?.phone}"),
            _buildInfoCard('ที่อยู่', "${empoly?.address}"),
            SizedBox(height: 24),
            SizedBox(
              height: 100,
            ),
            Text(
              "By s.charoen",
              style: TextStyle(color: const Color.fromARGB(255, 172, 172, 172)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        subtitle: Text(value),
      ),
    );
  }

  void _showDialoglogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text('ออกจากระบบ ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Authenticationsceen()),
                );
              },
              child: Text(
                'ยืนยัน',
                style:
                    TextStyle(color: const Color.fromARGB(255, 102, 102, 102)),
              ),
            ),
          ],
        );
      },
    );
  }
}
