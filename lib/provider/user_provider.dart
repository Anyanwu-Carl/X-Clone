import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tute_app/models/user.dart';

final userProvider = StateNotifierProvider<UserNotifier, LocalUser>((ref) {
  return UserNotifier();
});

class LocalUser {
  LocalUser({required this.id, required this.user});

  final String id;
  final FirebaseUser user;

  LocalUser copyWith({String? id, FirebaseUser? user}) {
    return LocalUser(id: id ?? this.id, user: user ?? this.user);
  }
}

class UserNotifier extends StateNotifier<LocalUser> {
  UserNotifier()
    : super(
        LocalUser(
          id: "",
          user: FirebaseUser(email: "", name: "", profilePic: ""),
        ),
      );

  // Firebase Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Log in Function
  Future<void> login(String s) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) return;

    final doc = await _firestore.collection("users").doc(currentUser.uid).get();

    if (!doc.exists) return;

    state = LocalUser(
      id: doc.id,
      user: FirebaseUser.fromMap(doc.data() as Map<String, dynamic>),
    );
  }

  Future<void> loadUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) return;

    final doc = await _firestore.collection("users").doc(currentUser.uid).get();

    if (!doc.exists) return;

    state = LocalUser(
      id: doc.id,
      user: FirebaseUser.fromMap(doc.data() as Map<String, dynamic>),
    );
  }

  // ------CREATE DATA----------
  // Sign Up function
  Future<void> signUp(String email) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception("User not authenticated");
    }

    await _firestore
        .collection("users")
        .doc(currentUser.uid)
        .set(
          FirebaseUser(
            email: email,
            name: currentUser.email!,
            profilePic: 'http://www.gravatar.com/avatar/?d=mp',
          ).toMap(),
        );

    state = LocalUser(
      id: currentUser.uid,
      user: FirebaseUser(
        email: email,
        name: currentUser.email!,
        profilePic: 'http://www.gravatar.com/avatar/?d=mp',
      ),
    );
  }

  // ----UPDATE DATA-------
  Future<void> updateName(String name) async {
    if (state.id.isEmpty || state.id == "error") {
      throw Exception("User not properly initialized or logged in");
    }

    await _firestore.collection("users").doc(state.id).update({"name": name});
    state = state.copyWith(user: state.user.copyWith(name: name));
  }

  // ----UPDATE PICTURE-------
  Future<void> updateImage(File image) async {
    if (state.id.isEmpty || state.id == "error") {
      throw Exception("User not properly initialized or logged in");
    }

    Reference ref = _storage.ref().child("users").child(state.id);
    TaskSnapshot snapshot = await ref.putFile(image);
    String profilePicUrl = await snapshot.ref.getDownloadURL();

    await _firestore.collection("users").doc(state.id).update({
      "profilePic": profilePicUrl,
    });
    state = state.copyWith(
      user: state.user.copyWith(profilePic: profilePicUrl),
    );
  }

  // Log out function
  void logOut() {
    FirebaseAuth.instance.signOut(); // important

    state = LocalUser(
      id: "",
      user: FirebaseUser(email: "", name: '', profilePic: ''),
    );
  }
}
