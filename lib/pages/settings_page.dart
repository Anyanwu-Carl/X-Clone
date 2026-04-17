import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tute_app/provider/user_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    LocalUser currentUser = ref.watch(userProvider);
    nameController.text = currentUser.user.name;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "S E T T I N G S",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // PROFILE PICTURE
          GestureDetector(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              // Pick an image
              final XFile? pickedImage = await picker.pickImage(
                source: ImageSource.gallery,
                requestFullMetadata: false,
              );
              if (pickedImage != null) {
                ref
                    .read(userProvider.notifier)
                    .updateImage(File(pickedImage.path));
              }
            },
            child: CircleAvatar(
              radius: 100,
              foregroundImage: NetworkImage(currentUser.user.profilePic),
            ),
          ),

          SizedBox(height: 10),

          // TAP TO CHANGE NAME
          Center(
            child: Text(
              "Tap Image to change it",
              style: TextStyle(color: Colors.white),
            ),
          ),

          SizedBox(height: 10),

          // UPDATE NAME FORM FIELD
          TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Enter your Name",
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            controller: nameController,
          ),
          TextButton(
            onPressed: () {
              ref.watch(userProvider.notifier).updateName(nameController.text);
            },
            child: Text(
              "Update",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
