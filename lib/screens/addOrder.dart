import 'package:flutter/material.dart';
import 'package:scharoen_app/widget/addOrder.dart';

class addOrder extends StatefulWidget {
  const addOrder({super.key});

  @override
  State<addOrder> createState() => _addOrderState();
}

class _addOrderState extends State<addOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("เพิ่มรายการผลิต")),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Addorder(),
            ),
            Container(
              width: 60.0, // กำหนดความกว้างของปุ่ม

              child: ElevatedButton(
                onPressed: () {
                  print("ควย");
                  setState(() {
                    Addorder();
                    // counter++;
                  });
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 100,
          child: Column
          
          (
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      // ทำสิ่งที่คุณต้องการเมื่อแตะที่ปุ่ม
                    },
                    child: ElevatedButton(
                      onPressed: null, // ตัว ElevatedButton ไม่มีการให้การทำงาน
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(
                            0), // ตั้งค่า elevation เป็น 0 (ไม่มีเงา)
                      ),
                      child: Text('เพิ่มรายการครอบ'),
                    ),
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(
                      onPressed: null, // ตัว ElevatedButton ไม่มีการให้การทำงาน
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(
                            0), // ตั้งค่า elevation เป็น 0 (ไม่มีเงา)
                      ),
                      child: Text('ยืนยัน',style: TextStyle(color: Colors.green),),
                    ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "By s.charoen",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
