import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackit/Sub-Directory/NewPassrd.dart';
import 'package:trackit/Sub-Directory/services/auth_servicegoogle.dart';
import 'CreateAccountScreen.dart';
import 'homescreen.dart';
void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SecurityPin(),
    );
  }
}

class SecurityPin extends StatefulWidget {
  const SecurityPin({
    super.key,
  });

  @override
  State<SecurityPin> createState() => _SecurityPinState();
}

class _SecurityPinState extends State<SecurityPin> {
  final _formKey = GlobalKey<FormState>();
  late final  TextEditingController _email;
  final _otpControllers = List<TextEditingController>.generate(4, (_) => TextEditingController()); // List of controllers for OTP fields (replace 4 with desired number of fields)

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
                        'Security Pin',
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
                            Center(
                              child: Text(
                                "Enter Security Pin",
                                style: TextStyle(fontFamily: 'Nunito', fontSize: 27,fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 60,),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  4, (index) => SizedBox(
                                  width: 60,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8,left: 8),
                                    child:Container(
                                      decoration: BoxDecoration(
                                        // color: Color(0xFFd5d8ec).withOpacity(0.4),
                                        color: Theme.of(context).cardColor.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(32),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFFcfd1dd).withOpacity(0.8),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: TextFormField(
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                        controller: _otpControllers[index],
                                        keyboardType: TextInputType.number,
                                        inputFormatters: List.empty(growable: true),
                                        maxLength: 1,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Color(0xFFcfd1dd).withOpacity(0.5),
                                          counterText: '', // Hide counter text
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(32),
                                            borderSide: BorderSide.none
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter digit $index';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                ),
                              ),
                            ),
                            SizedBox(height: 150),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Processing Data')),
                                    );
                                    Navigator.push(context,
                                        MaterialPageRoute(builder:
                                            (context) => NewPasswordPage(),));
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
                                  'Accept',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {},
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
                                  'Send Again',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Nunito',

                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.055,),
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
