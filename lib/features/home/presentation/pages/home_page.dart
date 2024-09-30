import 'package:dash_pass/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dash_pass/features/auth/presentation/pages/login_page.dart';
import 'package:dash_pass/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hello, World!'),
              BlocProvider(
                create: (context) => serviceLocator<AuthBloc>(),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    switch (state) {
                      case AuthInitial():
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                        break;
                      default:
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthLogOut());
                      },
                      child: Text("CERRAR SESION"),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
