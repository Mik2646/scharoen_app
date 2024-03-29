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


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scharoen_app/models/OderItem.dart';
import 'package:scharoen_app/service/database.dart';


class orderall extends StatelessWidget {
 const orderall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  Orderitems db = Orderitems.instance;

  Stream<List<Orderitem>> stream = db.getOrderitem();
    return Container(
      child: StreamBuilder<List<Orderitem>>(
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
  snapshot.data![index].orderitem_status.toString() == 'completed' ? '•' : '•',
  style: TextStyle(
    color: snapshot.data![index].orderitem_status.toString() == 'pending' ? Color.fromARGB(227, 232, 192, 47) :
    snapshot.data![index].orderitem_status.toString() == 'inprogress' ? Colors.orange :
    snapshot.data![index].orderitem_status.toString() == 'completed' ? const Color.fromARGB(255, 95, 218, 99) :
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
                Text('วันที่ '+snapshot.data![index].dates.toString()),
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
                  "จาก "+ snapshot.data![index].create_by.toString(),
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
                                      builder: (context,) => NextOrderall(
                                        orderId: snapshot.data![index].id,
                                        date: snapshot.data![index].dates,
                                        statusorder:snapshot.data![index].orderitem_status,
                                        create_by:snapshot.data![index].create_by,
                                        img:snapshot.data![index].image,
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
  final bool? statusUser;
  final String? statusorder;
  final  String? date;
  final String? create_by;
  final String? img;

  NextOrderall({Key? key, this.orderId, this.lengthCover, this.colorRoof, this.statusUser, this.statusorder, this.date, this.create_by, this.img})
      : super(key: key);
CollectionReference orders = FirebaseFirestore.instance.collection("order");
    final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
     return Scaffold(
           appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation:
            2.5, // ตั้งค่า elevation เป็น 0.0 เพื่อป้องกันการปรากฎเงาด้านบน
        shadowColor:
            const Color.fromARGB(255, 0, 0, 0), // สีของเงาที่คุณต้องการ
        toolbarHeight: 70.0, // ตั้งค่าความสูงของ AppBar ตามที่ต้องการ
        title: Text("ออเดอร์ ",style: TextStyle(fontSize: 25),),
     
         actions: [Padding(
           padding: const EdgeInsets.only(right: 15),
           child: Text(" ${date}",style: TextStyle(color: Colors.grey,fontSize: 12),),
         )
        ],
      ),

      body: StreamBuilder(
          stream:
              orders.where("order_itemId", isEqualTo: "$orderId").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text("ไม่พบรายการ"),
              );
            }
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(right:28,left: 28,top: 10),
                  child: Column(
                    children: [
                 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("หมายเลขออเดอร์ : ${orderId}",style: TextStyle(fontSize: 19),),
                          Text(
                            statusorder.toString() == 'pending'
                                ? '•'
                                : statusorder.toString() == 'inprogress'
                                    ? '•'
                                    : statusorder.toString() == 'completed'
                                        ? '•'
                                        : '•',
                            style: TextStyle(
                              color: statusorder.toString() == 'pending'
                                  ? Color.fromARGB(227, 232, 192, 47)
                                  : statusorder.toString() == 'inprogress'
                                      ? Colors.orange
                                      : statusorder.toString() == 'completed'
                                          ? const Color.fromARGB(255, 95, 218, 99)
                                          : Colors.black,
                              fontSize: 40.0,
                            ),
                          ),

                        ],
                      ),
                      Row(children: [
                        Text("⎯  ${snapshot.data!.docs[0]['color_roof']} ${snapshot.data!.docs[0]['size_roof']}  ${snapshot.data!.docs[0]['brand_roof']}"),
                      
                      ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        
                          Container(
                          width: 85,
                          height: 85,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/roof.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text("รายการผลิต",style: TextStyle(fontSize: 17),)
                      ],),SizedBox(height: 10,),
                             Container(
                        height: 200,
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      " ${index + 1}.   ${snapshot.data!.docs[index]['typeroof']} ${snapshot.data!.docs[index]['length_roof']} ซม. จำนวน  ${snapshot.data!.docs[index]['amount_roof']}  เเผ่น",style: TextStyle(fontSize: 15),),
                                       MyCheckboxWidget(),
                                ],
                              );
                            }),
                      ),

                      Row(
                        children: [
                          Text("เพิ่มเติม", style: TextStyle(fontSize: 16),),
                        ],
                      ),SizedBox(height: 20,),
                         Container(
                        height: 100,
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${snapshot.data!.docs[index]['note']} "),
                 
                                ],
                              );
                            }),
                      ),
                      TextButton(onPressed: (){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('หลักฐานอ้างอิง'),
        content: Container(
          child:  Image.network(
            ("${img}"), 
            fit: BoxFit.cover,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('ปิด'),
          ),
        ],
      );
    },
  );
                      }, child: Text("ดูหลักฐานการผลิต"))
                    ],
                  ),
                ),
             
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      bottomNavigationBar: Container(
        height: 80,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'จาก ${create_by}',
                  style: TextStyle(
                    color: Color(0xFF808080),
                    fontSize: 14,
                    fontFamily: 'Josefin Sans',
                    height: 0,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: IconButton(
              icon: Image.network(
                'https://cdn-icons-png.flaticon.com/128/1092/1092004.png',
                width: 27,
                height: 27,
                color: Color.fromARGB(255, 135, 135, 135),
              ),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const Orderall()),
                // );
              },
            ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class MyCheckboxWidget extends StatefulWidget {
  @override
  _MyCheckboxWidgetState createState() => _MyCheckboxWidgetState();
}

class _MyCheckboxWidgetState extends State<MyCheckboxWidget> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Color.fromARGB(255, 17, 175, 14),
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }}

  void showImageDialog(BuildContext context) {

}
