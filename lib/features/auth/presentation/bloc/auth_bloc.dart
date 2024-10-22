import 'package:dash_pass/core/usecase/use_case.dart';
import 'package:dash_pass/features/auth/domain/usecases/create_user.dart';
import 'package:dash_pass/features/auth/domain/usecases/update_user.dart';
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
  final CreateUser _createUSer;
  final UpdateUser _updateUser;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required UserLogOut userLogOut,
    required CreateUser createUser,
    required UpdateUser updateUser,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _userLogOut = userLogOut,
        _createUSer = createUser,
        _updateUser = updateUser,
        super(AuthInitial()) {
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthLogOut>(_onAuthLogOut);
    on<AuthUpdateEvent>(_onAuthUpdateEvent);
  }

  void _onAuthSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final res = await _userSignUp(UserSignUpParams(
        email: event.email,
        passowrd: event.password,
      ));

      res.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (right) {
          (r) => emit(AuthSuccess());
          // final respuesta = await _createUSer(CreateUserParams(
          //   uid: right.user!.uid,
          //   name: right.user!.displayName ?? "Sin Nombre",
          //   saldo: 0,
          //   vehiculoId: "vehiculoId",
          // ));

          // respuesta.fold(
          //   (f) => emit(AuthFailure("message")),
          //   (r) => emit(AuthSuccess()),
          // );
        },
      );
    } catch (error) {
      emit(AuthFailure("An unexpected error occurred: ${error.toString()}"));
    }
  }

  void _onAuthUpdateEvent(
      AuthUpdateEvent event, Emitter<AuthState> emit) async {
    final response =
        await _updateUser(UpdateUserParams(name: event.name, uid: event.uid));

    response.fold(
      (ifLeft) {
        emit(AuthFailure(ifLeft.message));
      },
      (ifRight) {
        emit(AuthSuccess());
      },
    );
  }

  void _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(
        AuthSuccess(),
      ),
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
