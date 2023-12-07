import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide_app/components/my_button.dart';
import 'package:travel_guide_app/components/my_textformfield.dart';
import 'package:travel_guide_app/components/square_tile.dart';
import 'package:travel_guide_app/services/auth_services.dart';

class LogInScreen extends StatefulWidget {
  final Function()? onTap;
  const LogInScreen({super.key, this.onTap});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
//Text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

//sign user in method
  void signUserIn() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      //pop the loading circle
      Navigator.pop(context);
      // Navigator.pop(context);
    } on FirebaseAuthException {
      //pop the loading circle
      Navigator.pop(context);
      // Navigator.pop(context);
      //show error message
      showErrorMessage('Plese enter the necessary information');
    }
  }

  //wrong email message popup
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey,
            title: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //logo
                const Image(
                  image: AssetImage(
                    'assets/images/Work.jpg',
                  ),
                  fit: BoxFit.fill,
                ),

                //welcome
                Text(
                  'Welcome ',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(
                  height: 25,
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

                //forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),

                //signin button
                MyButton(
                  text: 'Sign In',
                  onTap: signUserIn,
                ),
                const SizedBox(
                  height: 50,
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
                  height: 50,
                ),

                //not a memeber? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
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
                        'Register now',
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
