import 'package:flutter/material.dart';
import 'package:trackit/Sub-Directory/ChangePasswrdsplashScreen.dart';
import 'package:trackit/Sub-Directory/SecurityPin.dart';

class changepinscreen extends StatefulWidget {
  const changepinscreen({
    super.key,
  });

  @override
  State<changepinscreen> createState() => _changepinscreenState();
}

class _changepinscreenState extends State<changepinscreen> {
  final _formKey = GlobalKey<FormState>();
  late final  TextEditingController _email;
  late final  TextEditingController _password;
  late final TextEditingController _confirmpassword;
  bool _obscureText = true;


  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmpassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).viewPadding;
    return Scaffold(
      // backgroundColor: Color(0xFF1C0642),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        // backgroundColor: Colors.deepPurple,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 97),
            child: Center(
              child: Text(
                'Change Pin       ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  // fontFamily: 'Nunito',
                  fontFamily: 'Lilita_one',
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).appBarTheme.foregroundColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: IconButton(
                icon: Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 0,
                child: Container(
                  // color: Color(0xFF1C0642),
                  color: Theme.of(context).colorScheme.inversePrimary,
                  child: SizedBox(),
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
                              "Current Pin",
                              style: TextStyle(fontFamily: 'Nunito', fontSize: 20,
                                // color: Theme.of(context).textTheme.bodyLarge!.color
                              ),
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
                                    hintText: 'Enter Pin',
                                    fillColor: Color(0xFF6524CB).withOpacity(0.4),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureText ? Icons.visibility : Icons.visibility_off,
                                      ),
                                      onPressed: _togglePasswordVisibility,
                                    ),
                                    border: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(32),
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
                            SizedBox(height: 60),
                            Text(
                              "New Pin",
                              style: TextStyle(fontFamily: 'Nunito', fontSize: 20,
                                  // color: Theme.of(context).textTheme.bodyLarge!.color
                              ),
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
                                  controller: _confirmpassword,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    hintText: 'Enter New Pin',
                                    fillColor: Color(0xFF6524CB).withOpacity(0.4),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureText ? Icons.visibility : Icons.visibility_off,
                                      ),
                                      onPressed: _togglePasswordVisibility,
                                    ),
                                    border: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(32),
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
                            SizedBox(height: 60),
                            Text(
                              "Confirm Pin",
                              style: TextStyle(fontFamily: 'Nunito', fontSize: 20),
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
                                child:TextFormField(
                                  controller: _confirmpassword,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    hintText: 'Enter New Pin',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureText ? Icons.visibility : Icons.visibility_off,
                                      ),
                                      onPressed: _togglePasswordVisibility,
                                    ),
                                    border: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(32),
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
                            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Updating Details!')),
                                    );
                                    Navigator.push(context,
                                        MaterialPageRoute(builder:
                                            (context) => SplashScreen(),));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 110,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Color(0xFF1C0642),
                                      style: BorderStyle.none,
                                    ),
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'ChangePassword',
                                    style: TextStyle(
                                      fontSize: 18,
                                      // color: Colors.white,
                                      color: Theme.of(context).buttonTheme.colorScheme?.primary,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
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
