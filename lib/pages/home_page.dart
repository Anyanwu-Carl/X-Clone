import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tute_app/models/post.dart';
import 'package:tute_app/pages/create_post_page.dart';
import 'package:tute_app/pages/settings_page.dart';
import 'package:tute_app/provider/post_provider.dart';
import 'package:tute_app/provider/user_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LocalUser currentUser = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(color: Colors.grey, height: 1),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: FaIcon(FontAwesomeIcons.xTwitter, color: Colors.white, size: 30),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    ref.watch(userProvider).user.profilePic,
                  ),
                ),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),

      // App body
      body: ref
          .watch(feedProvider)
          .when(
            data: (List<Post> posts) {
              return ListView.separated(
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.grey),
                itemCount: posts.length,
                itemBuilder: (context, count) {
                  return ListTile(
                    leading: CircleAvatar(
                      foregroundImage: NetworkImage(posts[count].profilePic),
                    ),
                    title: Text(
                      posts[count].name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      posts[count].post,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                },
              );
            },
            error: (error, StackTrace) => const Center(child: Text("error")),
            loading: () => Center(child: const CircularProgressIndicator()),
          ),

      // Drawer
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Column(
          children: [
            // Profile Pic
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          currentUser.user.profilePic,
                        ),
                      ),

                      const Spacer(),

                      // More_vert Icon
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert_outlined),
                        color: Colors.white,
                      ),
                    ],
                  ),

                  // Username
                  Text(
                    currentUser.user.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // Email
                  Text(
                    currentUser.user.email,
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade300),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // -----------List Tiles---------------
            // Profile
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.person_2_outlined,
                  color: Colors.white,
                  size: 28,
                ),
                title: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Premium
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.xTwitter,
                  color: Colors.white,
                  size: 28,
                ),
                title: Text(
                  "Premium",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Chat
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: Colors.white,
                  size: 28,
                ),
                title: Text(
                  "Chat",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // BookMarks
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.bookmark_border_outlined,
                  color: Colors.white,
                  size: 28,
                ),
                title: Text(
                  "Bookmarks",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Lists
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.list_alt_outlined,
                  color: Colors.white,
                  size: 28,
                ),
                title: Text(
                  "Lists",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Spaces
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.person_2_outlined,
                  color: Colors.white,
                  size: 28,
                ),
                title: Text(
                  "Spaces",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Divider(),

            // Settings and support
            GestureDetector(
              onTap: () {
                Navigator.pop(context);

                // Navigate to settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
              child: ListTile(
                title: Text(
                  "Settings & Support",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
            const Spacer(),

            // Sign-out
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Sign-out
                      FirebaseAuth.instance.signOut();
                      ref.read(userProvider.notifier).logOut();
                    },
                    child: ListTile(
                      title: Text(
                        "Sign out",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      trailing: Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // FLOATING ACTION BUTTON TO CREATE TWEET
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
