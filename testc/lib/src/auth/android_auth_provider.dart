import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth_provider_base.dart';
import 'package:google_sign_in/google_sign_in.dart';

class _AndroidAuthProvider extends AuthProviderBase {
  @override
  Future<FirebaseApp> initialize() async {
    /*return await Firebase.initializeApp(
        name: 'testc',
        options: FirebaseOptions(
            apiKey: 'AIzaSyAajWOoOyHMXmgJBr_bjKEwvqEFXV4Mirc',
            appId: '1:296224193401:android:c7a58714fea2dd27ca4da8',
            messagingSenderId: '296224193401',
            projectId: 'testc-85eab'));*/
            return await Firebase.initializeApp();
  }
  

  @override
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class AuthProvider extends _AndroidAuthProvider {}
