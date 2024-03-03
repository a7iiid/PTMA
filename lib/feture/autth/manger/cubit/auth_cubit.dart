import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'package:ptma/core/utils/rout.dart';

part 'auth_state.dart';

class AuthAppCubit extends Cubit<AuthState> {
  AuthAppCubit() : super(changstat());

  static get(context) => BlocProvider.of<AuthAppCubit>(context);

  void creatAcaunte(email, pass, ctx) {
    emit(createAcunte());
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      emit(success());

      GoRouter.of(ctx).pushNamed(routes.kSigninScreen);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      emit(Filur(e.code));
    } catch (e) {
      print(e);
    }
  }

  void inputfilde() {
    emit(changstat());
  }
}
