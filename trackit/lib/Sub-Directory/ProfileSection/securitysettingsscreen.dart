import 'package:flutter/material.dart';

import 'editprofilescreen.dart';

class securitysettings extends StatefulWidget {
  const securitysettings({super.key});

  @override
  State<securitysettings> createState() => _securitysettingsState();
}

class _securitysettingsState extends State<securitysettings> {
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
                'Security       ',
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
                        // color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(55.0),
                          topRight: Radius.circular(55.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Expanded(
                              child: ListView(
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    ' Security',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Theme.of(context).textTheme.bodyLarge!.color,
                                        fontFamily: 'Lilita_one'
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  SecurityOption(
                                    title: 'Change Pin',
                                    onTap: () {
                                      Navigator.pushNamed(context, '/changepin');
                                    },
                                    onTaped: () { Navigator.pushNamed(context, '/changepin'); },
                                  ),
                                  SizedBox(height: 30),
                                  SecurityOption(
                                    title: 'Finger Print',
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Service Temporally not available')),
                                      );
                                    },
                                    onTaped: () { ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Service Temporally not available')),
                                    );
                                      },
                                  ),
                                  SizedBox(height: 30),
                                  SecurityOption(
                                    title: 'Terms and Conditions',
                                    onTap: () {
                                      Navigator.pushNamed(context, '/terms');
                                    },
                                    onTaped: () {
                                      Navigator.pushNamed(context, '/terms');
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


class SecurityOption extends StatelessWidget {
  final String title;
  final VoidCallback onTaped;
  final VoidCallback onTap;


  SecurityOption({required this.title, required this.onTaped, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),),
      onTap: onTap,  // Correctly invoking the onTap callback here
      trailing: IconButton( onPressed: () { onTap; }, icon: Icon(Icons.navigate_next,)),
      onLongPress: onTaped,
    );
  }
}
