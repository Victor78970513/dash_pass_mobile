import 'dart:async';

import 'package:dash_pass/core/shared_preferences/preferences.dart';
import 'package:dash_pass/repositories/auth/auth_repository.dart';
import 'package:dash_pass/repositories/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(AuthInitial()) {
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthLogOut>(_onAuthLogOut);
    on<IsUserLoggedIn>(_isUserLoggedIn);
  }
  FutureOr<void> _isUserLoggedIn(
      IsUserLoggedIn event, Emitter<AuthState> emit) async {
    final response = await _authRepository.getCurrentUser();
    if (response != null) {
      Preferences().userUUID = response.uid;
      emit(AuthSuccess(uid: response.uid));
    } else {
      emit(AuthInitial());
    }
  }

  FutureOr<void> _onAuthSignUp(
      AuthSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final response = await _authRepository.signUpWithEmailAndPassword(
        email: event.email, password: event.password);

    if (response != null) {
      final created = await _userRepository.createUser(
        uid: response.user!.uid,
        email: event.email,
        username: event.username,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        carnet: event.carnet,
        telefono: event.phone,
      );
      if (created) {
        Preferences().userUUID = response.user!.uid;
        emit(AuthSuccess(uid: response.user!.uid));
      } else {
        emit(AuthFailure("Error Al Crear Cuenta"));
      }
    } else {
      emit(AuthFailure("Error Al Crear Cuenta"));
    }
  }

  FutureOr<void> _onAuthLogin(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _authRepository.loginWithEmailAndPassword(
        email: event.email, password: event.password);
    if (response != null) {
      Preferences().userUUID = response.user!.uid;
      emit(AuthSuccess(uid: response.user!.uid));
    } else {
      emit(AuthFailure("Error al iniciar sesion"));
    }
  }

  FutureOr<void> _onAuthLogOut(
      AuthLogOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _authRepository.logOut();
    if (response) {
      Preferences().userUUID = "";
      emit(AuthInitial());
    } else {
      emit(AuthFailure("Error al Cerrar session"));
    }
  }
}
