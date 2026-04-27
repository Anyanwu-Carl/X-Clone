import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tute_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  setUp(() async {
    await FirebaseAuth.instance.signOut();
  });
  testWidgets("log in, check for tweet, log out", (tester) async {
    app.main();
    await tester.pumpAndSettle();

    Finder loginText = find.text("Sign in to X");
    expect(loginText, findsOneWidget);

    Finder loginEmail = find.byKey(const ValueKey("loginEmail"));
    Finder loginPassword = find.byKey(const ValueKey("loginPassword"));
    Finder loginButton = find.byKey(const ValueKey("loginButton"));
    Finder profilePic = find.byKey(const ValueKey("profilePic"));
    Finder signOut = find.byKey(const ValueKey("signOut"));

    await tester.enterText(loginEmail, "carl@gmail.com");
    await tester.enterText(loginPassword, "password");
    await tester.tap(loginButton);
    await tester.pump();

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    Finder postName = find.text("Carl Ocee");
    expect(postName, findsOneWidget);

    await tester.tap(profilePic);
    await tester.pumpAndSettle();

    await tester.tap(signOut);
    await tester.pumpAndSettle();

    expect(loginText, findsOneWidget);
  });
}
