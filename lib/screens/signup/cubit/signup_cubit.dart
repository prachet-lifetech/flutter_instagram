import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_instagram/models/failure_model.dart';
import 'package:flutter_instagram/repositories/auth/auth_repository.dart';
import 'package:flutter_instagram/screens/login/cubit/login_cubit.dart';

part 'signup_state.dart';


class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;

  SignupCubit({@required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignupState.initial());

  void usernameChanged(String value) {
    emit(state.copyWith(email: value, status: SignupStatus.initial));
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignupStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignupStatus.initial));
  }

  void signupWithCredentials() async {
    if(state.status == SignupStatus.submitting) {
      return;
    }
    emit( state.copyWith(status: SignupStatus.submitting));
    try {
      await _authRepository.signupWithEmailAndPassword(
        username: state.username,
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: SignupStatus.success, failure: Failure()));
    } on Failure catch (err) {
      emit(state.copyWith(status: SignupStatus.error, failure: err));
    }
  }
}
