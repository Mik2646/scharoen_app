import 'package:flutter/material.dart';

class BottomMenu extends StatelessWidget {
  final int bottomMenuEmployeeCount;
  final bool isSwitchOn;
  final ValueChanged<bool> onSwitchChanged;

  BottomMenu({
    required this.bottomMenuEmployeeCount,
    required this.isSwitchOn,
    required this.onSwitchChanged,
  });
  final List<String> avatarUrls = [
    'https://cdn-icons-png.flaticon.com/128/848/848043.png',
    'https://cdn-icons-png.flaticon.com/128/848/848043.png',
    'https://cdn-icons-png.flaticon.com/128/848/848043.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container

    (color: Color.fromARGB(255, 201, 201, 201),
      
      height: 87,
      child: Padding(
        padding: const EdgeInsets.only(left: 0),
        child: Column(
          
            
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 86,
              color: Color.fromARGB(255, 255, 255, 255),
               child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 15,top: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'จำนวนพนักงานวันนี้:',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Text('$bottomMenuEmployeeCount'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Transform.scale(
                    scale: 0.62,
                    child: Switch(
                      value: isSwitchOn,
                      onChanged: (value) {
                        onSwitchChanged(value);
                      },
                      activeTrackColor: Colors.green,
                      activeColor: Colors.white,
                    ),
                  ),
                      SizedBox(
                width: 60,
              ),
              CircleAvatar(
                backgroundColor: Color.fromARGB(255, 214, 213, 213),
                radius: 12,
              )
                ],
              ),
            ),],)),
        
          ],
        ),
        
      ),
    );
  }
}
//     return ClipRect(
//       child: BottomAppBar(
//         color: Color.fromARGB(221, 255, 255, 255),
//         height: 93,
//         elevation: 5.0, // ตั้งค่า elevation เป็น 0.0 เพื่อป้องกันการปรากฎเงาด้านบน
//         shadowColor: const Color.fromARGB(255, 0, 0, 0), // สีของเงาที่คุณต้องการ
      
//         child: Padding(
//           padding: const EdgeInsets.only(left: 10),
//           child: Column(
            
//             children: [
//              Row(
//                children: [
//                  Text('จำนวนพนักงานวันนี้:',style: TextStyle(fontSize: 12),),
//                ],
//              ),
    
//             ],
//           ),
//         ),
//       ),
//     );
// }
// }

class bottomtexts extends StatelessWidget {
  const bottomtexts( {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      
      Container(
        height: 45,
        child: Text("By s.charoen",style: TextStyle(color: Colors.grey),))
    ],);
  }
}