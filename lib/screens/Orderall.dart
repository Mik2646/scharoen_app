import 'package:flutter/material.dart';
import 'package:scharoen_app/widget/orderall.dart';
import 'package:scharoen_app/widget/BottomMenu.dart';

class Orderall extends StatefulWidget {
  const Orderall({super.key});

  @override
  State<Orderall> createState() => _OrderallState();
}

class _OrderallState extends State<Orderall> {
  @override
  Widget build(BuildContext context) {
       return Scaffold(
      appBar: AppBar(
        
        title: Text('ออเดอร์ทั้งหมด'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
         actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
             icon: Image.network(
                'https://cdn-icons-png.flaticon.com/128/326/326740.png', 
                width: 35, 
                height: 35, 
                color: Color.fromARGB(255, 135, 135, 135),
                
              ),
              onPressed: () {
                 _showdDialog(context);
              
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: orderall(),
      ),
          
          bottomNavigationBar: bottomtexts()
         
            
          
          
        
      );
    
  }
}
void _showdDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
      title: Text('ค้นหาออเดอร์'),
      content: TextField(
        decoration: InputDecoration(
          hintText: '',
        ),
        keyboardType: TextInputType.number,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // ปิด Dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // ทำการค้นหา Order ด้วย ID ที่ผู้ใช้ป้อน
            // ดักเออเรอร์หรือทำประมวลผลต่อไปได้ตามที่ต้องการ
          },
          child: Text('Search',style: TextStyle(color: const Color.fromARGB(255, 102, 102, 102)),),
        ),
      ],
    );
    },
  );
}


class OrderSearchDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Search Order by ID'),
      content: TextField(
        decoration: InputDecoration(
          hintText: 'Enter Order ID',
        ),
        keyboardType: TextInputType.number,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // ปิด Dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // ทำการค้นหา Order ด้วย ID ที่ผู้ใช้ป้อน
            // ดักเออเรอร์หรือทำประมวลผลต่อไปได้ตามที่ต้องการ
          },
          child: Text('Search'),
        ),
      ],
    );
  }
}