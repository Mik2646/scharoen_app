import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scharoen_app/screens/Homepage.dart';
import 'package:scharoen_app/screens/Login.dart';
import 'package:scharoen_app/service/Authentication.dart';
import 'package:scharoen_app/widget/loading.dart';

class Authenticationsceen extends StatefulWidget {
  const Authenticationsceen({Key? key}) : super(key: key);

  @override
  State<Authenticationsceen> createState() => _AuthenticationServiceState();

  Stream<User?> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }
}

class _AuthenticationServiceState extends State<Authenticationsceen> {
  late AuthenticationService auth;
  late Stream<User?> user;

  @override
  void initState() {
    super.initState();
    auth = AuthenticationService();
    user = auth.authStateChanges();
  }

 @override
Widget build(BuildContext context) {
  return StreamBuilder<User?>(
    stream: user,
    builder: (context, snapshot) {
      return snapshot.connectionState == ConnectionState.active
          ? (snapshot.data == null ? Login(auth: auth) : Homepage(auth: auth))
          : Column(
              children: [
                Text("${snapshot.error}"),
                Center(
                  child: LoadingScreen(),
                ),
              ],
            );
    },
  );
}
}