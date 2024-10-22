import 'package:dash_pass/core/utils/check_email.dart';
import 'package:dash_pass/core/utils/snack_bars.dart';
import 'package:dash_pass/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dash_pass/features/auth/presentation/widgets/input_field.dart';
import 'package:dash_pass/features/auth/presentation/widgets/login_button.dart';
import 'package:dash_pass/features/auth/presentation/widgets/rich_texts.dart';
import 'package:dash_pass/features/home/presentation/pages/home_page.dart';
import 'package:dash_pass/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? _emailErrorText;
  String? _passwordErrorText;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        _emailErrorText = 'El correo es requerido';
      });
    } else if (!isEmailValid(value)) {
      setState(() {
        _emailErrorText = 'Enter a valid email address';
      });
    } else {
      setState(() {
        _emailErrorText = null;
      });
    }
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _passwordErrorText = "La contrasenia es requerida";
      });
    } else if (value.length < 6) {
      setState(() {
        _passwordErrorText =
            "La contrasenia debe tener por lo menos 6 caracteres";
      });
    } else {
      setState(() {
        _passwordErrorText = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    formKey.currentState?.validate();
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => serviceLocator<AuthBloc>(),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              switch (state) {
                case AuthFailure():
                  credentialError(context, state.message);
                  break;

                case AuthSuccess():
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                default:
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          "assets/logos/dash_pass.svg",
                          height: size.height * 0.2,
                          width: size.width * 0.7,
                        ),
                        SizedBox(height: size.height * 0.04),
                        Text(
                          "Inicia Sesion para empezar a usar Dash Pass",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        InputFieldWidget(
                          title: "Email",
                          hintText: "Ingresa tu correo electronico",
                          controller: emailCtrl,
                          validator: (value) => _emailErrorText,
                          onChange: validateEmail,
                        ),
                        SizedBox(height: size.height * 0.03),
                        InputFieldWidget(
                          title: "Password",
                          hintText: "Ingresa tu contraseña",
                          controller: passCtrl,
                          validator: (value) => _passwordErrorText,
                          onChange: validatePassword,
                          obscureText: true,
                        ),
                        SizedBox(height: size.height * 0.02),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value ?? false;
                                  });
                                },
                              ),
                              Text(
                                "No soy un robot",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        LoginButton(
                          onTap: () {
                            validateEmail(emailCtrl.text);
                            validatePassword(passCtrl.text);
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(AuthLoginEvent(
                                    email: emailCtrl.text.trim(),
                                    password: passCtrl.text.trim(),
                                  ));
                            }
                          },
                          child: state is AuthLoading
                              ? LoadingAnimationWidget.inkDrop(
                                  color: Colors.white, size: 35)
                              : const Text(
                                  "Iniciar Sesion",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                        // const Spacer(),
                        SizedBox(height: size.height * 0.1),
                        const SignInRIchText(),
                        SizedBox(height: size.height * 0.05)
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
