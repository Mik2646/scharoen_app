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
        ],
      ),
    );
  }
}