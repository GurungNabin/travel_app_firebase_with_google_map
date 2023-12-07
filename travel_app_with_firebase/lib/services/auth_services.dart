

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices{

//Google signin
signInWithGoogle()async{
  //begin interactive sign in process
final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
  //obtain auth details from request
final GoogleSignInAuthentication gAUth = await gUser!.authentication;
  //create a new credential for user
final credential = GoogleAuthProvider.credential(
  accessToken: gAUth.accessToken,
  idToken: gAUth.idToken,
);
  //finally, lets sign in
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
}