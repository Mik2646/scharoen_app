import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  TextEditingController? _nameController = TextEditingController();
  TextEditingController? _lastnameController = TextEditingController();
  TextEditingController? _emailController = TextEditingController();
  TextEditingController? _phoneController = TextEditingController();
  TextEditingController? _addressController = TextEditingController();
  TextEditingController? _passwordController = TextEditingController();
  TextEditingController? _roleController = TextEditingController();
  bool _status = false;
  String selectedRole = ''; // Variable to store the selected role

  List<String> roles = [
    'ผู้บริหาร',
    'พนักงานผลิต',
    'พนักงานขาย'
  ]; // Predefined roles

  void _resetValues() {
    _nameController?.clear();
    _lastnameController?.clear();
    _emailController?.clear();
    _phoneController?.clear();
    _addressController?.clear();
    _passwordController?.clear();
    _roleController?.clear();
    _status = false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มพนักงาน'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: ListView(
          children: [
            Image.network(
              "https://cdn-icons-png.flaticon.com/128/10613/10613746.png",
              width: 50,
              height: 50,
              color: Colors.grey,
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'ชื่อ'),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              controller: _lastnameController,
              decoration: InputDecoration(labelText: 'นามสกุล'),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ),
            TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'อีเมลล์'),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next),
            TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'รหัสผ่าน'),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'เบอร์โทร'),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'ที่อยู่'),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            DropdownButtonFormField<String>(
              value: _roleController!.text.isNotEmpty
                  ? _roleController?.text
                  : null,
              items: roles.map((role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _roleController?.text = value!;
                });
              },
              decoration: InputDecoration(labelText: 'ตำเเหน่ง'),
            ),
            _buildSwitch('สถานะ', _status),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_validateFields()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.black26,
                      content: Text('เพิ่มสมาชิกสำเร็จ !'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                  addUser().then((_) {
                    _resetValues();
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.black26,
                      content:
                          Text('กรุณากรอกข้อมูลให้ครบทุกช่องก่อนเพิ่มผู้ใช้ !'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: Text('เพิ่มสมาชิก'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitch(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(label),
          Transform.scale(
            scale: 0.72,
            child: Switch(
              activeColor: Colors.green,
              value: value,
              onChanged: (newValue) {
                setState(() {
                  _status = newValue;
                });
              },
            ),
          ),
          Text(value ? ' เริ่มงาน' : ' ไม่ได้ทำงาน'),
        ],
      ),
    );
  }

  bool _validateFields() {
    // Check if all text controllers have non-empty text
    return _nameController?.text.isNotEmpty == true &&
        _lastnameController?.text.isNotEmpty == true &&
        _emailController?.text.isNotEmpty == true &&
        _phoneController?.text.isNotEmpty == true &&
        _addressController?.text.isNotEmpty == true &&
        _passwordController?.text.isNotEmpty == true &&
        _roleController?.text.isNotEmpty == true;
  }

  Future<void> addUser() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('employee')
        .orderBy('datetime', descending: true)
        .get();
    var Id, count;
    if (snapshot.docs.isNotEmpty) {
      count = snapshot.docs.first['count'] + 1;
      Id = '2024$count';
    } else {
      count = 1;
      Id = "20241";
    }

    await FirebaseFirestore.instance.collection('employee').doc(Id).set({
      'count': count,
      'id': Id,
      'name': _nameController?.text,
      'lastname': _lastnameController?.text,
      'address': _addressController?.text,
      'email': _emailController?.text,
      'password': _passwordController?.text,
      'phone': _phoneController?.text,
      'role': _roleController?.text,
      'status': _status,
      'datetime': DateTime.now(),
    });
  }
}
