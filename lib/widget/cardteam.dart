import 'package:flutter/material.dart';
import 'package:scharoen_app/models/Employee.dart';
import 'package:scharoen_app/service/database.dart';

class CardTeam extends StatelessWidget {
  const CardTeam({super.key});

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
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://cdn-icons-png.flaticon.com/128/848/848043.png"),
                                          fit: BoxFit.fill,
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
                                      'รหัสพนักงาน :' +
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
                                                  emId:
                                                      snapshot.data![index].id,
                                                  Firstname: snapshot
                                                      .data![index].firstname,
                                                  Lastname: snapshot
                                                      .data![index].lastname,
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
                          Positioned(
                            left: 49,
                            top: 13,
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://cdn-icons-png.flaticon.com/128/9220/9220257.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
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
  final String? emId;
  final String? Firstname;
  final String? Lastname;
  Teamdetail({super.key, this.emId, this.Firstname, this.Lastname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("รายละเอียดพนักงาน")),
      body: 
        Center(
          child: ListView(
            
            children: [
                SizedBox(height: 30,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                    
                      Container(
                        width: 86,
                        height:85,
                  
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://cdn-icons-png.flaticon.com/128/848/848043.png",),
                            fit: BoxFit.fill,
                            
                          ),
                        ),
                      ),
                      Positioned(
                        left: 59,
                        top: -2,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://cdn-icons-png.flaticon.com/128/9220/9220257.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    
                    ],
                  ),
               
              SizedBox(height: 35,),
                Text("${Firstname}"+"  "+"${Lastname}",style: TextStyle(fontSize: 28),),
                Text("รหัสพนักงาน: "+"${emId}")
                 ],
              ),
            ],
          ),
        ),
      
    );
  }
}
