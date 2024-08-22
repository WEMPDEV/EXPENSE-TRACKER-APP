import 'package:flutter/material.dart';
import 'package:trackit/Sub-Directory/SecurityPin.dart';
import 'package:trackit/Sub-Directory/services/auth_servicegoogle.dart';
import 'CreateAccountScreen.dart';
import 'bottomnavbars.dart';
import 'homescreen.dart';
import 'package:trackit/Sub-Directory/WelcomePage.dart';
class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({
    super.key,
  });

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final _formKey = GlobalKey<FormState>();
  late final  TextEditingController _email  ;
  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
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
                        'Forgot Password',
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
                    // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(height: 60),
                            Text(
                              "Reset Password?",
                              style: TextStyle(fontFamily: 'Nunito', fontSize: 27,fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 7,),
                            Text(
                              "Don't worry. Enter your email and we'll send you a link to reset it.",
                              style: TextStyle(fontFamily: 'Nunito', fontSize: 20),
                            ),
                            SizedBox(height: 50),
                            Text(
                              "Enter email address",
                              style: TextStyle(fontFamily: 'Nunito', fontSize: 20,fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10,),
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
                                  borderRadius: BorderRadius.circular(32),
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
                            ),),),
                            SizedBox(height: 45),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder:
                                            (context) => SecurityPin(),));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 50,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Color(0xFF1C0642),
                                      style: BorderStyle.none,
                                    ),
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                ),
                                child: Text(
                                  'NextStep',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 75,),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder:
                                          (context) => CreateAccountScreen(),));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 50,
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
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 2,
                                    width:MediaQuery.of(context).size.width * 0.3,
                                    color: Color(0xFF6524CB),
                                  ),
                                  SizedBox(width: 12,),
                                  Text(
                                    'or sign up with',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Nunito-Medium',
                                    ),
                                  ),
                                  SizedBox(width: 12,),
                                  Container(
                                    height: 2,
                                    width: MediaQuery.of(context).size.width * 0.3,
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
                                    onPressed: () {
                                      print('Icon button pressed');
                                      Authservice().signInWithGoogle();
                                    },
                                    icon: Image.asset('assets/images/Iconfacebook.jpg'),
                                  ),
                                  SizedBox(width: 10),
                                  IconButton(
                                    onPressed: () {
                                      Authservice().signInWithGoogle();
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
                                      Navigator.push(context,
                                          MaterialPageRoute(builder:
                                              (context) => CreateAccountScreen(),));
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
