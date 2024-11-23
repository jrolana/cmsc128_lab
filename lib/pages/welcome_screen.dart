import 'package:cmsc128_lab/pages/login_screen.dart';
import 'package:cmsc128_lab/pages/signup_screen.dart';
import 'package:cmsc128_lab/widgets/welcome_button.dart';
import 'package:flutter/material.dart';
import 'package:cmsc128_lab/widgets/custom_scaffold.dart';
import '../utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
              flex: 8,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 40.0),
                child: Center(
                    child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Welcome Back!\n',
                        style: TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.w600,
                            color: StyleColor.primary,
                            fontFamily: GoogleFonts.lexendDeca().fontFamily)),
                    TextSpan(
                        text: '\nJump into better habits, one step at a time.',
                        style: TextStyle(
                          fontSize: 20,
                          color: StyleColor.primary,
                          fontFamily: GoogleFonts.lexendDeca().fontFamily
                        ))
                  ]),
                )),
              )),
          const Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    Expanded(
                      child: WelcomeButton(
                        buttonText: 'Log In',
                        onTap: LogInScreen(),
                        color: StyleColor.primary,
                        textColor: StyleColor.alternate,
                      ),
                    ),
                    Expanded(
                      child: WelcomeButton(
                        buttonText: 'Sign Up',
                        onTap: SignUpScreen(),
                        color: StyleColor.alternate,
                        textColor: StyleColor.primary,
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
