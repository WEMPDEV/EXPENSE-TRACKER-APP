






import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Settingsscreen.dart';
import 'editprofilescreen.dart';
import 'securitysettingsscreen.dart';

class helpscreen extends StatefulWidget {
  const helpscreen({super.key,
    required this.index,
    required this.name,});

  final int index;
  final String name;

  @override
  State<helpscreen> createState() => _helpscreenState();
}

class _helpscreenState extends State<helpscreen> {

  int isSelected = 0;

  void changeScreen(int index) {
    setState(() {
      isSelected = index;
    });
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
            padding: const EdgeInsets.only(right: 75),
            child: Center(
              child: Text(
                "Help & FAQ'S ",
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
                    child: SizedBox()
                  ),
                  Expanded(
                    flex: 20,
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
                            SizedBox(height: 30),
                            Center(
                              child: Text(
                                'How Can We Help You?',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w800
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              decoration: BoxDecoration(
                                color:  Theme.of(context).colorScheme.inversePrimary.withOpacity(0.45),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    buildhelpclass(
                                      index: 0,
                                      name: 'FAQ',
                                      isSelected: isSelected == 0,
                                      onTap: () => changeScreen(0),
                                    ),
                                    buildhelpclass(
                                      index: 1,
                                      name: 'Contact Us',
                                      isSelected: isSelected == 1,
                                      onTap: () => changeScreen(1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Container(
                              decoration: BoxDecoration(
                                color:  Theme.of(context).colorScheme.inversePrimary.withOpacity(0.45),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Theme.of(context).colorScheme.inversePrimary,width: 3),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  controller: SearchController(),
                                  decoration: InputDecoration(
                                    hintText: 'Search',
                                    hintStyle: TextStyle(
                                      fontSize: 20
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.search_rounded,
                                      ),
                                      onPressed: (){},
                                    ),
                                    border: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(32),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter search';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: isSelected == 0 ? buildFAQ() : buildContactUs(),
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


class ContactusOption extends StatelessWidget {
  final IconData icon;
  final IconData iCon;
  final String title;
  final VoidCallback onTap;

  ContactusOption({required this.icon, required this.title, required this.onTap, required this.iCon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: Icon(iCon, color: Colors.white, size: 27,),
      ),
      title: Text(title, style: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),),
      onTap: onTap,
      trailing: Icon(icon),
    );
  }
}



class HelpOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  HelpOption({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),),
      onTap: onTap,
      trailing: Icon(icon),
    );
  }
}

Widget buildContactUs(){
  return Padding(
      padding: EdgeInsets.only(top: 5),
    child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10,),
          ContactusOption(
            icon: Icons.navigate_next_outlined,
            title: 'Customer Service',
            onTap: () {},
            iCon: Icons.call,
          ),
          SizedBox(height: 10,),
          ContactusOption(
            icon: Icons.navigate_next_outlined,
            title: 'Website',
            onTap: () {},
            iCon: Icons.webhook_sharp,
          ),
          SizedBox(height: 10,),
          ContactusOption(
            icon: Icons.navigate_next_outlined,
            title: 'Facebook',
            onTap: () {},
            iCon: Icons.facebook_outlined,
          ),
          SizedBox(height: 10,),
          ContactusOption(
            icon: Icons.navigate_next_outlined,
            title: 'Whatssapp',
            onTap: () {},
            iCon: Icons.whatshot_outlined,
          ),
          SizedBox(height: 10,),
          ContactusOption(
            icon: Icons.navigate_next_outlined,
            title: 'Instagram',
            onTap: () {},
            iCon: Icons.linked_camera_outlined,
          ),
        ],
      ),
    ),
  );
}


Widget buildFAQ(){
  return Padding(
    padding: const EdgeInsets.only(top: 5),
    child: SingleChildScrollView(
      child: Column(
        children: [
          HelpOption(
            icon: Icons.arrow_drop_down,
            title: 'How to use Trackit?',
            onTap: () {},
          ),
          HelpOption(
            icon: Icons.arrow_drop_down,
            title: 'How much does it cost to use Trackit?',
            onTap: () {},
          ),
          HelpOption(
            icon: Icons.arrow_drop_down,
            title: 'How to contact support?',
            onTap: () {},
          ),
          HelpOption(
            icon: Icons.arrow_drop_down,
            title: 'How can I reset my password if I forget it?',
            onTap: () {},
          ),
          HelpOption(
            icon: Icons.arrow_drop_down,
            title: 'Are there any privacy or data security measures in place?',
            onTap: () {},
          ),
          HelpOption(
            icon: Icons.arrow_drop_down,
            title: 'Can I customize settings within the application?',
            onTap: () {},
          ),
          HelpOption(
            icon: Icons.arrow_drop_down,
            title: 'How can I delete my account?',
            onTap: () {},
          ),
          HelpOption(
            icon: Icons.arrow_drop_down,
            title: 'How do I access my expense history?',
            onTap: () {},
          ),
          HelpOption(
            icon: Icons.arrow_drop_down,
            title: 'How to use  Trackit?',
            onTap: () {},
          ),
          HelpOption(
            icon: Icons.arrow_drop_down,
            title: 'Can I use the app offline?',
            onTap: () {},
          ),
        ],
      ),
    ),
  );
}




class buildhelpclass extends StatelessWidget {
  const buildhelpclass({
    super.key,
    required this.index,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  final int index;
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 190,
        height: 50,
        padding:  EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.inversePrimary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Text(
          name,
          style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'Lilita_one'),
        ),
      ),
    );
  }
}
