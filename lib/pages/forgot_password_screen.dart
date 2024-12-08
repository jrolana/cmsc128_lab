import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cmsc128_lab/pages/signup_screen.dart';
import 'package:cmsc128_lab/pages/home.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:cmsc128_lab/widgets/custom_scaffold.dart';
import 'package:icons_plus/icons_plus.dart';
import '../auth.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = "";
  TextEditingController mailcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Password Reset Email has been sent !",
        style: TextStyle(fontSize: 20.0),
      )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "No user found for that email.",
          style: TextStyle(fontSize: 20.0),
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: StyleColor.primary),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 70.0,
          ),
          Container(
            alignment: Alignment.topCenter,
            child: const Text(
              "Password Recovery",
              style: TextStyle(
                  color: StyleColor.primary,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            "Enter your mail",
            style: TextStyle(
                color: StyleColor.secondary,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
              child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: ListView(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: StyleColor.secondary, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Email';
                              }
                              return null;
                            },
                            controller: mailcontroller,
                            style:
                                const TextStyle(color: StyleColor.primaryText),
                            decoration: const InputDecoration(
                                hintText: "Enter your Email",
                                hintStyle: TextStyle(
                                    fontSize: 15.0,
                                    color: StyleColor.primaryText),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: StyleColor.secondary,
                                  size: 30.0,
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                email = mailcontroller.text;
                              });
                              resetPassword();
                            }
                          },
                          child: Container(
                            width: 140,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: StyleColor.alternate,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                "Send to my Email",
                                style: TextStyle(
                                    color: StyleColor.primary,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: StyleColor.primaryText),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen()));
                              },
                              child: const Text(
                                "Create an Account",
                                style: TextStyle(
                                    color: StyleColor.primary,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }
}
