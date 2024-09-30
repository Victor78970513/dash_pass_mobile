import 'package:dash_pass/features/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInRIchText extends StatelessWidget {
  const SignInRIchText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Aun no tienes una cuenta? ",
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        children: [
          TextSpan(
            text: "Crear cuenta",
            style: GoogleFonts.poppins(
              color: const Color(0xff439A97),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const SignUpPage()));
              },
          )
        ],
      ),
    );
  }
}

class SignUpRIchText extends StatelessWidget {
  const SignUpRIchText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Ya tienes una cuenta?  ",
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        children: [
          TextSpan(
            text: "Iniciar Sesion",
            style: GoogleFonts.poppins(
              color: const Color(0xff439A97),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pop(context);
              },
          )
        ],
      ),
    );
  }
}
