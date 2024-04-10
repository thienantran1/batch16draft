import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

//for clicking icons
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  void signupWithGithub() {
    //can't sign up with Github
    emit(SignUpFailed(provider:'Github', reason: 'error'));
  }

  void signupWithGoogle() {
    //can't sign up with Google
    emit(SignUpFailed(provider:'Google', reason: 'error'));
  }
  void signupWithLinkedin() {
    //can't sign up with Linkedin
    emit(SignUpFailed(provider:'Linkedin', reason: 'error'));
  }

  void SignUpWithoutName() {
    emit(SignUpLackOfDetails(field: 'Name'));
  }

  void SignUpWithoutEmail() {
    emit(SignUpLackOfDetails(field: 'Email'));
  }

  void SignUpWithoutPassword() {
    emit(SignUpLackOfDetails(field: 'Password'));
  }
  void showDialogEvent() {
    emit(ShowDialogOnScreen());
  }
  
}


