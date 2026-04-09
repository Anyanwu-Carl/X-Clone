import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tute_app/firebase_options.dart';
import 'package:tute_app/pages/signin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      debugShowCheckedModeBanner: false,
      routes: {"/": (context) => const SignInPage()},
    );
  }
}
