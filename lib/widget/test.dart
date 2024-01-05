// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class AddUserScreen extends StatefulWidget {
//   @override
//   _AddUserScreenState createState() => _AddUserScreenState();
// }

// class _AddUserScreenState extends State<AddUserScreen> {
//   TextEditingController ?_dataController = TextEditingController();
//    TextEditingController ?_nameController = TextEditingController();
//   TextEditingController ?_lastnameController = TextEditingController();
//   TextEditingController ?_emailController = TextEditingController();
//   TextEditingController ?_phoneController = TextEditingController();
//   TextEditingController ?_addressController = TextEditingController();
//   TextEditingController ?_passwordController = TextEditingController();
//   TextEditingController ?_roleController = TextEditingController();
//   bool _status = true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add User'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'ชื่อ'),
//             ),
//              TextField(
//               controller: _lastnameController,
//               decoration: InputDecoration(labelText: 'นามสกุล'),
//             ),
//              TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'อีเมลล์'),
//             ),
//              TextField(
//               controller: _phoneController,
//               decoration: InputDecoration(labelText: 'เบอร์โทร'),
//             ),
//              TextField(
//               controller: _addressController,
//               decoration: InputDecoration(labelText: 'ที่อยู่'),
//             ),
//              TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'รหัสผ่าน'),
//             ),
//              TextField(
//               controller: _roleController,
//               decoration: InputDecoration(labelText: 'ตำเเหน่ง'),
//             ),
//              _buildSwitch('Status', _status),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 addUser();
//               },
//               child: Text('Add User'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _buildSwitch(String label, bool value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Text(label),
//           Switch(
//             value: value,
//             onChanged: (newValue) {
//               setState(() {
//                 _status = newValue;
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> addUser() async {
//     final snapshot = await FirebaseFirestore.instance
//         .collection('employee')
//         .orderBy('datetime', descending: true)
//         .get();
//     var Id, count;
//     if (snapshot.docs.isEmpty) {
//       Id = "20241";
//       count = 1;
//     } else {
//       count = snapshot.docs.first['count'] + 1;
//       Id = '2024$count';
//     }

//     await FirebaseFirestore.instance.collection('employee').doc(Id).set({
      
//       'data': _dataController?.text, // ใส่ข้อมูลจาก TextField
//       'datetime': DateTime.now(),
//       'id': Id,
//     });
//   }
// }


