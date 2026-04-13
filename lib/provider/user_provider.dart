import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tute_app/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          id: "error",
          user: FirebaseUser(
            email: "error",
            name: 'error',
            profilePic: 'error',
          ),
        ),
      );
  // Firebase Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Log in Function
  Future<void> login(String email) async {
    QuerySnapshot response = await _firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .get();

    if (response.docs.isEmpty) {
      print("No Firestore user is associated to authenticated email: $email");
      return;
    }

    if (response.docs.length != 1) {
      print("More than one firestore user associate with email: $email");
      return;
    }

    state = LocalUser(
      id: response.docs[0].id,
      user: FirebaseUser.fromMap(
        response.docs[0].data() as Map<String, dynamic>,
      ),
    );
  }

  // Sign Up function
  Future<void> signUp(String email) async {
    // Firebase Firestore
    DocumentReference response = await _firestore
        .collection("users")
        .add(
          FirebaseUser(
            email: email,
            name: 'No Name',
            profilePic: 'http://www.gravatar.com/avatar/?d=mp',
          ).toMap(),
        );
    DocumentSnapshot snapshot = await response.get();
    state = LocalUser(
      id: response.id,
      user: FirebaseUser.fromMap(snapshot.data() as Map<String, dynamic>),
    );
  }

  // Log out function
  void logOut() {
    state = LocalUser(
      id: "error",
      user: FirebaseUser(email: "error", name: 'error', profilePic: 'error'),
    );
  }
}
