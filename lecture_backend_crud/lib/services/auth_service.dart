  import 'package:firebase_auth/firebase_auth.dart';

class AuthService{


   Future<User> registerUser({
     required String email,
     required String password,
  })async{
     try{
       UserCredential userCredential =
           await FirebaseAuth.instance
           .createUserWithEmailAndPassword(email: email, password: password);
       userCredential.user!.sendEmailVerification();
       return userCredential.user!;
     }catch(e){
      throw e.toString();
     }
   }

   Future<User> loginUser({
     required String email,
     required String password,
   })async{
     try{
       UserCredential userCredential =
           await FirebaseAuth.instance
           .signInWithEmailAndPassword(email: email, password: password);
       return userCredential.user!;
     }catch(e){
       throw e.toString();
     }
   }

    Future resetPassword({
     required String email,
  }) async{
     await FirebaseAuth.instance
         .sendPasswordResetEmail(email: email);
    }


  }