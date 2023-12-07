import 'package:flutter/material.dart';
import 'package:travel_guide_app/components/my_list_tile.dart';
import 'package:travel_guide_app/components/my_post_button.dart';
import 'package:travel_guide_app/components/my_textformfield.dart';
import 'package:travel_guide_app/database/firestore.dart';

class MyNote extends StatelessWidget {
  MyNote({super.key});

  //firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  //text controller
  final TextEditingController newPostController = TextEditingController();

  //post message
  void postMessage() {
    //only post message if there is something in the textfield
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    //clear the controller
    newPostController.clear();
  }

  // Delete message
  void deleteMessage(String postId) {
    // Implement the logic to delete the post using postId
    database.deletePost(postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        title: const Center(
          child: Text(
            'Note',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        //Textfiel box for the user to type
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 25, right: 25),
            child: Row(
              children: [
                //textformfield
                Expanded(
                  child: MyTextFormField(
                      hintText: "Say something..",
                      obscureText: false,
                      controller: newPostController),
                ),
                //post button
                PostButton(
                  onTap: postMessage,
                ),
              ],
            ),
          ),
          //posts
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              //show loading circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              //get all posts
              final posts = snapshot.data!.docs;
              //no data?
              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("No Posts.. Post something"),
                  ),
                );
              }

              //return as a list
              return Expanded(
                  child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        //get each individual post
                        final post = posts[index];

                        //get data from each post
                        String message = post['PostMessage'];

                        String postId = post.id;

                        //return as a list tile
                        return MyListTile(
                          title: message,
                          onDelete: () {
                            deleteMessage(postId);
                          },
                        );
                      }));
            },
          ),
        ],
      ),
    );
  }
}
