

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:testauth/moduls/SignInAndSignUp/home_screen.dart';
import 'package:testauth/moduls/SignInAndSignUp/signIn_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;


   void signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
        await auth.signInWithPopup(authProvider);

        user = userCredential.user;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (_) => HomeScreen()));
        emit(AuthSuccessful());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
          await auth.signInWithCredential(credential);

          user = userCredential.user;
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (_) => HomeScreen()));
          emit(AuthSuccessful());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            emit(AuthError(e.message.toString()));
          } else if (e.code == 'invalid-credential') {
            // ...
            emit(AuthError(e.message.toString()));
          }
        } catch (e) {
          emit(AuthError(e.toString()));
          // ...
        }
      }
    }

  }




   void signOutWithGoogleAndFacebook({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      emit(AuthLoading());
      if (!kIsWeb) {
        await googleSignIn.signOut();
        await FacebookAuth.instance.logOut();
      }
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (_) => SignInScreen()));
      emit(AuthSuccessful());

    } catch (e) {
      emit(AuthError(e.toString()));

    }
  }


  //SIGN UP METHOD
  Future  signUp({required String email, required String password,required BuildContext context}) async {
    emit(AuthLoading());

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (_) => HomeScreen()));
      emit(AuthSuccessful());

    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message.toString()));
    }
  }
  void signInWithFacebook({required BuildContext context}) async {
    try {
      emit(AuthLoading());


      // permissions!.declined;


      final LoginResult result = await FacebookAuth.instance.login(); // by default we request the email and the public profile
// or FacebookAuth.i.login()
      if (result.status == LoginStatus.success) {
        final AuthCredential facebookCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);
        final userCredential =
        await _auth.signInWithCredential(facebookCredential);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (_) => HomeScreen()));
        emit(AuthSuccessful());
      } else {
        emit(AuthError(result.message.toString()));
      }







    } on FirebaseAuthException catch (e) {
     emit(AuthError(e.message.toString()));
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password,required BuildContext context}) async {
    emit(AuthLoading());
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (_) => HomeScreen()));
      emit(AuthSuccessful());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message.toString()));
    }
  }

  //SIGN OUT METHOD
  Future signOut({required BuildContext context}) async {
    emit(AuthLoading());
    await _auth.signOut().then((value) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (_) => SignInScreen()));
      emit(AuthSuccessful());
    }).catchError((e) {
      emit(AuthError(e.toString()));
    });


    print('signout');
  }

}
