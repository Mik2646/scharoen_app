import 'package:flutter/material.dart';
import 'package:scharoen_app/widget/addOrder.dart';

class addOrder extends StatefulWidget {
  String? orderIds;
  addOrder({super.key, required this.orderIds});
  @override
  State<addOrder> createState() => _addOrderState();
}

class _addOrderState extends State<addOrder> {
  int amount = 1;
  @override
  Widget build(BuildContext context) {
    List<Addorder> addorders = List.generate(
        amount,
        (index) => Addorder(
              index: index,
            ));
    return Scaffold(
        appBar: AppBar(
          title: Text("เพิ่มรายการผลิต "),
        ),
        body: ListView.builder(
            itemCount: addorders.length,
            itemBuilder: (context, index) {
              return addorders[index];
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          width: 320,
          child: ElevatedButton(
            onPressed: () {
              print(amount);
              setState(() {
                amount++;
                // counter++;
              });
            },
            child: Icon(Icons.add),
          ),
        ),
        bottomNavigationBar: Container(
          height: 100,
          child: Column(
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
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: null, // ตัว ElevatedButton ไม่มีการให้การทำงาน
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(
                          0), // ตั้งค่า elevation เป็น 0 (ไม่มีเงา)
                    ),
                    child: Text(
                      'ยืนยัน',
                      style: TextStyle(color: Colors.green),
                    ),
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
