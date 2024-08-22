import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trackit/Sub-Directory/LoginPage.dart';
import 'WelcomePage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'homescreen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullname;
  late final TextEditingController _email;
  late final TextEditingController _mobilenumber;
  late final TextEditingController _dob;
  late final TextEditingController _password;
  bool _obscureText = true;
  String _PrivateText = 'Terms Of Use and Privacy Policy';
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
    _fullname = TextEditingController();
    _mobilenumber = TextEditingController();
    _dob = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _fullname.dispose();
    _mobilenumber.dispose();
    _dob.dispose();
    super.dispose();
  }

  Future<void> _createaccount() async {
    setState(() {
      _isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _email.text,
          password: _password.text,
        );

        // Send email verification
        await userCredential.user!.sendEmailVerification();

        // Print to verify user creation
        print('User created: ${userCredential.user!.uid}');

        // Store additional user information in Firestore
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'fullname': _fullname.text,
          'mobilenumber': _mobilenumber.text,
          'dob': _dob.text,
        });

        // Print to verify Firestore write
        print('User information saved to Firestore');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verification email sent. Please check your inbox.')),
        );

        await _auth.signOut();
        setState(() {
          _isLoading = false;
        });

        await Future.delayed(Duration(seconds: 2), () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Check Your Email To Verify Account')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
          );
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create account: ${e.toString()}')),
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).viewPadding;
    return Scaffold(
      // backgroundColor: Color(0xFF1C0642),
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
                        'Create Account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Lilita_One',
                          fontSize: 33,
                          fontWeight: FontWeight.w100,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          // color: Colors.white,
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
                            SizedBox(height: 30),
                            Text(
                              "Fullname",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 20,
                                 color: Theme.of(context).textTheme.bodyLarge!.color
                              ),
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
                                  controller: _fullname,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    hintText: 'name',
                                    border: UnderlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(32),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Email",
                              style: TextStyle(
                                  fontFamily: 'Nunito', fontSize: 20,
                                  color: Theme.of(context).textTheme.bodyLarge!.color),
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
                                    border: UnderlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(32),
                                      borderSide: BorderSide.none,
                                    ),
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
                            SizedBox(height: 10),
                            Text(
                              "Mobile Number",
                              style: TextStyle(
                                  fontFamily: 'Nunito', fontSize: 20,
                                  color: Theme.of(context).textTheme.bodyLarge!.color),
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
                                  controller: _mobilenumber,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '+123 456 7890',
                                    border: UnderlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(32),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your mobile number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Date Of Birth",
                              style: TextStyle(
                                  fontFamily: 'Nunito', fontSize: 20,
                                  color: Theme.of(context).textTheme.bodyLarge!.color),
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
                                  controller: _dob,
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    hintText: 'DD/MM/YY',
                                    border: UnderlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(32),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your date of birth';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Password",
                              style: TextStyle(
                                  fontFamily: 'Nunito', fontSize: 20,
                                  color: Theme.of(context).textTheme.bodyLarge!.color),
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
                                      onPressed:
                                      _togglePasswordVisibility,
                                    ),
                                    border: UnderlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(32),
                                      borderSide: BorderSide.none,
                                    ),
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
                            SizedBox(height: 10),
                            Center(
                              child: Column(
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      '     By continuing you agree to\n $_PrivateText',
                                      style: TextStyle(
                                        fontSize: 14,
                                        // color: Colors.deepPurple,
                                        // color: Theme.of(context).textTheme.bodyLarge!.color,
                                        fontFamily: 'Nunito-Medium',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child:
                              // _isLoading? SpinKitCircle(
                              //   color: Color(0xFF6524CB),size: 50,duration: Duration(milliseconds: 500),
                              // ) :
                              ElevatedButton(
                                onPressed: () {
                                  _createaccount();
                                  Future.delayed(Duration(seconds: 3), () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Login(),
                                      ),
                                    );
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 50,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      style: BorderStyle.none,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(32.0),
                                  ),
                                ),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).buttonTheme.colorScheme?.primary,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Nunito-Medium',
                                        // color: Theme.of(context).textTheme.bodyLarge!.color
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              WelcomeScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Login',
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

