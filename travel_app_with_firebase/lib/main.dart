//ID = ram12@gmail.com
//Password = 12345

//Id = admin12@gmail.com
//Password = root12

//nabin@gmail.com
//nabingrg

//admin@gmail.com
//admin123

//sita@gmail.com
//sitagita
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide_app/auth/auth_page.dart';
import 'package:travel_guide_app/auth/login_or_register_page.dart';
import 'package:travel_guide_app/firebase_options.dart';
import 'package:travel_guide_app/screen/home_screen.dart';
import 'package:travel_guide_app/auth/auth_screen/profile_screen.dart';
import 'package:travel_guide_app/screen/note_screen.dart';
import 'package:travel_guide_app/theme/dark_mode.dart';
import 'package:travel_guide_app/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TravelGuide());
}

class TravelGuide extends StatelessWidget {
  const TravelGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/login_register_page': (context) => const LogInOrRegisterPage(),
        '/home_page': (context) => const MyHomeScreen(),
        '/profile_page': (context) => MyProfile(),
        '/note_page': (context) => MyNote(),
      },
    );
  }
}
