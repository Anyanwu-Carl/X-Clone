import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tute_app/provider/user_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("H O M E"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              ref.read(userProvider.notifier).logOut();
            },
            child: Text("Sign Out"),
          ),
        ],
      ),
      body: Column(
        children: [
          Text(ref.watch(userProvider).user.email),
          Text(ref.watch(userProvider).user.name),
          CircleAvatar(
            backgroundImage: NetworkImage(
              ref.watch(userProvider).user.profilePic,
            ),
          ),
        ],
      ),
    );
  }
}
