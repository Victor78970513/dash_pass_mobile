import 'package:dash_pass/core/usecase/use_case.dart';
import 'package:dash_pass/features/auth/domain/usecases/user_log_out.dart';
import 'package:dash_pass/features/auth/domain/usecases/user_login.dart';
import 'package:dash_pass/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final UserLogOut _userLogOut;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required UserLogOut userLogOut,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _userLogOut = userLogOut,
        super(AuthInitial()) {
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthLogOut>(_onAuthLogOut);
  }

  void _onAuthSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final res = await _userSignUp(UserSignUpParams(
      email: event.email,
      passowrd: event.password,
    ));

    res.fold((failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)));
  }

  void _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onAuthLogOut(AuthLogOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLogOut(NoParams());
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthInitial()),
    );
  }
}
