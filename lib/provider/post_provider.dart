import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tute_app/models/post.dart';
import 'package:tute_app/provider/user_provider.dart';

final feedProvider = StreamProvider.autoDispose<List<Post>>((ref) {
  return FirebaseFirestore.instance
      .collection("posts")
      .orderBy("postTime", descending: true)
      .snapshots()
      .map((event) {
        List<Post> posts = [];

        for (int i = 0; i < event.docs.length; i++) {
          posts.add(Post.fromMap(event.docs[i].data()));
        }

        return posts;
      });
});

final postProvider = Provider<XApi>((ref) {
  return XApi(ref);
});

class XApi {
  XApi(this.ref);
  final Ref ref;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> postPost(String post) async {
    LocalUser currentUser = ref.read(userProvider);

    await _firestore
        .collection("posts")
        .add(
          Post(
            uid: currentUser.id,
            profilePic: currentUser.user.profilePic,
            name: currentUser.user.name,
            post: post,
            postTime: Timestamp.now(),
          ).toMap(),
        );
  }
}
