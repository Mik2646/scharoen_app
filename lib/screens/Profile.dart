import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scharoen_app/screens/auth.dart';
import 'package:scharoen_app/service/Authentication.dart';



class Profile extends StatelessWidget {
  @override
 late AuthenticationService auth;
   final _auth = FirebaseAuth.instance;
 late Stream<User?> user;
   void initState() {
    auth = AuthenticationService();
    user = auth.authStateChanges();
  }
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Orderall()),
                  // );
              
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            CircleAvatar(
              backgroundColor: const Color.fromARGB(31, 255, 255, 255),
              radius: 50,
              backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/128/848/848043.png") // เปลี่ยนเป็นรูปโปรไฟล์ของคุณ
            ),
            SizedBox(height: 16),
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Software Developer',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24),
            _buildInfoCard('รหัสพนักงาน', '65309200'),
            _buildInfoCard('อีเมล์', _auth.currentUser!.email.toString()),
            _buildInfoCard('ชื่อ', ''),
            _buildInfoCard('นามสกุล', ''),
            SizedBox(height: 24),
            // ElevatedButton(
            //   onPressed: () {
            //     // กระทำเมื่อปุ่มถูกแตะ
            //   },
            //   child: Text('Edit Profile'),
            // ),
            
            SizedBox(height: 180,),
            Text("By s.charoen",style: TextStyle(color: const Color.fromARGB(255, 172, 172, 172)),)
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
          style: TextStyle(
            color: const Color.fromARGB(255, 94, 94, 94)

          ),
        ),
        subtitle: Text(value),
      ),
    );
  }
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
            Navigator.of(context).pop(); // ปิด Dialog
          },
          child: Text('ยกเลิก'),
        ),
        TextButton(
          onPressed:  ()async {
          
           FirebaseAuth.instance.signOut();
            
            Navigator.push(context,
     MaterialPageRoute(builder: (context) => Authenticationsceen()),
    );
          },
          child: Text('ยืนยัน',style: TextStyle(color: const Color.fromARGB(255, 102, 102, 102)),),
        ),
      ],
        
      );
    },
  );
}
