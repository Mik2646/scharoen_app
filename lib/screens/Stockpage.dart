import 'package:flutter/material.dart';

class Stockpage extends StatefulWidget {
  const Stockpage({super.key});

  @override
  State<Stockpage> createState() => _StockpageState();
}

class _StockpageState extends State<Stockpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("คลังเเผ่นเศษ"),
      ),
    );
  }
}