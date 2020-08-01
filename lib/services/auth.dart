import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:regis_login/services/users.dart';
 
class AuthMethods{
final FirebaseAuth _auth= FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
User _userFromFirebaseUser(FirebaseUser user){
return user != null ? User(userId: user.uid): null;
}

Future signInwithEmailAndPassword(String email, String pass) async{

    AuthResult result= await _auth.signInWithEmailAndPassword(email: email, password: pass);
    FirebaseUser firebaseUser= result.user;
    return _userFromFirebaseUser(firebaseUser);

 

}
Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);
  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  return 'signInWithGoogle succeeded: $user';
}
void signOutGoogle() async{
  await googleSignIn.signOut();
  print("User Sign Out");
}
Future signUpwithEmailAndPassword(String email, String pass)async{

       AuthResult result= await _auth.createUserWithEmailAndPassword(email: email, password: pass);
       FirebaseUser firebaseUser = result.user;
       return _userFromFirebaseUser(firebaseUser);
       

}
Future resetPass(String email) async{
 

  return await _auth.sendPasswordResetEmail(email: email);
}



Future signOut()async{
  try{
     return await _auth.signOut();
  }catch(e){
       print(e.toString());
  }
}
}