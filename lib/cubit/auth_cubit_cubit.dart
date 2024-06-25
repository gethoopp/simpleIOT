import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

part 'auth_cubit_state.dart';

class AuthCubitCubit extends Cubit<AuthCubitState> {
  final auth = FirebaseAuth.instance;
  AuthCubitCubit() : super(AuthCubitInitial());

  void signUp(String nameEmail, String password) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: nameEmail, password: password);

      emit(AuthSucces(result.user));

      Get.offNamed('/login');
    } on FirebaseAuthException catch (e) {
      Get.snackbar(e.message.toString(), "Harap Coba Kembali ");
    }
  }

  void login(String nameEmail, String password) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: nameEmail, password: password);

      emit(AuthSucces(result.user));

      Get.toNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar(e.message.toString(), "Harap Coba Kembali ");
    }
  }
}
