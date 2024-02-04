import 'package:flutter/material.dart';
import 'package:scharoen_app/models/Employee.dart';
import 'package:scharoen_app/screens/EditEmployee.dart';
import 'package:scharoen_app/service/database.dart';

class CardTeam extends StatelessWidget {
  String? role;
  CardTeam({super.key, this.role});
  @override
  Widget build(BuildContext context) {
    Employeeall Em = Employeeall.instance;
    Stream<List<Employee>> stream = Em.getEmployeeall();
    return Container(
      child: StreamBuilder<List<Employee>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Container(
                      width: 351,
                      height: 91,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 351,
                              height: 91,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 351,
                                      height: 91,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 1,
                                              color: Color(0xFFD9D9D9)),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 13,
                                    top: 16,
                                    child: Container(
                                      width: 56,
                                      height: 55,
                                      decoration: BoxDecoration(
                                        shape: BoxShape
                                            .circle, // กำหนดให้รูปทรงเป็นวงกลม
                                        border: Border.all(
                                          color: Colors.grey, // สีของกรอบ
                                          width: 1.5, // ความหนาของกรอบ
                                        ),
                                      ),
                                      child: ClipOval(
                                        child: Image.network(
                                          "${snapshot.data![index].imageUrl}",
                                          width: 50,
                                          height: 109,
                                          fit: BoxFit.cover, // ให้ภาพไม่ถูกบีบ
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 80,
                                    top: 22,
                                    child: Text(
                                      snapshot.data![index].firstname
                                              .toString() +
                                          ' ' +
                                          snapshot.data![index].lastname
                                              .toString(),
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
                                    left: 87,
                                    top: 57,
                                    child: Text(
                                      'รหัสพนักงาน  :' +
                                          snapshot.data![index].id.toString(),
                                      style: TextStyle(
                                        color: Color(0xFF808080),
                                        fontSize: 13,
                                        fontFamily: 'Josefin Sans',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 323,
                                    top: 16,
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: ShapeDecoration(
                                        color: snapshot.data![index].status
                                                    .toString() ==
                                                'true'
                                            ? Color.fromARGB(255, 115, 231, 119)
                                            : Colors.black,
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 270,
                                    top: 44,
                                    child: Row(
                                      children: [
                                        Text(
                                          'เพิ่มเติม',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Josefin Sans',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.navigate_next),
                                          iconSize: 35,
                                          color: Color.fromARGB(
                                              255, 112, 112, 112),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Teamdetail(
                                                  role: role,
                                                  emId:
                                                      snapshot.data![index].id,
                                                  Firstname: snapshot
                                                      .data![index].firstname,
                                                  Lastname: snapshot
                                                      .data![index].lastname,
                                                  Email: snapshot
                                                      .data![index].email,
                                                  Phone: snapshot
                                                      .data![index].phone,
                                                  Address: snapshot
                                                      .data![index].address,
                                                  Role: snapshot
                                                      .data![index].role,
                                                  Status: snapshot
                                                      .data![index].status,
                                                  imgUrll: snapshot
                                                      .data![index].imageUrl,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Positioned(
                          //   left: 49,
                          //   top: 13,
                          //   child: Container(
                          //     width: 25,
                          //     height: 25,
                          //     decoration: BoxDecoration(
                          //       image: DecorationImage(
                          //         image: NetworkImage(
                          //             "https://cdn-icons-png.flaticon.com/128/9220/9220257.png"),
                          //         fit: BoxFit.fill,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            print("${snapshot.error}");
            return Center(child: Text("${snapshot.error}"));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class Teamdetail extends StatelessWidget {
  final String? role;
  final String? emId;
  final String? Firstname;
  final String? Lastname;
  final String? Email;
  final String? Phone;
  final String? Address;
  final String? Role;
  final String? imgUrll;

  final bool? Status;
  Teamdetail(
      {super.key,
      this.emId,
      this.Firstname,
      this.Lastname,
      this.Email,
      this.Phone,
      this.role,
      this.Address,
      this.Role,
      this.Status,
      this.imgUrll});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("รายละเอียดพนักงาน ")),
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 105,
                      height: 105,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // กำหนดให้รูปทรงเป็นวงกลม
                        border: Border.all(
                          color: Colors.grey, // สีของกรอบ
                          width: 1.5, // ความหนาของกรอบ
                        ),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          "${imgUrll}}",
                          // width: 70,
                          // height: 130,
                          fit: BoxFit.cover, // ให้ภาพไม่ถูกบีบ
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text("${Firstname} ${Lastname}",
                    style: TextStyle(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 0, 0, 0))),
                Container(
                  padding: EdgeInsets.all(16), // Add padding for spacing
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Set border color
                      width: 2.0, // Set border width
                    ),
                    borderRadius:
                        BorderRadius.circular(10), // Add rounded corners
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${Email}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("รหัสพนักงาน: ${emId}",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 119, 119, 119))),
                      Text("${Role}",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 121, 121, 121))),
                      Text("เบอร์โทร: ${Phone}"),
                      Text("ที่อยู่: ${Address}"),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: role == 'ผู้บริหาร'
          ? FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditUserScreen(
                            emId: emId,
                            address: Address,
                            email: Email,
                            status: Status,
                            lastname: Lastname,
                            phone: Phone,
                            role: Role,
                            name: Firstname,
                          )),
                );
              },
              child: Icon(
                Icons.edit,
                color: Color.fromARGB(255, 136, 135, 135),
                size: 30,
              ),
            )
          : SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
