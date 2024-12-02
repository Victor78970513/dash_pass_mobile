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

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController carnetController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? _emailErrorText;
  String? _passwordErrorText;
  String? _confirmPasswordErrorText;
  String? _carnetErrorText;
  String? _phoneErrorText;
  bool isChecked = false;

  void validateEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        _emailErrorText = 'El correo es requerido';
      });
    } else if (!isEmailValid(value)) {
      setState(() {
        _emailErrorText = 'Ingresa un correo electrónico válido';
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
        _passwordErrorText = "La contraseña es requerida";
      });
    } else if (value.length < 6) {
      setState(() {
        _passwordErrorText = "La contraseña debe tener al menos 6 caracteres";
      });
    } else {
      setState(() {
        _passwordErrorText = null;
      });
    }
  }

  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _confirmPasswordErrorText =
            "La confirmación de la contraseña es requerida";
      });
    } else if (value != passCtrl.text) {
      setState(() {
        _confirmPasswordErrorText = "Las contraseñas no coinciden";
      });
    } else {
      setState(() {
        _confirmPasswordErrorText = null;
      });
    }
  }

  void validateCarnet(String value) {
    if (value.isEmpty) {
      setState(() {
        _carnetErrorText = "El carnet es requerido";
      });
    } else {
      setState(() {
        _carnetErrorText = null;
      });
    }
  }

  void validatePhone(String value) {
    if (value.isEmpty) {
      setState(() {
        _phoneErrorText = "El teléfono es requerido";
      });
    } else if (value.length < 8) {
      setState(() {
        _phoneErrorText = "El teléfono debe tener al menos 10 caracteres";
      });
    } else {
      setState(() {
        _phoneErrorText = null;
      });
    }
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    carnetController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                          height: size.height * 0.15,
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
                        const SizedBox(height: 10),
                        InputFieldWidget(
                          title: "Email",
                          hintText: "Ingresa tu nombre",
                          controller: nameCtrl,
                        ),
                        const SizedBox(height: 10),
                        InputFieldWidget(
                          title: "Email",
                          hintText: "Ingresa tu correo electrónico",
                          controller: emailCtrl,
                          validator: (value) {
                            if (_emailErrorText != null) return _emailErrorText;
                            return null;
                          },
                          onChange: validateEmail,
                        ),
                        const SizedBox(height: 15),
                        InputFieldWidget(
                          title: "Carnet",
                          hintText: "Ingresa tu carnet",
                          controller: carnetController,
                          validator: (value) {
                            if (_carnetErrorText != null)
                              return _carnetErrorText;
                            return null;
                          },
                          onChange: validateCarnet,
                        ),
                        const SizedBox(height: 15),
                        InputFieldWidget(
                          title: "Teléfono",
                          hintText: "Ingresa tu teléfono",
                          controller: phoneController,
                          validator: (value) {
                            if (_phoneErrorText != null) return _phoneErrorText;
                            return null;
                          },
                          onChange: validatePhone,
                        ),
                        const SizedBox(height: 15),
                        InputFieldWidget(
                          title: "Contraseña",
                          hintText: "Ingresa tu contraseña",
                          controller: passCtrl,
                          validator: (value) {
                            if (_passwordErrorText != null)
                              return _passwordErrorText;
                            return null;
                          },
                          onChange: validatePassword,
                          obscureText: true,
                        ),
                        const SizedBox(height: 15),
                        InputFieldWidget(
                          title: "Confirmar Contraseña",
                          hintText: "Confirma tu contraseña",
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (_confirmPasswordErrorText != null)
                              return _confirmPasswordErrorText;
                            return null;
                          },
                          onChange: validateConfirmPassword,
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
                            validateConfirmPassword(
                                confirmPasswordController.text);
                            validateCarnet(carnetController.text);
                            validatePhone(phoneController.text);

                            if (formKey.currentState!.validate() && isChecked) {
                              context.read<AuthBloc>().add(AuthSignUpEvent(
                                    email: emailCtrl.text.trim(),
                                    password: passCtrl.text.trim(),
                                    username: 'wiscocho',
                                    carnet: int.parse(carnetController.text),
                                    phone: int.parse(phoneController.text),
                                  ));
                            }
                          },
                          child: state is AuthLoading
                              ? LoadingAnimationWidget.inkDrop(
                                  color: Colors.white,
                                  size: 35,
                                )
                              : const Text(
                                  "Crear Cuenta",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                        SizedBox(height: size.height * 0.1),
                        const SignUpRIchText(),
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
