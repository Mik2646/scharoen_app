import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scharoen_app/firebase_options.dart';

import 'package:scharoen_app/screens/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // options: DefaultFirebaseOptions.currentPlatform
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.light(),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadMainScreen();
  }

  _loadMainScreen() async {
    // ทำการ delay เป็นเวลา 2 วินาที
    await Future.delayed(Duration(seconds: 1));

    // เปลี่ยนหน้าไปที่หน้าหลัก
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Authenticationsceen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset("images/logoscaroen.png"),
          CircularProgressIndicator()
        ]),
      ),
    );
  }
}
