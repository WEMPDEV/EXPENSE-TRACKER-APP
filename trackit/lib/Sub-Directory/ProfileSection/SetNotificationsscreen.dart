import 'package:flutter/material.dart';

import '../ThemeNotifier.dart';
import 'editprofilescreen.dart';

class Notificationsettings extends StatefulWidget {
  const Notificationsettings({super.key});

  @override
  State<Notificationsettings> createState() => _NotificationsettingsState();
}

class _NotificationsettingsState extends State<Notificationsettings> {
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
            padding: const EdgeInsets.only(right: 50),
            child: Center(
              child: Text(
                ' Notification Settings',
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        _buildSwitchPushNotification(
                                            'General Notifications', true),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        _buildSwitchPushNotification(
                                            'Sound', true),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        _buildSwitchPushNotification(
                                            'Sound Call', true),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        _buildSwitchPushNotification(
                                            'Vibrate', true),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        _buildSwitchPushNotification(
                                            'Transaction Update', false),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        _buildSwitchPushNotification(
                                            'Expense Reminder', false),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        _buildSwitchPushNotification(
                                            'Budget Notifications', false),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        _buildSwitchPushNotification(
                                            'Low Balance Alerts', false)
                                      ],
                                    ),
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

Widget _buildSwitchPushNotification(String label, bool value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
          // color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
      ),
      Switch(
        value: value,
        onChanged: (newValue) {},
        splashRadius: double.infinity,
        // activeColor: Theme.of(context).colorScheme.secondary,
      ),
    ],
  );
}
