import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Settingsscreen.dart';
import 'editprofilescreen.dart';
import 'securitysettingsscreen.dart';
import 'helpscreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "";
  String userId = "";
  String profileImageUrl = "";

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();
        if (userDoc.exists) {
          setState(() {
            username = userDoc['fullname'] ?? 'N/A';
            userId = uid;
            profileImageUrl = userDoc['profileImageUrl'] ?? '';
          });
        } else {
          // Handle case where document does not exist
          setState(() {
            username = 'N/A';
            userId = 'N/A';
            profileImageUrl = '';
          });
        }
      } else {
        // Handle case where no user is signed in
        setState(() {
          username = 'N/A';
          userId = 'N/A';
          profileImageUrl = '';
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        actions: [
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
      body: Container(
        color: Theme.of(context).colorScheme.inversePrimary,
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 70),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: profileImageUrl.isNotEmpty
                            ? NetworkImage(profileImageUrl)
                            : NetworkImage(
                          'https://img.freepik.com/premium-vector/avatar-icon002_750950-52.jpg?w=740',
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
                          topLeft: Radius.circular(55.0),
                          topRight: Radius.circular(55.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Expanded(
                              child: ListView(
                                children: [
                                  Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          username.isNotEmpty ? username : 'Loading...',
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Theme.of(context).textTheme.bodyLarge!.color,
                                              fontFamily: 'Lilita_one'
                                          ),
                                        ),
                                        Text(
                                          'ID: ${userId.isNotEmpty ? userId : 'N/A'}',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Theme.of(context).textTheme.bodyMedium!.color,
                                              fontFamily: 'Nunito'
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  ProfileOption(
                                    icon: Icons.person_outlined,
                                    title: 'Edit Profile',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>EditProfileScreen(),
                                        ),
                                      ).then((_) => fetchUserData()); // Refresh profile data
                                    },
                                  ),
                                  SizedBox(height: 30),
                                  ProfileOption(
                                    icon: Icons.security_outlined,
                                    title: 'Security',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => securitysettings(),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 30),
                                  ProfileOption(
                                    icon: Icons.settings_outlined,
                                    title: 'Setting',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => settings(),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 30),
                                  ProfileOption(
                                    icon: Icons.help_outline,
                                    title: 'Help',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => helpscreen(index: int.fromEnvironment(''), name:String.fromEnvironment(''),),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 30),
                                  ProfileOption(
                                    icon: Icons.logout_outlined,
                                    title: 'Logout',
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Center(child: const Text('End Session',style: TextStyle(
                                              fontFamily: 'Lilita_one',
                                            ),)),
                                            content: const Text('Are you sure you want to end '
                                                '\n                   session?',style: TextStyle(
                                                fontFamily: 'Nunito',fontSize: 18
                                            ),),
                                            actions: <Widget>[
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children:[
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
                                                      onPressed: () async {
                                                        try {
                                                          await FirebaseAuth.instance.signOut();
                                                          Navigator.of(context).pushReplacementNamed('/Login'); // Navigate to the login screen or any other screen after logout
                                                        } catch (e) {
                                                          print('Error signing out: $e');
                                                        }
                                                      },
                                                      child: const Text('Yes,End Session',style: TextStyle(
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
                                    },
                                  ),
                                  SizedBox(height: 30),
                                ],
                                controller: ScrollController(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  ProfileOption({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: Icon(icon, color: Colors.white, size: 27,),
      ),
      title: Text(title, style: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),),
      onTap: onTap,
    );
  }
}
