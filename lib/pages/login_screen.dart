import 'package:cmsc128_lab/pages/forgot_password_screen.dart';
import 'package:cmsc128_lab/pages/signup_screen.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:cmsc128_lab/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cmsc128_lab/pages/navbar.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the Google Authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      // Obtain the auth details from the Google sign-in
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with the credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Return the signed-in user
      return userCredential.user;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in with Google: $e"),
      ));
      return null;
    }
  }
}

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  String email = "", password = "";
  bool rememeberPassword = true;
  String? errorMessage = '';
  bool isLogin = true;

  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Sorry! There is no user found for this Email.",
              style: TextStyle(fontSize: 18.0),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Incorrect password, try again.",
              style: TextStyle(fontSize: 18.0),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 2,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
                padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: SingleChildScrollView(
                    child: Form(
                  key: _formSignInKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w900,
                            color: StyleColor.primary,
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Email';
                            }
                            return null;
                          },
                          controller: mailcontroller,
                          decoration: InputDecoration(
                            label: const Text('Email'),
                            hintText: 'Enter Email',
                            hintStyle: const TextStyle(
                              color: StyleColor.primaryText,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: StyleColor.secondary,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: StyleColor.secondary,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        TextFormField(
                          obscureText: true,
                          obscuringCharacter: '*',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          },
                          controller: passwordcontroller,
                          decoration: InputDecoration(
                            label: const Text('Password'),
                            hintText: 'Enter Password',
                            hintStyle: const TextStyle(
                              color: StyleColor.primaryText,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: StyleColor.secondary,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: StyleColor.secondary,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPassword()));
                              },
                              child: const Text(
                                'Forget Password?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: StyleColor.primary,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formSignInKey.currentState!.validate()) {
                                setState(() {
                                  email = mailcontroller.text;
                                  password = passwordcontroller.text;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Logging you in...')));
                                });
                              }
                              userLogin();
                            },
                            child: const Text('Log In'),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 25.0,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Expanded(
                        //       child: Divider(
                        //         thickness: 0.7,
                        //         color: Colors.grey.withOpacity(0.5),
                        //       ),
                        //     ),
                        //     const Padding(
                        //       padding: EdgeInsets.symmetric(
                        //         vertical: 0,
                        //         horizontal: 10,
                        //       ),
                        //       child: Text(
                        //         'Sign Up With',
                        //         style: TextStyle(
                        //           color: StyleColor.primaryText,
                        //         ),
                        //       ),
                        //     ),
                        //     Expanded(
                        //         child: Divider(
                        //       thickness: 0.7,
                        //       color: Colors.grey.withOpacity(0.7),
                        //     )),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 25.0,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     GestureDetector(
                        //       onTap: () async {
                        //         User? user = await AuthMethods().signInWithGoogle(context);
                        //         if (user != null) {
                        //           Navigator.push(
                        //             context,
                        //             MaterialPageRoute(builder: (context) => const BottomNavBar()),
                        //           );
                        //         }
                        //       },
                        //       child: Logo(Logos.google),
                        //     )
                        //   ],
                        // ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Are you new here? ',
                              style: TextStyle(
                                color: StyleColor.primaryText,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (e) =>
                                              const SignUpScreen()));
                                },
                                child: const Text('Sign Up',
                                style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: StyleColor.primary,)),
                        )],
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                      ]),
                ))),
          )
        ],
      ),
    );
  }
}
