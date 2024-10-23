import 'package:dash_pass/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dash_pass/features/profile/bloc/profile_bloc.dart';
import 'package:dash_pass/firebase_options.dart';
import 'package:dash_pass/repositories/auth/auth_repository.dart';
import 'package:dash_pass/repositories/auth/auth_repository_impl.dart';
import 'package:dash_pass/repositories/user/user_repository.dart';
import 'package:dash_pass/repositories/user/user_repository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependecies() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  _initAuth();
  _profile();
}

void _initAuth() {
  serviceLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(FirebaseAuth.instance));
  serviceLocator
      .registerLazySingleton<UserRepository>(() => UserRepositoryImpl());

  serviceLocator.registerFactory(
    () => AuthBloc(
      authRepository: serviceLocator<AuthRepository>(),
      userRepository: serviceLocator<UserRepository>(),
    ),
  );
}

void _profile() {
  serviceLocator.registerFactory(
    () => ProfileBloc(
      userRepository: serviceLocator<UserRepository>(),
    ),
  );
}
