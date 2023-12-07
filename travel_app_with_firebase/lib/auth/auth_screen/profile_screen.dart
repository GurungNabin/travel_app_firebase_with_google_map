import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:travel_guide_app/components/my_back_button.dart';

// ignore: must_be_immutable
class MyProfile extends StatelessWidget {
  MyProfile({super.key});

//current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

//future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //error
          else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          //data received
          else if (!snapshot.hasData) {
            return const Text("No data");
          } else {
            //extract data
            Map<String, dynamic>? user = snapshot.data!.data();
            if (user == null) {
              return const Text("No user data");
            }

            // Extract username and email with null checks
            String username = user['username'] ?? 'Username not available';
            String email = user['email'] ?? 'Email not available';

            return Center(
              child: Column(
                children: [
                  //back button
                  const Padding(
                    padding: EdgeInsets.only(top: 60, left: 25),
                    child: Row(
                      children: [
                        MyBackButton(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //profile pic
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: const Icon(
                      Icons.person,
                      size: 65,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //username
                  Text(
                    username,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //email
                  Text(
                    email,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
