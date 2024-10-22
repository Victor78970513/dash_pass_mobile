import 'package:dash_pass/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:dash_pass/features/auth/data/repository/auth_repository_impl.dart';
import 'package:dash_pass/features/auth/domain/repository/auth_repository.dart';
import 'package:dash_pass/features/auth/domain/usecases/create_user.dart';
import 'package:dash_pass/features/auth/domain/usecases/update_user.dart';
import 'package:dash_pass/features/auth/domain/usecases/user_log_out.dart';
import 'package:dash_pass/features/auth/domain/usecases/user_login.dart';
import 'package:dash_pass/features/auth/domain/usecases/user_sign_up.dart';
import 'package:dash_pass/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dash_pass/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependecies() async {
  _initAuth();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void _initAuth() {
  serviceLocator
      .registerFactory<AuthRemoteDataSource>(() => AuthRemoteSourceImpl());

  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        serviceLocator<AuthRemoteDataSource>(),
      ));

  serviceLocator.registerFactory(() => UserLogin(
        serviceLocator<AuthRepository>(),
      ));

  serviceLocator.registerFactory(() => UserSignUp(
        serviceLocator<AuthRepository>(),
      ));

  serviceLocator.registerFactory(() => UserLogOut(
        serviceLocator<AuthRepository>(),
      ));
  serviceLocator.registerFactory(() => CreateUser(
        serviceLocator<AuthRepository>(),
      ));
  serviceLocator.registerFactory(() => UpdateUser(
        serviceLocator<AuthRepository>(),
      ));

  serviceLocator.registerFactory(() => AuthBloc(
        userSignUp: serviceLocator<UserSignUp>(),
        userLogin: serviceLocator<UserLogin>(),
        userLogOut: serviceLocator<UserLogOut>(),
        createUser: serviceLocator<CreateUser>(),
        updateUser: serviceLocator<UpdateUser>(),
      ));
}
