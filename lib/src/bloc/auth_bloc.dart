import 'package:benepet/src/services/auth_service_google.dart';
import 'package:benepet/src/utils/userHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthBloc {
  final authService = AuthGoogleService();
  final googleSignin = GoogleSignIn(scopes: ['email']);

  Stream<User> get currentUser => authService.currentUser;

  loginGoogle() async {

  try {
    final GoogleSignInAccount googleUser = await googleSignin.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(  
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken
    );

    //Firebase Sign in
    final result = await authService.signInWithCredential(credential);
    print('${result.user.displayName}');
      if(result!= null){
        UserHelper.saveUser(result.user, result.user.displayName);
      }

    } catch(error){
      print(error);
    }
  }
  logout() async {
    authService.logout();
  }
}