import 'package:firebase_auth/firebase_auth.dart';


// class AuthenticationService {
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   User? get currentUser => auth.currentUser;
//   Future<User?> loginWithEmail(String email, String password) async{
//     try{
//       await auth.signInWithEmailAndPassword(email: email, password: password);
//       return auth.user
//     }
//     catch(e){
//       rethrow;
//     }
//   }
//   Future<void> creatUserWithEmail(String email,String password) async{
//     try{
//       await auth.createUserWithEmailAndPassword(email: email, password: password);
//     }
//     catch(e){
//       rethrow;
//     }
//   }
//   Stream<User?>authStateChanges(){
//     return auth.authStateChanges();
//   }


//   Future<void>login()async{
//     try{
//       await auth.signInWithEmailAndPassword(email: 'email', password: 'password');
//     }
//     catch(e){
//       throw FirebaseAuthException(message: e.toString(), code: '');
//     }
//   }

//   Future<void>logout()async{
//     try{
//       await auth.signOut();
//     }
//     catch(e){
//       rethrow;
//     }
//   }
// }

class AuthenticationService{
   FirebaseAuth _auth = FirebaseAuth.instance;

 get currentUser => _auth.currentUser;
    Future<User?> regiterWithEmailAndPassword(String email, String password) async{
    try{
     UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
     return credential.user;
    }
    catch(e){
      print("error");
    }
    return null;
     
}
 Stream<User?>authStateChanges(){
    return _auth.authStateChanges();
  }

   Future<User?> LoginWithEmailAndPassword(String email, String password) async{
    try{
     UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
     return credential.user;
    }
    catch(e){
      print("error");
    }
    return null;
     
}
}

