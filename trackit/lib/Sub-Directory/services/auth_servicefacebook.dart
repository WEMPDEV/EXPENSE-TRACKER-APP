import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<UserCredential?> signInWithFacebook() async {
  try {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.status == LoginStatus.success) {
      final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
      return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } else {
      print('Facebook login failed: ${loginResult.message}');
      return null;
    }
  } catch (e) {
    print('Error during Facebook sign in: $e');
    return null;
  }
}
