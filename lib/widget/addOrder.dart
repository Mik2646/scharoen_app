import 'package:flutter/material.dart';

class Addorder extends StatefulWidget {
  Addorder({super.key});
  TextEditingController? _typeroofController = TextEditingController();
    TextEditingController? _colorroofController = TextEditingController();
     TextEditingController? _brand_roofController = TextEditingController();

  List<String> typeroof = ['นอก', 'จิงโจ้', 'บลูสโคป'];
  List<String> colorroof = ['สีซิงค์', 'สีน้ำเงิน', 'สีเเดงมั่งมี'];
   String? _selectedRoofType;
  @override
  State<Addorder> createState() => _AddorderState();
}

class _AddorderState extends State<Addorder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: const Color.fromARGB(255, 192, 192, 192), // กำหนดสีของเส้น
                              width: 2.0, // กำหนดความกว้างของเส้น
                            ),
                          ),),
      child: Column(
        children: [
          Row(
            children: [
              Text("1."),
              SizedBox(width: 10,),
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.red),
                      
                    ),
                   
                    
                  ),
                ),
              ),
              SizedBox(width: 20,),
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.red),
                      
                    ),
                   
                    
                  ),
                ),
              ),
              
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
          widget._typeroofController?.text = widget._selectedRoofType ?? '';
        },
      ),
    ),
    Expanded(
      child: CheckboxListTile(
        title: Text('S'),
        value: widget._selectedRoofType == 'เเผ่นเรียบ',
        onChanged: (value) {
          setState(() {
            widget._selectedRoofType = value! ? 'เเผ่นเรียบ' : null;
          });
          widget._typeroofController?.text = widget._selectedRoofType ?? '';
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
          widget._typeroofController?.text = widget._selectedRoofType ?? '';
        },
      ),
    ),
  ],
)

        ],
      ),
    );
  }
}
