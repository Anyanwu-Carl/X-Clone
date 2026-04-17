import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String uid;
  final String profilePic;
  final String name;
  final String post;
  final Timestamp postTime;

  Post({
    required this.uid,
    required this.profilePic,
    required this.name,
    required this.post,
    required this.postTime,
  });

  //  -------DATA CLASS-------
  Post copyWith({
    String? uid,
    String? profilePic,
    String? name,
    String? post,
    Timestamp? postTime,
  }) {
    return Post(
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      name: name ?? this.name,
      post: post ?? this.post,
      postTime: postTime ?? this.postTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'profilePic': profilePic,
      'name': name,
      'post': post,
      'postTime': postTime,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      uid: map['uid'] ?? '',
      profilePic: map['profilePic'] ?? '',
      name: map['name'] ?? '',
      post: map['post'] ?? '',
      postTime: map['postTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(uid: $uid, profilePic: $profilePic, name: $name, post: $post, postTime: $postTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.uid == uid &&
        other.profilePic == profilePic &&
        other.name == name &&
        other.post == post &&
        other.postTime == postTime;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        profilePic.hashCode ^
        name.hashCode ^
        post.hashCode ^
        postTime.hashCode;
  }
}
