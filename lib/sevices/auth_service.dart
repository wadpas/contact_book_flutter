import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ValueNotifier<bool> {
  AuthService() : super(false);
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future signInWithGoogle() async {
    value = true;

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (_) {
      value = false;
      rethrow;
    }

    value = false;
  }

  Future signInAnonymous() async {
    value = true;

    try {
      await auth.signInAnonymously();
    } on FirebaseAuthException catch (_) {
      value = false;
      rethrow;
    }

    value = false;
  }

  Future signOut() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
  }
}
