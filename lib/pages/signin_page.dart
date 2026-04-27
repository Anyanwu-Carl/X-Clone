import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tute_app/pages/signup_page.dart';
import 'package:tute_app/provider/user_provider.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  // Firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _signInKey = GlobalKey();

  // Email and password controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Regex format for email
  final RegExp emailValid = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  // Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _signInKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 120.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // X logo
                // Image.asset("assets/images/x-logo.avif", height: 60),
                FaIcon(
                  FontAwesomeIcons.xTwitter,
                  color: Colors.white,
                  size: 60,
                ),

                const SizedBox(height: 30),

                // Sign-in Text
                Text(
                  "Sign in to X",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500,
                  ),
                ),

                // LOG IN WITH GOOGLE BUTTON
                Container(
                  margin: const EdgeInsets.only(bottom: 25, top: 25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Google logo
                        Image.asset("assets/images/google-img.png", height: 20),

                        SizedBox(width: 10),

                        // Sign-in with google text
                        Text(
                          "Sign in with Google",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // LOG IN WITH APPLE BUTTON
                Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Apple logo
                        Image.asset("assets/images/apple-img.png", height: 20),

                        SizedBox(width: 10),

                        // Sign-in with apple text
                        Text(
                          "Sign in with Apple",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // EMAIL
                Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextFormField(
                    key: const ValueKey("loginEmail"),
                    style: TextStyle(color: Colors.white),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Enter an email",
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20.0,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an email";
                      }
                      // Email validation using regex
                      else if (!emailValid.hasMatch(value)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                ),

                // PASSWORD
                Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextFormField(
                    key: const ValueKey("loginPassword"),
                    style: TextStyle(color: Colors.white),
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter a password",
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20.0,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a password";
                      } else if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                ),

                // SUBMIT BUTTON
                Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton(
                    key: const ValueKey("loginButton"),
                    onPressed: () async {
                      if (_signInKey.currentState!.validate()) {
                        try {
                          await _auth.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );

                          // Sigin state notifier
                          await ref
                              .read(userProvider.notifier)
                              .login(emailController.text);
                        }
                        // Error
                        catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      }
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                // FORGOT PASSWORD BUTTON
                Container(
                  margin: EdgeInsets.only(bottom: 25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white, width: 2.0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (_signInKey.currentState!.validate()) {
                        debugPrint("Email: ${emailController.text}");
                        debugPrint("Password: ${passwordController.text}");
                      }
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                // Don't have an account? Sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Don't have an account? text
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey.shade500),
                    ),

                    // Sign up button
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign Up!",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
