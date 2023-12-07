import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide_app/screen/favourite_Screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  //logout user
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          children: [
            //drawer header
            DrawerHeader(
              child: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // //home tile
            // Padding(
            //   padding: const EdgeInsets.only(left: 25.0),
            //   child: ListTile(
            //     leading: Icon(
            //       Icons.home,
            //       color: Theme.of(context).colorScheme.inversePrimary,
            //     ),
            //     title: const Text("H O M E"),
            //     onTap: () {
            //       //this is already the home screen
            //       Navigator.pop(context);
            //     },
            //   ),
            // ),
            //profile tile
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: const Text("P R O F I L E"),
                onTap: () {
                  //this is already the home screen
                  Navigator.pop(context);
                  //navigate to profile page
                  Navigator.pushNamed(context, '/profile_page');
                },
              ),
            ),

            //post
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.note_alt_outlined,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: const Text("N O T E"),
                onTap: () {
                  //this is already the home screen
                  Navigator.pop(context);
                  //navigate to user page
                  Navigator.pushNamed(context, '/note_page');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: const Text("F A V O U R I T E S"),
                onTap: () {
                  //this is already the home screen
                  Navigator.pop(context);
                  //navigate to user page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ViewFavouriteScreen()));
                },
              ),
            ),
          ],
        ),
        //logout tile
        Padding(
          padding: const EdgeInsets.only(left: 25.0, bottom: 25),
          child: ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            title: const Text("L O G O U T"),
            onTap: () {
              //this is already the home screen
              Navigator.pop(context);
              //logout
              logout();
            },
          ),
        ),
      ]),
    );
  }
}
