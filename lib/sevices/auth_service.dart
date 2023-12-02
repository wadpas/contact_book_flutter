import 'package:contact_book_flutter/sevices/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ValueNotifier<bool> {
  AuthService() : super(false);
  final contactsService = ContactsService();

  Future signInWithGoogle() async {
    try {
      value = true;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential).timeout(
            const Duration(seconds: 3),
          );
      value = false;
    } on FirebaseAuthException catch (_) {
      value = false;
      rethrow;
    } catch (e) {
      value = false;
      rethrow;
    }
  }

  Future signInAnonymous() async {
    try {
      value = true;
      await FirebaseAuth.instance.signInAnonymously().timeout(
            const Duration(seconds: 3),
          );
      value = false;
    } on FirebaseAuthException catch (_) {
      value = false;
      rethrow;
    } catch (e) {
      value = false;
      rethrow;
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
