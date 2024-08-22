import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit/Sub-Directory/LoginPage.dart';
import 'package:trackit/Sub-Directory/WelcomePage.dart';
import 'package:trackit/Sub-Directory/bottomnavbars.dart';
import 'package:trackit/Sub-Directory/homescreen.dart';
import 'package:trackit/checker.dart';
import 'Sub-Directory/Onboarding.dart';
import 'Sub-Directory/ProfileSection/ChangePassword.dart';
import 'Sub-Directory/ProfileSection/Deleteaccountscreen.dart';
import 'Sub-Directory/ProfileSection/SetNotificationsscreen.dart';
import 'Sub-Directory/ProfileSection/changepinscreen.dart';
import 'Sub-Directory/ProfileSection/editprofilescreen.dart';
import 'Sub-Directory/ProfileSection/privacystatements.dart';
import 'Sub-Directory/ThemeNotifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.playIntegrity,
      appleProvider: AppleProvider.appAttest
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Onboarding(),
      // home: trackitnavbars(username: '',),
      // home: Checker(),
      routes: {
        '/Login': (context) => Login(),
        '/login': (context) => WelcomeScreen(),
        '/editprofile': (context) => EditProfileScreen(),
        '/changepin': (context) => changepinscreen(),
        '/terms': (context) => TermsndCoditions(),
        '/home': (context) => HomeScreen(username: String.fromEnvironment('')),
        '/nav': (context) => trackitnavbars(username: String.fromEnvironment('')),
        '/notifications': (context) => Notificationsettings(),
        '/changepassword': (context) => changePasswordscreen(),
        '/deleteaccount': (context) => deleteaccount(),
      },
    );
  }
}