import 'package:flutter/material.dart';

import 'editprofilescreen.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Settings       ',
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
                    child: SizedBox(),
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
                            SizedBox(height: 10),
                            Expanded(
                              child: ListView(
                                children: [
                                  SizedBox(height: 60),
                                  SettingsOption(
                                    icon: Icons.notifications_outlined,
                                    title: 'Notification Settings',
                                    onTap: () {
                                      Navigator.pushNamed(context, '/notifications');
                                    }, onTaped: () {  Navigator.pushNamed(context, '/notifications'); },
                                  ),
                                  SizedBox(height: 30),
                                  SettingsOption(
                                    icon: Icons.key,
                                    title: 'Password Settings',
                                    onTap: () {
                                      Navigator.pushNamed(context, '/changepassword');
                                    }, onTaped: () {
                                    Navigator.pushNamed(context, '/changepassword');
                                  },
                                  ),
                                  SizedBox(height: 30),
                                  SettingsOption(
                                    icon: Icons.person,
                                    title: 'Delete Account',
                                    onTap: () {
                                      Navigator.pushNamed(context, '/deleteaccount');
                                    }, onTaped: () {
                                    Navigator.pushNamed(context, '/deleteaccount');
                                  },
                                  ),
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

class SettingsOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final VoidCallback onTaped;


  SettingsOption({required this.icon, required this.title, required this.onTap, required this.onTaped});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: Icon(icon, color: Colors.white, size: 20,),
      ),
      title: Text(title, style: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),),
      onTap: onTap,
      trailing: IconButton(onPressed: (){
        onTaped;
      }, icon: Icon(Icons.navigate_next_outlined,size: 30,)),
      onLongPress: onTaped,
    );
  }
}
