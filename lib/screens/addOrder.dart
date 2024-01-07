import 'package:cloud_firestore/cloud_firestore.dart';
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
  int amountcover = 1;
  @override
  Widget build(BuildContext context) {
    List<Addroof> addorders = List.generate(
        amount,
        (index) => Addroof(
              index: index,
            ));
//   List<AddCover> addcover = List.generate(
//   amountcover,
//   (index) => AddCover(
//     indexcover: index,
//   ),
// );

    return Scaffold(
        appBar: AppBar(
          title: Text("เพิ่มรายการผลิต "),
          actions: [
            IconButton(
              icon: Image.network(
                'https://cdn-icons-png.flaticon.com/128/10608/10608892.png',
                width: 37,
                height: 37,
                color: Color.fromARGB(255, 135, 135, 135),
              ),
              onPressed: () {
                setState(() {
                  amount++;
                  // counter++;
                });
              },
            ),
          ],
        ),
        body: ListView.builder(
            itemCount: addorders.length,
            itemBuilder: (context, index) {
              return addorders[index];
            }),
        bottomNavigationBar: Container(
          height: 80,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Image.network(
                      'https://cdn-icons-png.flaticon.com/128/10608/10608892.png',
                      width: 37,
                      height: 37,
                      color: Color.fromARGB(255, 135, 135, 135),
                    ),
                    onPressed: () {
                      print(amount);
                      setState(() {
                        amount++;
                        // counter++;
                      });
                    },
                  ),
                  IconButton(
                    icon: Image.network(
                      'https://cdn-icons-png.flaticon.com/128/7130/7130774.png',
                      width: 37,
                      height: 37,
                      color: Color.fromARGB(255, 135, 135, 135),
                    ),
                    onPressed: () {
                      print(amount);
                      setState(() {
                        amount++;
                        // counter++;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: ElevatedButton(
                      onPressed: () async {
                        for (var i = 0; i < addorders.length; i++) {
                          await addorderFirebase(addorders[i]);
                        }
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(
                            1), // ตั้งค่า elevation เป็น 0 (ไม่มีเงา)
                      ),
                      child: Text(
                        'ยืนยัน',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       "By s.charoen",
              //       style: TextStyle(color: Colors.grey),
              //     )
              //   ],
              // ),
            ],
          ),
        ));
  }
}

Future<void> addorderFirebase(Addroof order) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('order')
      .orderBy('datetime', descending: true)
      .get();
  var Id, count;
  if (snapshot.docs.isNotEmpty) {
    count = snapshot.docs.first['count'] + 1;
    Id = '$count';
  } else {
    count = 1;
    Id = "1";
  }

  await FirebaseFirestore.instance.collection('order').doc(Id).set({
    'count': count,
    'id': Id,
    'typeroof': order._typeroofController?.text,
    'color_roof': order._colorroofController?.text,
    'brand_roof': order._brand_roofController?.text,
    'length_roof': order._length_roofController?.text,
    'size_roof': order._size_roofController?.text,
    'amount_roof': order._amount_roofController?.text,
    'note': order._note_roofController?.text,
    'orderitem_status': order.status,
    'datetime': DateTime.now(),
  });
}

class Addroof extends StatefulWidget {
  int index;
  Addroof({super.key, required this.index});
  TextEditingController? _typeroofController = TextEditingController();
  TextEditingController? _colorroofController = TextEditingController();
  TextEditingController? _brand_roofController = TextEditingController();
  TextEditingController? _length_roofController = TextEditingController();
  TextEditingController? _size_roofController = TextEditingController();
  TextEditingController? _amount_roofController = TextEditingController();
  TextEditingController? _note_roofController = TextEditingController();
  String status = 'pending';

  List<String> typeroof = ['นอก', 'จิงโจ้', 'บลูสโคป'];
  List<String> colorroof = ['สีซิงค์', 'สีน้ำเงิน', 'สีเเดงมั่งมี'];
  List<String> sizeroof = ['0.30', '0.20', '0.25'];
  List<String> numbers = List.generate(100, (index) => (index + 1).toString());

  String? _selectedRoofType;
  @override
  State<Addroof> createState() => _AddorderState();
}

