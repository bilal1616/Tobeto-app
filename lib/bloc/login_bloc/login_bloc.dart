import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tobeto_app/bloc/login_bloc/login_event.dart';
import 'package:tobeto_app/bloc/login_bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  LoginBloc(this._firebaseAuth, this._googleSignIn) : super(LoginInitial());

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoggedOut) {
      yield* _mapLoggedOutToState(event);
    }
  }

  Stream<LoginState> _mapLoggedOutToState(LoggedOut event) async* {
    yield LoginLoading();
    try {
      await _firebaseAuth.signOut();
      final GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }
      yield LogoutSuccess();
    } catch (e) {
      yield LogoutFailure(e.toString());
    }
  }
}
