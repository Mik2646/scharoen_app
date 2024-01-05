// import 'package:flutter/material.dart';

// class order extends StatefulWidget {
//   const order({super.key});

//   @override
//   State<order> createState() => _orderState();
// }

// class _orderState extends State<order> {
//   int number = 0001;
//   bool status = false;
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: const Color.fromARGB(255, 255, 255, 255),
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "หมายเลขออเดอร์: $number",
//                 style: TextStyle(fontSize: 18),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 5),
//                 child: Text(
//                   status ? '•' : '•',
//                   style: TextStyle(
//                     color: status
//                         ? Colors.green
//                         : Color.fromARGB(255, 238, 142, 86),
//                     fontSize: 38.0,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 10),
//             child: Row(
//               children: [
//                 Text("-- สีซิงค์ 0.30 นอก"),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 10, top: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CircleAvatar(
//                   backgroundColor: Color.fromARGB(255, 214, 213, 213),

//                   radius: 12,
//                   // child: ClipOval(
//                   //   child: Image.network(
//                   //     'https://cdn-icons-png.flaticon.com/128/848/848043.png', // URL ของรูปภาพ
//                   //     width: 100,
//                   //     height: 100,
//                   //     fit: BoxFit.cover,
//                   //   ),),
//                 ),
//                 // Image.network(
//                 //   "https://cdn-icons-png.flaticon.com/128/7033/7033331.png",
//                 //   width: 100,
//                 //   color: const Color.fromARGB(255, 139, 139, 137),
//                 // ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//               left: 10,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "จาก นายอัครชัย วารีรัตน์",
//                   style: TextStyle(
//                       color: const Color.fromARGB(255, 151, 151, 151)),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.navigate_next),
//                   iconSize: 40,
//                   color: Color.fromARGB(255, 112, 112, 112),
//                   onPressed: () {
//                     // ปุ่มไปหน้าถัดไป
//                   },
//                 ),
//               ],
//             ),
//           )
//         ]),
//       ),
//     );
//   }
// // }


import 'package:flutter/material.dart';
import 'package:scharoen_app/service/database.dart';
import 'package:scharoen_app/models/Orderall.dart';

class orderall extends StatelessWidget {
 const orderall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  Database db = Database.instance;

  Stream<List<Orderalls>> stream = db.getorderall();
    return Container(
      child: StreamBuilder<List<Orderalls>>(
        stream: stream,
        builder: (context, snapshot) {
         if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context,index){
              return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10,right: 10,left: 10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('หมายเลขออเดอร์ : '+  
               snapshot.data![index].id.toString(),
                style: TextStyle(fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
             child: Text(
  snapshot.data![index].orderitem_status.toString() == 'pending' ? '•' :
  snapshot.data![index].orderitem_status.toString() == 'inprogress' ? '•' :
  snapshot.data![index].orderitem_status.toString() == 'Successfullycompleted' ? '•' : '•',
  style: TextStyle(
    color: snapshot.data![index].orderitem_status.toString() == 'pending' ? Color.fromARGB(227, 232, 192, 47) :
    snapshot.data![index].orderitem_status.toString() == 'inprogress' ? Colors.orange :
    snapshot.data![index].orderitem_status.toString() == 'Successfullycompleted' ? const Color.fromARGB(255, 95, 218, 99) :
    Colors.black, 
    fontSize: 40.0,
  ),
),


              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Text('- สี'+snapshot.data![index].color_roof.toString()+' '+ snapshot.data![index].size_roof.toString()+' '+snapshot.data![index].brand_roof.toString()),
              ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 214, 213, 213),

                  radius: 12,
                  // child: ClipOval(
                  //   child: Image.network(
                  //     'https://cdn-icons-png.flaticon.com/128/848/848043.png', // URL ของรูปภาพ
                  //     width: 100,
                  //     height: 100,
                  //     fit: BoxFit.cover,
                  //   ),),
                ),
                // Image.network(
                //   "https://cdn-icons-png.flaticon.com/128/7033/7033331.png",
                //   width: 100,
                //   color: const Color.fromARGB(255, 139, 139, 137),
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "จาก นายอัครชัย วารีรัตน์",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 151, 151, 151)),
                ),
                IconButton(
                  icon: Icon(Icons.navigate_next),
                  iconSize: 40,
                  color: Color.fromARGB(255, 112, 112, 112),
                  onPressed: () {
                    // ปุ่มไปหน้าถัดไป
                  },
                ),
              ],
            ),
          )
        ]),
      ),
    );
            });
         }
         else if(snapshot.hasError){
         return   Center(child: Text("${snapshot.error}"));
         }
         return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
