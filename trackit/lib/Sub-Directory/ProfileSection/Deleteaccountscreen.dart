import 'package:flutter/material.dart';
import 'package:trackit/Sub-Directory/ChangePasswrdsplashScreen.dart';

class deleteaccount extends StatefulWidget {
  const deleteaccount({
    super.key,
  });

  @override
  State<deleteaccount> createState() => _deleteaccountState();
}

class _deleteaccountState extends State<deleteaccount> {
  final _formKey = GlobalKey<FormState>();
  late final  TextEditingController _password;
  bool _obscureText = true;


  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _password.dispose();
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
            padding: const EdgeInsets.only(right: 75),
            child: Center(
              child: Text(
                'Delete Account',
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
                            Center(
                              child: Text('Are You Sure You Want To Delete \n '
                                  '             Your Account?',style: TextStyle(
                                  fontFamily: 'Nunito',fontSize: 18,fontWeight: FontWeight.bold
                              ),),
                            ),
                            SizedBox(height: 15,),
                            Container(
                              decoration: BoxDecoration(
                                color:  Theme.of(context).colorScheme.inversePrimary.withOpacity(0.45),
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
                                child: Column(
                                  children: [
                                    SizedBox(height: 30,),
                                    Text('This action will permanently delete'
                                        ' all of your data, and you will not be able to recover'
                                        ' it. Please keep the following in mind before proceeding:'),
                                    SizedBox(height: 30,),
                                    Row(
                                      children: [
                                        _buildtext('.'),
                                        SizedBox(width: 10,),
                                        Text('All your expenses, income and associated '
                                            '\ntransactions will be eliminated.'),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        _buildtext('.'),
                                        SizedBox(width: 10,),
                                        Text('You will not be able to access your account or '
                                            '\nany related information.'
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        _buildtext('.'),
                                        SizedBox(width: 10,),
                                        Text('This action cannot be undone.'
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30,),
                                  ],
                                )
                              ),
                            ),
                            SizedBox(height: 20,),
                            Center(
                              child: Text('Please Enter Your Password To '
                                  ' Confirm \n            Deletion Of Your Account.',style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 15
                              ),),
                            ),
                            SizedBox(height: 20,),
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
                            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Processing')),
                                    );
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Center(child: const Text('Delete account',style: TextStyle(
                                            fontFamily: 'Lilita_one',
                                          ),)),
                                          // backgroundColor:  Theme.of(context).colorScheme.inversePrimary,
                                          content: const Text('Are you sure you want to log out?',style: TextStyle(
                                            fontFamily: 'Nunito',fontSize: 18
                                          ),),
                                          actions: <Widget>[
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children:[
                                                Center(
                                                  child: Text('By deleting your account, you agree that you understand'
                                                      ' the consequences of this action and that you agree to'
                                                      ' permanently delete your account and all associated data. ',style: TextStyle(
                                                      fontFamily: 'Nunito',fontSize: 15
                                                  ),),
                                                ),
                                                SizedBox(height: 5,),
                                                Center(
                                                  child: TextButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(32),
                                                      ),
                                                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text('Yes,Delete Account',style: TextStyle(
                                                      fontFamily: 'Nunito', fontWeight: FontWeight.bold
                                                    ),),
                                                  ),
                                                ),
                                                TextButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.45),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(32),
                                                    ),
                                                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Cancel',style: TextStyle(
                                                    fontFamily: 'Nunito',fontWeight: FontWeight.bold
                                                  ),),
                                                ),
                                              ],
                                            ),

                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                child: const Text(
                                  'Yes, Delete Account',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Nunito',
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

Widget _buildtext(String label, ) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
        ),
      ),
    ],
  );
}