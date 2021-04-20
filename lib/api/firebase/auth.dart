import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Auth._();

  static User getFirebaseUser() {
    return _auth.currentUser;
  }

  static bool isSignedIn() {
    return (getFirebaseUser() != null);
  }

  static Stream<User> get state {
    return _auth.authStateChanges();
  }

  static Future<User> googleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    if(googleUser == null) {
      return null;
    }
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final User firebaseUser =
        (await _auth.signInWithCredential(credential)).user;
    print("Signed in user: ${firebaseUser.displayName} (${firebaseUser.uid})");

    return firebaseUser;
  }

  static void signOut() async {
    await _googleSignIn.disconnect();
    await _auth.signOut();
  }
}
