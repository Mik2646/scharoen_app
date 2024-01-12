import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scharoen_app/screens/Homepage.dart';
import 'package:scharoen_app/screens/Teampage.dart';
import 'package:scharoen_app/service/Authentication.dart';
import 'package:scharoen_app/widget/cardteam.dart';

class EditUserScreen extends StatefulWidget {
  EditUserScreen(
      {super.key,
      required this.name,
      required this.address,
      required this.email,
      required this.lastname,
      required this.emId,
      required this.status,
      required this.phone,
      required this.role});
  String? name;
  String? emId;
  String? lastname;
  String? email;
  String? phone;
  String? address;
  String? role;
  bool? status;

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  TextEditingController? _nameController = TextEditingController();
  TextEditingController? _lastnameController = TextEditingController();
  TextEditingController? _emailController = TextEditingController();
  TextEditingController? _phoneController = TextEditingController();
  TextEditingController? _addressController = TextEditingController();

  TextEditingController? _roleController = TextEditingController();
  late AuthenticationService auth;

  bool? _status;
  String selectedRole = ''; // Variable to store the selected role
  void initState() {
    super.initState();
    setState(() {
      _status = widget.status;
      _nameController!.text = widget.name!;
      _addressController!.text = widget.address!;
      _emailController!.text = widget.email!;
      _lastnameController!.text = widget.lastname!;
      _phoneController!.text = widget.phone!;
      _roleController!.text = widget.role!;
    });
  }

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

    _roleController?.clear();
    _status = false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูลพนักงาน'),
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
            _buildSwitch('สถานะ', _status!),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (_validateFields()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.black26,
                      content: Text('แก้ไขสมาชิกสำเร็จ !'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                  await editUser().then((_) {
                    Navigator.popUntil(context, (routes) => routes.isFirst);
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
              child: Text('แก้ไขขข้อมูลสมาชิก'),
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
        _roleController?.text.isNotEmpty == true;
  }

  Future<void> editUser() async {
    CollectionReference? user =
        FirebaseFirestore.instance.collection("employee");
    await user.where("id", isEqualTo: widget.emId).get().then((value) {
      for (var element in value.docs) {
        user.doc(element.id).update({
          'name': _nameController?.text,
          'lastname': _lastnameController?.text,
          'address': _addressController?.text,
          'email': _emailController?.text,
          'phone': _phoneController?.text,
          'role': _roleController?.text,
          'status': _status,
          'datetime': DateTime.now(),
        });
      }
    });
  }
}
