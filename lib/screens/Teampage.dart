import 'package:flutter/material.dart';
import 'package:scharoen_app/screens/addEmployee.dart';
import 'package:scharoen_app/widget/cardteam.dart';
import 'package:scharoen_app/widget/BottomMenu.dart';

class MyWidget extends StatelessWidget {
  String? role;
  MyWidget({super.key, this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('พนักงานทั้งหมด '),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: CardTeam(role: role),
      ),
      floatingActionButton: role == "ผู้บริหาร"
          ? FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddUserScreen()),
                );
              },
              child: Icon(
                Icons.add,
                color: Color.fromARGB(255, 136, 135, 135),
                size: 40,
              ), // ไอคอนบวก
            )
          : Text(""),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 130,
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
}
