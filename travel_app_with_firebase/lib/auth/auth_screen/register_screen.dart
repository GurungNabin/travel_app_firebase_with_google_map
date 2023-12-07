import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide_app/components/my_button.dart';
import 'package:travel_guide_app/components/my_textformfield.dart';
import 'package:travel_guide_app/components/square_tile.dart';
import 'package:travel_guide_app/services/auth_services.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? onTap;
  const RegisterScreen({super.key, this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
//Text editing controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

//sign user in method
  void signUserUp() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    //try creating the user

    try {
      if (passwordController.text == confirmController.text) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // Check if the widget is still mounted before updating the state
        if (mounted) {
          // Save additional user data to Firestore or your database
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userCredential.user!.email)
              .set({
            'username': nameController.text,
            'email': emailController.text,
            // Add other user data as needed
          });
        }
      } else {
        // Show error message password doesn't match
        showErrorMessage('Password doesn\'t match!');
      }
    } on FirebaseAuthException catch (e) {
      // Show error message
      showErrorMessage(e.code);
    }
  }

  //wrong email message popup
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.lightBlue,
            title: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          );
        });
  }

  //create a user document and collect them in firestore
  Future<void> createuserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': nameController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //logo
                const Image(image: AssetImage('assets/images/logo.png')),

                //let's creat an account for you!
                Text(
                  'Let\'s create an acocunt for you!',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(
                  height: 25,
                ),

                //email, textfield
                MyTextFormField(
                  controller: nameController,
                  hintText: 'Name',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),

                //email, textfield
                MyTextFormField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),

                //password textfield
                MyTextFormField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),

                //confirm password textfield
                MyTextFormField(
                  controller: confirmController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 25,
                ),

                //signup button
                MyButton(
                  text: 'Sign Up',
                  onTap: signUserUp,
                ),
                const SizedBox(
                  height: 25,
                ),

                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                //google + apple sign in button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google button
                    SquareTile(
                        onTap: () => AuthServices().signInWithGoogle(),
                        imagePath: 'assets/images/google.png'),
                    const SizedBox(
                      width: 25,
                    ),
                    //apple button
                    SquareTile(
                        onTap: () {}, imagePath: 'assets/images/apple.png')
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),

                //already have an account? login now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
