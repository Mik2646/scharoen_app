import 'package:flutter/material.dart';

class NextOrder extends StatefulWidget {
  const NextOrder({Key? key, required this.orderId}) : super(key: key);
 final String? orderId;
  @override
  State<NextOrder> createState() => _NextOrderState();
}

class _NextOrderState extends State<NextOrder> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}