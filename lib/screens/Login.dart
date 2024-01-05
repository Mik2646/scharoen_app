import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scharoen_app/screens/Homepage.dart';
import 'package:scharoen_app/service/Authentication.dart';
import 'package:scharoen_app/widget/loading.dart';
import 'package:email_validator/email_validator.dart' as email_validator_lib;

class Login extends StatefulWidget {
  const Login({super.key, required auth});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthenticationService _auth = AuthenticationService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isloading = false;
  bool _isPasswordVisible = false;

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return _isloading == true
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              //  backgroundColor: Colors.black,
              title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                    width: 120, child: Image.asset("images/logoscaroen.png"))
              ]),
            ),
            body: Padding(
              padding: const EdgeInsets.all(36.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                          color: Color.fromARGB(255, 111, 110, 110),
                          fontSize: 45),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 15.0),
                         border: OutlineInputBorder( borderRadius: BorderRadius.circular(12.0),),
                        labelText: 'อีเมลล์:',
                        labelStyle: TextStyle(color: Colors.grey,fontSize: 13)
                      ),
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'กรอกอีเมลล์';
                        } else if (!email_validator_lib.EmailValidator.validate(
                            email)) {
                          return 'กรอกอีเมลล์ที่ถูกต้อง';
                        }
                        return null; // ไม่มีข้อผิดพลาด
                      },
                    ),
                    SizedBox(height: 33.0),
                    Stack(
                      children: [
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                          
                            contentPadding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 15.0),
                                          labelStyle: TextStyle(color: Colors.grey,fontSize: 13),
                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0),  borderSide: BorderSide(color: Colors.red), ),
                            labelText: 'รหัสผ่าน:',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              child: Icon(
                                
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,color: Colors.grey,
                              ),
                            ),
                          ),
                          validator: (password) {
                            // ใส่โค้ดตรวจสอบ validation ของรหัสผ่านที่นี่
                            if (password!.isEmpty) {
                              return 'กรุณากรอกรหัสผ่าน !';
                            }
                            else if(password.length < 6){
                              return'รหัสต้องมีความยาว 6 ตัวขึ้นไป';

                            }
                            // เพิ่มเงื่อนไข validation เพิ่มเติมตามต้องการ
                            return null; // ไม่มีข้อผิดพลาด
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 22.0),
                    ElevatedButton(
                      onPressed: () {
                        // Check username and password, then show dialog
                        _showForgotPasswordDialog(context);
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(
                            0), // Set elevation to 0 (no shadow)
                      ),
                      child: Text('ลืมรหัสผ่าน?'),
                    ),
                    SizedBox(height: 22.0),
                    ElevatedButton(
                      onPressed: () {
                        _login();

                        //   // setState(() {
                        //   //   _isloading = true;
                        //   // });
                        //   String? employeeId = emailController!.text;
                        //   String? password = passwordController!.text;

                        //   // try{
                        //   //     await widget.auth.loginWithEmail(
                        //   //       emailController?.text.toString(),
                        //   //       passwordController?.text.toString()
                        //   //     );
                        //   // }
                        //   // catch(e){
                        //   //   errorController?.add(getErrorMessage(e.toString()));

                        //   // }

                        //   // setState(() {
                        //   //   _isloading = false;
                        //   // });

                        //   if (employeeId.isNotEmpty && password.isNotEmpty) {
                        //     if (_isPasswordVisible) {
                        //       print('รหัสพนักงาน: $employeeId, รหัสผ่าน: $password');
                        //     } else {
                        //       print('รหัสพนักงาน: $employeeId, รหัสผ่าน: ********');
                        //     }
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder: (context) => Homepage(auth: _auth,)),
                        //     );
                        //   } else {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar
                        //       (backgroundColor: const Color.fromARGB(137, 142, 142, 142),
                        //         content: Text('กรุณากรอกข้อมูลให้ครบถ้วน !'),
                        //       ),
                        //     );
                        //   }
                        // },
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        shadowColor: Colors.black,
                        backgroundColor: Color.fromARGB(255, 213, 212, 212),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set the border radius here
                        ),
                      ),
                      child: Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 180,
                    ),
                    Text(
                      "By s.charoen",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 172, 172, 172)),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.LoginWithEmailAndPassword(email, password);

    if (user != null) {
      print("อีเมลล์:${email} รหัสผ่าน:${password}");
      setState(() {
        _isloading = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(137, 142, 142, 142),
          content: Row(
            children: [
              Text('ล็อกอินสำเร็จ'),
              // Image.network("https://cdn-icons-png.flaticon.com/128/5709/5709755.png")
            ],
          ),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Homepage(
                  auth: _auth,
                
                )),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(137, 142, 142, 142),
          content: Text('ล็อกอินไม่สำเร็จ!'),
          // SizedBox(width: 30,),
          //   Image.network("https://cdn-icons-png.flaticon.com/128/5709/5709755.png",scale: 2,)
        ),
      );
    }
  }

  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          // title: Text('Forgot Password?'),
          // content: Text('โปรดติดต่อผู้ดูเเลระบบเพื่อเเก้ไขรหัสผ่านนะครับ .'),

          actions: <Widget>[
            Column(
              children: [
                // IconButton(
                //     icon: Icon(Icons.menu),
                //     onPressed: () {
                //       Navigator.pop(context);
                //     },
                //   ),
                SizedBox(
                  height: 80,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/forgotpassword.png",
                      color: Colors.grey,
                    ),
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Text('โปรดติดต่อผู้ดูเเลระบบเพื่อเเก้ไขรหัสผ่าน .'),
              ],
            ),
          ],
        );
      },
    );
  }
}
