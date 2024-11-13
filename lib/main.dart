import 'package:dash_pass/core/shared_preferences/preferences.dart';
import 'package:dash_pass/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dash_pass/features/auth/presentation/pages/login_page.dart';
import 'package:dash_pass/features/home/cubit/navigation_cubit.dart';
import 'package:dash_pass/features/home/cubit/scaffold_color_cubit.dart';
import 'package:dash_pass/features/home/presentation/pages/home_page.dart';
import 'package:dash_pass/features/settings/bloc/profile_bloc.dart';
import 'package:dash_pass/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = Preferences();
  await prefs.init();
  await initDependecies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<ScaffoldColorCubit>(),
        ),
        BlocProvider(
          create: (context) => NavigationCubit(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<ProfileBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: ANIAPAGE(),
    );
  }
}

class ANIAPAGE extends StatefulWidget {
  const ANIAPAGE({super.key});

  @override
  State<ANIAPAGE> createState() => _ANIAPAGEState();
}

class _ANIAPAGEState extends State<ANIAPAGE> {
  @override
  void initState() {
    context.read<AuthBloc>().add(IsUserLoggedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          switch (state) {
            case AuthSuccess():
              return const HomePage();
            case AuthFailure():
              return const LoginPage();
            default:
              return const LoginPage();
          }
        },
      ),
    );
  }
}
