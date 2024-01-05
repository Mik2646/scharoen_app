import 'dart:io';

class Employee {
  String? id;
  String? firstname;
  String? lastname;
   String? email;
   String? address;
   String? phone;
   String? role;
   File? imageUrl;
   bool? status;
   DateTime? dateTime;

  Employee(
      { this.id,
       this.firstname,
       this.lastname,
       this.address,
       this.email,
       this.phone,
       this.role,
       this.status,
       this.dateTime,
       this.imageUrl});



  factory Employee.fromMap(Map<String, dynamic>? employee) {
    if (employee == null) {
      return Employee(
        id: null,
       firstname :null,
       lastname :null,
       address :null,
       email :null,
       phone :null,
       role :null,
       status: false,
       dateTime: null,
       imageUrl :null,
      );
    }

    return Employee(
      id: employee['id'],
      firstname: employee['name'],
      lastname: employee['lastname'],
      address: employee['address'],
      email: employee['email'],
      phone: employee['phone'],
      role: employee['role'],
      status: employee['status'],
       dateTime: employee['dateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(employee['dateTime'])
          : null,
      imageUrl: employee['imageUrl'] != null
          ? File(employee['imageUrl'])
          : null,
  
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name':firstname,
      'lastname':lastname,
      'address':address,
      'email':email,
      'phone':phone,
      'role':role,
      'status':status,
      'dateTime':dateTime,
      'imageUrl':imageUrl,


    };
  }
}


  //  factory Employee.fromMap(Map<String,dynamic> employee)
  //  {if (employee == null){
  //   return null;

  //  }
  // String? employeeCode = employee['Document ID'];
  // String? firstname;
  // String? lastname;
  //  String? email;
  //  String? address;
  //  String? phone;
  //  String? password;
  //  File? imageUrl;


  //  }
  //  ;


