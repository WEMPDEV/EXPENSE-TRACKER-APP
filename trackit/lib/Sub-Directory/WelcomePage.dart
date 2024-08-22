import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trackit/Sub-Directory/bottomnavbars.dart';
import 'package:trackit/Sub-Directory/services/auth_servicefacebook.dart';
import 'Forgot.dart';
import 'homescreen.dart';
import 'CreateAccountScreen.dart';
import 'services/auth_servicegoogle.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _obscureText = true;
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
  void _resetForm(){
    _formKey.currentState?.reset();
    _email.clear();
    _password.clear();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      // _resetForm;
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
              // String fullName = userDoc['fullname'];
              setState(() {
              _isLoading = false;
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => trackitnavbars(
                  username: fullName,
                ),
              ),
            );
          } else {
              print("User document does not exist.");
            }
              setState(() {
              _isLoading = false;
            });
              await user.sendEmailVerification();
          }else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please verify your email address.')),
            );
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign in: ${e.toString()}')),
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  final FirebaseAuth _gauth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      // The user canceled the sign-in
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
    await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;

    if (user != null) {
      // Check if the user exists in Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        // Create a new document for the user if it doesn't exist
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'fullname': user.displayName ?? 'N/A',
          'mobilenumber': 'N/A',  // Or any other default value you want to set
          'dob': 'N/A',           // Or any other default value you want to set
        });
      }
      return user;
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
        message: 'Missing Google Auth Token',
      );
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
                  // color: Color(0xFF1C0642),
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
                          // color: Colors.white,
                            color: Theme.of(context).textTheme.bodyLarge!.color
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
                    // color: Color(0xFFffffff),
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
                                  TextStyle(fontFamily: 'Nunito', fontSize: 20,color: Theme.of(context).textTheme.bodyLarge!.color),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                // color: Color(0xFFd5d8ec).withOpacity(0.4),
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
                                  TextStyle(fontFamily: 'Nunito', fontSize: 20,color: Theme.of(context).textTheme.bodyLarge!.color),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                // color: Color(0xFFd5d8ec).withOpacity(0.4),
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
                            SizedBox(height: 30),
                            Center(
                              child: _isLoading
                                  ? SpinKitCircle(
                                      color: Color(0xFF6524CB),
                                      size: 50,
                                      duration: Duration(milliseconds: 500),
                                    )
                                  : ElevatedButton(
                                      onPressed: _login,
                                      style: ElevatedButton.styleFrom(
                                        // backgroundColor: Color(0xFF1C0642),
                                        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 50,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: Color(0xFF1C0642),
                                            style: BorderStyle.none,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(32.0),
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
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPassScreen(),
                                      ));
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(context).buttonTheme.colorScheme?.primary,
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CreateAccountScreen(),
                                      ));
                                },
                                style: ElevatedButton.styleFrom(
                                  // backgroundColor: Color(0xFF6524CB).withOpacity(0.4),
                                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 50,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Color(0xFF6524CB),
                                      style: BorderStyle.none,
                                    ),
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                ),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Nunito',
                                   color: Theme.of(context).buttonTheme.colorScheme?.primary
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Use',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Nunito-Medium',
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Service Temporally not available')),
                                      );
                                    },
                                    child: Text(
                                      'Fingerprint',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.deepPurple,
                                        fontFamily: 'Nunito-Medium',
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'To Access',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Nunito-Medium',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 2,
                                    width: 120,
                                    color: Color(0xFF6524CB),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    'or sign in with',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Nunito-Medium',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Container(
                                    height: 2,
                                    width: 120,
                                    color: Color(0xFF6524CB),
                                  ),
                                ],
                              ),
                            ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  try {
                                    final userCredential = await signInWithFacebook();
                                    User? user = (await signInWithFacebook()) as User?;
                                    // AuthServiceFacebook().signInWithFacebook();
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    if (userCredential != null && context.mounted) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              trackitnavbars(username: user!.displayName!),
                                        ),
                                      );
                                    }
                                    if (user != null) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              trackitnavbars(username: user.displayName!),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Failed to sign in with Facebook: ${e.toString()}'),
                                      ),
                                    );
                                  }
                                },
                                icon: Image.asset('assets/images/Iconfacebook.jpg'),
                              ),
                              SizedBox(width: 10),
                              IconButton(
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  try {
                                    final user = await _signInWithGoogle();
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    if (user != null && context.mounted) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              trackitnavbars(username: user.displayName!),
                                          // HomeScreen(username: user.displayName!,),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Failed to sign in with Google: ${e.toString()}'),
                                      ),
                                    );
                                  }
                                },
                                icon: Image.asset('assets/images/Icongoogle.jpg'),
                              ),
                            ],
                          ),
                        ),
                        Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Dont have an account',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Nunito-Medium',
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CreateAccountScreen(),
                                          ));
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.deepPurple,
                                        fontFamily: 'Nunito-Medium',
                                      ),
                                    ),
                                  ),
                                ],
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