class _AddorderState extends State<Addroof> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150,
                  height: 20,
                  child: TextFormField(
                    controller: widget._length_roofController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 25.0),
                      border: InputBorder.none,
                      labelText: 'ความยาว:',
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                ),
                Container(
                  width: 110,
                  height: 45,
                  child: DropdownButtonFormField<String>(
                    value: widget._size_roofController!.text.isNotEmpty
                        ? widget._size_roofController?.text
                        : null,
                    items: widget.sizeroof.map((role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        widget._size_roofController?.text = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'ความหนา',
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
                    controller: widget._note_roofController,
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
// }
// class AddCover extends StatefulWidget {
//   int indexcover;
//   AddCover({super.key, required this.indexcover});
//   TextEditingController? _typeroofController = TextEditingController();
//   TextEditingController? _colorroofController = TextEditingController();
//   TextEditingController? _brand_roofController = TextEditingController();
//   TextEditingController? _length_roofController = TextEditingController();
//   TextEditingController? _size_roofController = TextEditingController();
//   TextEditingController? _amount_roofController = TextEditingController();
//   TextEditingController? _note_roofController = TextEditingController();

//   List<String> typeroof = ['นอก', 'จิงโจ้', 'บลูสโคป'];
//   List<String> colorroof = ['สีซิงค์', 'สีน้ำเงิน', 'สีเเดงมั่งมี'];
//   List<String> sizeroof = ['0.30', '0.20', '0.25'];
//   List<String> numbers = List.generate(100, (index) => (index + 1).toString());

//   String? _selectedRoofType;
//   @override
//   State<AddCover> createState() => _AddCoverState();
// }

// class _AddCoverState extends State<AddCover> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border(
//             bottom: BorderSide(
//               color: const Color.fromARGB(255, 192, 192, 192), // กำหนดสีของเส้น
//               width: 2.0, // กำหนดความกว้างของเส้น
//             ),
//           ),
//         ),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Text("${widget.indexcover + 1}."),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Container(
//                   width: 150,
//                   height: 45,
//                   child: DropdownButtonFormField<String>(
//                     value: widget._colorroofController!.text.isNotEmpty
//                         ? widget._colorroofController?.text
//                         : null,
//                     items: widget.colorroof.map((role) {
//                       return DropdownMenuItem<String>(
//                         value: role,
//                         child: Text(role),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         widget._colorroofController?.text = value!;
//                       });
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'สี',
//                       contentPadding:
//                           EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
//                       labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Container(
//                   width: 150,
//                   height: 45,
//                   child: DropdownButtonFormField<String>(
//                     value: widget._brand_roofController!.text.isNotEmpty
//                         ? widget._brand_roofController?.text
//                         : null,
//                     items: widget.typeroof.map((role) {
//                       return DropdownMenuItem<String>(
//                         value: role,
//                         child: Text(role),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         widget._brand_roofController?.text = value!;
//                       });
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'เเบรนด์',
//                       contentPadding:
//                           EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
//                       labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text("เเผ่นตรง"),
//                 Text("เเผ่นเรียบ"),
//                 Text("เเผ่นโค้ง"),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: CheckboxListTile(
//                     title: Text(''),
//                     value: widget._selectedRoofType == 'เเผ่นตรง',
//                     onChanged: (value) {
//                       setState(() {
//                         widget._selectedRoofType = value! ? 'เเผ่นตรง' : null;
//                       });
//                       widget._typeroofController?.text =
//                           widget._selectedRoofType ?? '';
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   child: CheckboxListTile(
//                     title: Text(''),
//                     value: widget._selectedRoofType == 'เเผ่นเรียบ',
//                     onChanged: (value) {
//                       setState(() {
//                         widget._selectedRoofType = value! ? 'เเผ่นเรียบ' : null;
//                       });
//                       widget._typeroofController?.text =
//                           widget._selectedRoofType ?? '';
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   child: CheckboxListTile(
//                     title: Text(''),
//                     value: widget._selectedRoofType == 'เเผ่นโค้ง',
//                     onChanged: (value) {
//                       setState(() {
//                         widget._selectedRoofType = value! ? 'เเผ่นโค้ง' : null;
//                       });
//                       widget._typeroofController?.text =
//                           widget._selectedRoofType ?? '';
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SizedBox(
//                   width: 150,
//                   height: 20,
//                   child: TextFormField(
//                     controller: widget._length_roofController,
//                     keyboardType: TextInputType.emailAddress,
//                     textInputAction: TextInputAction.next,
//                     autovalidateMode: AutovalidateMode.onUserInteraction,
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.symmetric(
//                           vertical: 13.0, horizontal: 25.0),
//                       border: InputBorder.none,
//                       labelText: 'ความยาว:',
//                       labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 110,
//                   height: 45,
//                   child: DropdownButtonFormField<String>(
//                     value: widget._size_roofController!.text.isNotEmpty
//                         ? widget._size_roofController?.text
//                         : null,
//                     items: widget.sizeroof.map((role) {
//                       return DropdownMenuItem<String>(
//                         value: role,
//                         child: Text(role),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         widget._size_roofController?.text = value!;
//                       });
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'ความหนา',
//                       contentPadding:
//                           EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
//                       labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               children: [
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Container(
//                   width: 75,
//                   height: 45,
//                   child: DropdownButtonFormField<String>(
//                     value: widget._amount_roofController!.text.isNotEmpty
//                         ? widget._amount_roofController?.text
//                         : null,
//                     items: widget.numbers.map((num) {
//                       return DropdownMenuItem<String>(
//                         value: num,
//                         child: Text(num),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         widget._amount_roofController?.text = value!;
//                       });
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'จำนวน',
//                       contentPadding:
//                           EdgeInsets.symmetric(vertical: 1.0, horizontal: 3.0),
//                       labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Container(
//                   width: 220,
//                   height: 45,
//                   child: TextFormField(
//                     controller: widget._note_roofController,
//                     keyboardType: TextInputType.emailAddress,
//                     textInputAction: TextInputAction.next,
//                     autovalidateMode: AutovalidateMode.onUserInteraction,
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.symmetric(
//                           vertical: 13.0, horizontal: 15.0),
//                       // border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
//                       labelText: '/ / / ',

//                       border: InputBorder.none,
//                       labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 30,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
