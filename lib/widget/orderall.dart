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
                   Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NextOrderall(
                                        orderId: snapshot.data![index].id,
                                        lengthCover:
                                            snapshot.data![index].length_cover,
                                        colorRoof:
                                            snapshot.data![index].color_roof,
                                      ),
                                    ),
                                  );
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

class NextOrderall extends StatelessWidget {
  final String? orderId;
  final String? lengthCover;
  final String? colorRoof;

  NextOrderall({Key? key, this.orderId, this.lengthCover, this.colorRoof})
      : super(key: key);
  // final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation:
            2.5, 
        shadowColor:
            const Color.fromARGB(255, 0, 0, 0), 
        toolbarHeight: 70.0, 
     title: Text(" ออเดอร์ที่ ${orderId}"),
      ),
  
      body: Center(
        child: Column(
          children: [
            Container(
              width: 383,
              height: 696,
              child: Stack(
                children: [
                  Positioned(
                    left: 250,
                    top: 70,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/roof.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 30,
                    child: Text(
                      'หมายเลขออเดอร์ :',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 200,
                    top: 35,
                    child: Text(
                      '${orderId}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 635,
                    child: Text(
                      'จาก นายอัครชัย วารีรัตน์',
                      style: TextStyle(
                        color: Color(0xFF808080),
                        fontSize: 16,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 70,
                    top: 79,
                    child: Text(
                      'สี${colorRoof}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 50,
                    top: 90,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..translate(0.0, 0.0)
                        ..rotateZ(3.14),
                      child: Container(
                        width: 19,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 352,
                    top: 40,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: ShapeDecoration(
                        color: Color(0xFFFDA726),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 50,
                    top: 661,
                    child: Container(
                      width: 19,
                      height: 18,
                      decoration: ShapeDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 77,
                    top: 661,
                    child: Container(
                      width: 19,
                      height: 18,
                      decoration: ShapeDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 258,
                    top: 146.65,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..translate(0.0, 0.0)
                        ..rotateZ(-1.50),
                      child: Container(
                        width: 80.87,
                        height: 90.31,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 36.03,
                              top: 2.65,
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..translate(0.0, 0.0)
                                  ..rotateZ(-2.27),
                                child: Container(
                                  width: 51.61,
                                  height: 69.81,
                                  decoration:
                                      BoxDecoration(color: Color(0xFFE1E1E1)),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 31.41,
                              top: -2.79,
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..translate(0.0, 0.0)
                                  ..rotateZ(-0.63),
                                child: Container(
                                  width: 68.83,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 21.81,
                              top: -13.69,
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..translate(0.0, 0.0)
                                  ..rotateZ(-0.63),
                                child: Container(
                                  width: 69.30,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10.78,
                              top: -26.89,
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..translate(0.0, 0.0)
                                  ..rotateZ(-0.67),
                                child: Container(
                                  width: 70.14,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 186,
                    child: Text(
                      'รายการผลิต',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 368,
                    child: Text(
                      'รายการผลิตครอบ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 278,
                    top: 645,
                    child: Container(
                      width: 79,
                      height: 32,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 79,
                              height: 32,
                              decoration: ShapeDecoration(
                                color: Color(0xFFD9D9D9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 23.88,
                            top: 9.60,
                            child: SizedBox(
                              width: 37.66,
                              height: 12.80,
                              child: Text(
                                'Next',
                                style: TextStyle(
                                  color: Color(0xFF50A02B),
                                  fontSize: 14,
                                  fontFamily: 'Josefin Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 49,
                    top: 231,
                    child: Text(
                      '1.\n\n2.\n\n3.\n\n4.\n\n\n\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 49,
                    top: 407,
                    child: Text(
                      '1.\n\n2.\n\n\n\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 87,
                    top: 231,
                    child: Text(
                      'เเผ่นตรง 770 ซม.  จำนวน  20 เเผ่น',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 87,
                    top: 259,
                    child: Text(
                      'เเผ่นโค้ง 770 ซม.  จำนวน  10 เเผ่น',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 87,
                    top: 259,
                    child: Text(
                      'เเผ่นโค้ง 770 ซม.  จำนวน  10 เเผ่น',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 336,
                    top: 229,
                    child: Checkbox(
                      value: true,
                      onChanged: (bool? value) {
                        // setState(() {
                        //   isChecked = value ?? false;
                        // });
                      },
                    ),
                  ),
                  Positioned(
                    left: 336,
                    top: 405,
                    child: Container(
                      width: 21,
                      height: 20,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage("https://via.placeholder.com/21x20"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 336,
                    top: 255,
                    child: Container(
                      width: 21,
                      height: 20,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage("https://via.placeholder.com/21x20"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 87,
                    top: 407,
                    child: Text(
                      '#21ชนผนัง 450 ซม. จำนวน 2 ท่อน',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            )
            // Text('Order ID: ${orderId ?? "N/A"}'),
            // ElevatedButton(
            //   onPressed: () {
            //     // Navigate back to the previous page
            //     Navigator.pop(context);
            //   },
            //   child: Text('Go Back'),
            // ),
          ],
        ),
      ),
    );
  }
}
