import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Forgot.dart';
import 'bottomnavbars.dart';
import 'homescreen.dart';
import 'CreateAccountScreen.dart';
import 'dart:async';  // Import the async library for Timer

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _obscureText = true;
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // State variables for timer
  int _start = 60;
  bool _isTimerRunning = false;
  Timer? _timer;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _timer?.cancel();  // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _email.text,
          password: _password.text,
        );
        User? user = userCredential.user;

        // Fetch user's full name from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        String fullName = userDoc['fullname'];


        if (user != null) {
          if (user.emailVerified) {
            if (userDoc.exists) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>
                    trackitnavbars(username:fullName),
                  // HomeScreen(username:  user.uid,)
                ),
              );
            } else {
              print("User document does not exist.");
            }
            setState(() {
              _isLoading = false;
            });
          } else {
            setState(() {
              _isLoading = false;
              _start = 60; // Reset timer
              _isTimerRunning = true;
              _startTimer();
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please verify your email address.')),
            );
            await user.sendEmailVerification();
          }
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign in: ${e.toString()}')),
        );
      }
    }
  }

  // Start the countdown timer
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isTimerRunning = false;
        });
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  Future<void> _resendVerificationEmail() async {
    User? user = _auth.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification email sent.')),
      );
      setState(() {
        _start = 60; // Reset timer
        _isTimerRunning = true;
        _startTimer();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).viewPadding;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Welcome',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Lilita_One',
                          fontSize: 33,
                          fontWeight: FontWeight.w100,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60.0),
                      topRight: Radius.circular(60.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(height: 60),
                            Text(
                              "Username or Email",
                              style:
                              TextStyle(fontFamily: 'Nunito', fontSize: 20),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(32),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFcfd1dd).withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: TextFormField(
                                  controller: _email,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: 'example@example.com',
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Text(
                              "Password",
                              style:
                              TextStyle(fontFamily: 'Nunito', fontSize: 20),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(32),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFcfd1dd).withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: TextFormField(
                                  controller: _password,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: _togglePasswordVisibility,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 50),
                            Center(
                              child: _isLoading ? SpinKitCircle(
                                color: Colors.blue,duration: Duration(milliseconds: 100),
                                size: 40,) : ElevatedButton(
                                onPressed: (){
                                  _login();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 50,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      style: BorderStyle.none,
                                    ),
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                ),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).buttonTheme.colorScheme?.primary,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 60),
                            Center(
                              child: _isTimerRunning ? Text(
                                "Please wait $_start seconds",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontFamily: 'Nunito',
                                ),
                              ) : TextButton(
                                onPressed: _resendVerificationEmail,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Didn't get the email?",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                    SizedBox(width: 7),
                                    Text(
                                      'Resend Verification Email',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
