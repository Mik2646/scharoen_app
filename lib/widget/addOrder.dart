import 'package:flutter/material.dart';

class Addorder extends StatefulWidget {
  int index;
  Addorder({super.key, required this.index});
  TextEditingController? _typeroofController = TextEditingController();
  TextEditingController? _colorroofController = TextEditingController();
  TextEditingController? _brand_roofController = TextEditingController();
  TextEditingController? _length_roofController = TextEditingController();
  TextEditingController? _amount_roofController = TextEditingController();

  List<String> typeroof = ['นอก', 'จิงโจ้', 'บลูสโคป'];
  List<String> colorroof = ['สีซิงค์', 'สีน้ำเงิน', 'สีเเดงมั่งมี'];
  List<String> numbers = List.generate(100, (index) => (index + 1).toString());

  String? _selectedRoofType;
  @override
  State<Addorder> createState() => _AddorderState();
}

class _AddorderState extends State<Addorder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: const Color.fromARGB(255, 192, 192, 192), // กำหนดสีของเส้น
              width: 2.0, // กำหนดความกว้างของเส้น
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text("${widget.index + 1}."),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 150,
                  height: 45,
                  child: DropdownButtonFormField<String>(
                    value: widget._colorroofController!.text.isNotEmpty
                        ? widget._colorroofController?.text
                        : null,
                    items: widget.colorroof.map((role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        widget._colorroofController?.text = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'สี',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 150,
                  height: 45,
                  child: DropdownButtonFormField<String>(
                    value: widget._brand_roofController!.text.isNotEmpty
                        ? widget._brand_roofController?.text
                        : null,
                    items: widget.typeroof.map((role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        widget._brand_roofController?.text = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'เเบรนด์',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("เเผ่นตรง"),
                Text("เเผ่นเรียบ"),
                Text("เเผ่นโค้ง"),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: Text(''),
                    value: widget._selectedRoofType == 'เเผ่นตรง',
                    onChanged: (value) {
                      setState(() {
                        widget._selectedRoofType = value! ? 'เเผ่นตรง' : null;
                      });
                      widget._typeroofController?.text =
                          widget._selectedRoofType ?? '';
                    },
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: Text(''),
                    value: widget._selectedRoofType == 'เเผ่นเรียบ',
                    onChanged: (value) {
                      setState(() {
                        widget._selectedRoofType = value! ? 'เเผ่นเรียบ' : null;
                      });
                      widget._typeroofController?.text =
                          widget._selectedRoofType ?? '';
                    },
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: Text(''),
                    value: widget._selectedRoofType == 'เเผ่นโค้ง',
                    onChanged: (value) {
                      setState(() {
                        widget._selectedRoofType = value! ? 'เเผ่นโค้ง' : null;
                      });
                      widget._typeroofController?.text =
                          widget._selectedRoofType ?? '';
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
              child: TextFormField(
                controller: widget._length_roofController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 13.0, horizontal: 25.0),
                  border: InputBorder.none, // กำหนดให้ไม่มีเส้นกรอบ
                  labelText: 'ความยาว:',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 75,
                  height: 45,
                  child: DropdownButtonFormField<String>(
                    value: widget._amount_roofController!.text.isNotEmpty
                        ? widget._amount_roofController?.text
                        : null,
                    items: widget.numbers.map((num) {
                      return DropdownMenuItem<String>(
                        value: num,
                        child: Text(num),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        widget._amount_roofController?.text = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'จำนวน',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1.0, horizontal: 3.0),
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 220,
                  height: 45,
                  child: TextFormField(
                    controller: widget._length_roofController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 15.0),
                      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                      labelText: '/ / / ',

                      border: InputBorder.none,
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
