import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tute_app/provider/post_provider.dart';

class CreatePostPage extends ConsumerWidget {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController postController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Create Tweet"), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLines: 4,
              decoration: InputDecoration(border: OutlineInputBorder()),
              controller: postController,
              maxLength: 280,
            ),
          ),

          // POST BUTTON
          TextButton(
            onPressed: () {
              // Read postProvider
              ref.read(postProvider).postPost(postController.text);

              // Go to previous screen
              Navigator.pop(context);
            },
            child: Text("Post"),
          ),
        ],
      ),
    );
  }
}
