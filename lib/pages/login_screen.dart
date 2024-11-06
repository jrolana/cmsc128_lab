import 'package:cmsc128_lab/pages/signup_screen.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:cmsc128_lab/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  bool rememeberPassword = true;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
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
                              decoration: InputDecoration(
                                label: const Text('Email'),
                                hintText: 'Enter Email',
                                hintStyle: const TextStyle(
                                  color: StyleColor.primaryText,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black,
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
                              decoration: InputDecoration(
                                label: const Text('Password'),
                                hintText: 'Enter Password',
                                hintStyle: const TextStyle(
                                  color: StyleColor.primaryText,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: StyleColor.primaryText,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: StyleColor.primaryText,
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
                                Row(
                                  children: [
                                    Checkbox(
                                      value: rememeberPassword,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          rememeberPassword = value!;
                                        });
                                      },
                                      activeColor: StyleColor.primary,
                                    ),
                                    const Text(
                                      'Remember Me',
                                      style: TextStyle(
                                        color: StyleColor.primaryText,
                                      ),
                                    )
                                  ],
                                ),
                                GestureDetector(
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
                                  if (_formSignInKey.currentState!.validate() &&
                                      rememeberPassword) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Processing Data')));
                                  } else if (!rememeberPassword) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Please agree to the processing of personal')));
                                  }
                                },
                                child: const Text('Log In'),
                              ),
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 0.7,
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                  ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    'Sign Up With',
                                    style: TextStyle(
                                      color: StyleColor.primaryText,
                                    ),),
                                  ),
                                Expanded(child: Divider(
                                  thickness: 0.7,
                                  color: Colors.grey.withOpacity(0.5),
                                )),
                              ],
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Logo(Logos.google),
                              ],
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Are you new here?',
                                  style: TextStyle(
                                    color: StyleColor.primaryText,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (e) => const SignUpScreen())
                                    );
                                  },
                                  child: const Text(' Sign Up')
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                          ]),
                          
                  ))),
      )],
      ),
    );
  }
}
