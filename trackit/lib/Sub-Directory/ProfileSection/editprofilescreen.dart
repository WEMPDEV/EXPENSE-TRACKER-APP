import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ThemeNotifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _editState();
}

class _editState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullname;
  late final TextEditingController _email;
  late final TextEditingController _mobilenumber;
  File? _image;
  String _profileImageUrl = '';


  @override
  void initState() {
    _email = TextEditingController();
    _fullname = TextEditingController();
    _mobilenumber = TextEditingController();
    fetchUserData();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _fullname.dispose();
    _mobilenumber.dispose();
    super.dispose();
  }

  String username = "";
  String userId = "";

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
          });
        } else {
          setState(() {
            username = 'N/A';
            userId = 'N/A';
          });
        }
      } else {
        setState(() {
          username = 'N/A';
          userId = 'N/A';
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _uploadImage();
    }
  }

  Future<String?> _uploadImage() async {
    if (_image == null) return null;

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      String uid = user.uid;
      Reference storageRef =
      FirebaseStorage.instance.ref().child('profile_images').child(uid);
      UploadTask uploadTask = storageRef.putFile(_image!);

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        _profileImageUrl = downloadUrl;
      });

      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  // Future<void> _uploadImage() async {
  //   if (_image == null) return;
  //
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     if (user == null) return;
  //
  //     String uid = user.uid;
  //     Reference storageRef =
  //     FirebaseStorage.instance.ref().child('profile_images').child(uid);
  //     UploadTask uploadTask = storageRef.putFile(_image!);
  //
  //     TaskSnapshot taskSnapshot = await uploadTask;
  //     String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  //
  //     await FirebaseFirestore.instance.collection('users').doc(uid).update({
  //       'profileImageUrl': downloadUrl,
  //     });
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Profile image updated successfully.')),
  //     );
  //   } catch (e) {
  //     print('Error uploading image: $e');
  //   }
  // }

  Future<void> _updateProfile() async {
    try {
      if (_formKey.currentState?.validate() ?? false) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          String uid = user.uid;

          // Upload the image if selected
          String? imageUrl = await _uploadImage();

          // Update Firestore with the new profile information
          await FirebaseFirestore.instance.collection('users').doc(uid).update({
            'fullname': _fullname.text,
            'email': _email.text,
            'mobileNumber': _mobilenumber.text,
            if (imageUrl != null) 'profileImageUrl': imageUrl,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully.')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user is currently signed in.')),
          );
        }
      }
    } catch (e) {
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile. Please try again.')),
      );
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
              Navigator.pop(context);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 80),
              child: Center(
                child: Text(
                  'Edit My Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 160),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: _image == null
                                  ? NetworkImage(
                                _profileImageUrl.isEmpty
                                    ? 'https://img.freepik.com/premium-vector/avatar-icon002_750950-52.jpg?w=740'
                                    : _profileImageUrl,
                              )
                                  : FileImage(_image!) as ImageProvider,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => _showImagePicker(context),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                              Expanded(
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
                                          Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  username.isNotEmpty ? username : 'Loading....',
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
                                          SizedBox(height: 20),
                                          Text(
                                            ' Account Settings',
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Theme.of(context).textTheme.bodyLarge!.color,
                                                fontFamily: 'Lilita_one'
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            "User name",
                                            style: TextStyle(
                                              fontFamily: 'Nunito',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context).textTheme.bodyLarge!.color,
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
                                                controller: _fullname,
                                                keyboardType: TextInputType.name,
                                                decoration: InputDecoration(
                                                  hintText: ' John Smith',
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
                                          SizedBox(height: 20),
                                          Text(
                                            "Mobile Number",
                                            style: TextStyle(
                                              fontFamily: 'Nunito',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context).textTheme.bodyLarge!.color,
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
                                                controller: _mobilenumber,
                                                keyboardType: TextInputType.phone,
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
                                          SizedBox(height: 20),
                                          Text(
                                            "Email Address",
                                            style: TextStyle(
                                              fontFamily: 'Nunito',
                                              fontSize: 20,
                                              color: Theme.of(context).textTheme.bodyLarge!.color,
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
                                          SizedBox(height: 20,),
                                          _buildSwitchPushNotification('Push Notifications', true),
                                          SizedBox(height: 10),
                                          _buildSwitchThemeNotifier('Turn Dark Theme', context.watch<ThemeNotifier>().isDarkMode),
                                          SizedBox(height: 30),
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
                                                  _updateProfile;
                                                  // Process data
                                                }
                                              },
                                              child: Text('Update Profile',
                                                style: TextStyle(color: Theme.of(context).buttonTheme.colorScheme?.primary),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                        ],
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
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget _buildSwitchPushNotification(String label, bool value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        Switch(
          value: value,
          onChanged: (newValue) {},
          activeColor: Theme.of(context).colorScheme.secondary,
        ),
      ],
    );
  }

  Widget _buildSwitchThemeNotifier(String label, bool value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        Switch(
          value: value,
          onChanged: (newValue){
            context.read<ThemeNotifier>().toggleTheme(newValue);
          },
          activeColor: Theme.of(context).colorScheme.secondary,
        ),
      ],
    );
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
//
// class edit extends StatefulWidget {
//   @override
//   State<edit> createState() => _editState();
// }
//
// class _EditProfileScreenState extends State<edit> {
//   final _formKey = GlobalKey<FormState>();
//   late final TextEditingController _fullname;
//   late final TextEditingController _email;
//   late final TextEditingController _mobilenumber;
//   File? _image;
//   String _profileImageUrl = '';
//
//   @override
//   void initState() {
//     _email = TextEditingController();
//     _fullname = TextEditingController();
//     _mobilenumber = TextEditingController();
//     fetchUserData();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _email.dispose();
//     _fullname.dispose();
//     _mobilenumber.dispose();
//     super.dispose();
//   }
//
//   String username = "";
//   String userId = "";
//
//   Future<void> fetchUserData() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         String uid = user.uid;
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(uid)
//             .get();
//         if (userDoc.exists) {
//           setState(() {
//             username = userDoc['fullname'] ?? 'N/A';
//             userId = uid;
//             _fullname.text = userDoc['fullname'] ?? '';
//             _email.text = userDoc['email'] ?? '';
//             _mobilenumber.text = userDoc['mobileNumber'] ?? '';
//             _profileImageUrl = userDoc['profileImageUrl'] ?? '';
//           });
//         } else {
//           setState(() {
//             username = 'N/A';
//             userId = 'N/A';
//           });
//         }
//       } else {
//         setState(() {
//           username = 'N/A';
//           userId = 'N/A';
//         });
//       }
//     } catch (e) {
//       print('Error fetching user data: $e');
//     }
//   }
//
//   Future<void> _pickImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }
//
//   Future<String?> _uploadImage() async {
//     if (_image == null) return null;
//
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user == null) return null;
//
//       String uid = user.uid;
//       Reference storageRef =
//       FirebaseStorage.instance.ref().child('profile_images').child(uid);
//       UploadTask uploadTask = storageRef.putFile(_image!);
//
//       TaskSnapshot taskSnapshot = await uploadTask;
//       String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//
//       setState(() {
//         _profileImageUrl = downloadUrl;
//       });
//
//       return downloadUrl;
//     } catch (e) {
//       print('Error uploading image: $e');
//       return null;
//     }
//   }
//
//   Future<void> _updateProfile() async {
//     try {
//       if (_formKey.currentState?.validate() ?? false) {
//         User? user = FirebaseAuth.instance.currentUser;
//         if (user != null) {
//           String uid = user.uid;
//
//           // Upload the image if selected
//           String? imageUrl = await _uploadImage();
//
//           // Update Firestore with the new profile information
//           await FirebaseFirestore.instance.collection('users').doc(uid).update({
//             'fullname': _fullname.text,
//             'email': _email.text,
//             'mobileNumber': _mobilenumber.text,
//             if (imageUrl != null) 'profileImageUrl': imageUrl,
//           });
//
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Profile updated successfully.')),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('No user is currently signed in.')),
//           );
//         }
//       }
//     } catch (e) {
//       print('Error updating profile: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update profile. Please try again.')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 80),
//             child: Center(
//               child: Text(
//                 'Edit My Profile',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontFamily: 'Lilita_one',
//                   fontSize: 20,
//                   fontWeight: FontWeight.w300,
//                   color: Theme.of(context).appBarTheme.foregroundColor,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: CircleAvatar(
//               child: IconButton(
//                 icon: Icon(Icons.notifications_outlined),
//                 onPressed: () {},
//               ),
//             ),
//           )
//         ],
//       ),
//       body: Container(
//         color: Theme.of(context).colorScheme.inversePrimary,
//         child: SafeArea(
//           child: Stack(
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 0, horizontal: 160),
//                       child: Stack(
//                         children: [
//                           CircleAvatar(
//                             radius: 50,
//                             backgroundImage: _image == null
//                                 ? NetworkImage(
//                               _profileImageUrl.isEmpty
//                                   ? 'https://img.freepik.com/premium-vector/avatar-icon002_750950-52.jpg?w=740'
//                                   : _profileImageUrl,
//                             )
//                                 : FileImage(_image!) as ImageProvider,
//                           ),
//                           Positioned(
//                             bottom: 0,
//                             right: 0,
//                             child: GestureDetector(
//                               onTap: () => _pickImage(ImageSource.gallery),
//                               child: CircleAvatar(
//                                 radius: 20,
//                                 backgroundColor: Colors.white,
//                                 child: Icon(
//                                   Icons.edit,
//                                   size: 20,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 4,
//                     child: Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.only(top: 35),
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).scaffoldBackgroundColor,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(50),
//                           topRight: Radius.circular(50),
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Form(
//                           key: _formKey,
//                           child: ListView(
//                             children: [
//                               buildTextField('Full Name', 'Enter your full name',
//                                   _fullname, TextInputType.name),
//                               SizedBox(height: 10),
//                               buildTextField('Email', 'Enter your email',
//                                   _email, TextInputType.emailAddress),
//                               SizedBox(height: 10),
//                               buildTextField(
//                                   'Mobile Number',
//                                   'Enter your mobile number',
//                                   _mobilenumber,
//                                   TextInputType.phone),
//                               SizedBox(height: 30),
//                               Center(
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Theme.of(context)
//                                         .colorScheme
//                                         .inversePrimary,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(32),
//                                     ),
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 50, vertical: 15),
//                                   ),
//                                   onPressed: _updateProfile,
//                                   child: Text(
//                                     'Update Profile',
//                                     style: TextStyle(
//                                         color: Theme.of(context)
//                                             .buttonTheme
//                                             .colorScheme
//                                             ?.primary),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   TextFormField buildTextField(String label, String placeholder,
//       TextEditingController controller, TextInputType inputType) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: inputType,
//       decoration: InputDecoration(
//         labelText: label,
//         hintText: placeholder,
//         hintStyle: TextStyle(color: Theme.of(context).hintColor),
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//       ),
//     );
//   }
// }
