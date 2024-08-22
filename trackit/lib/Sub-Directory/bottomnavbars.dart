import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:trackit/Sub-Directory/CategorySection/categories.dart';
import 'package:trackit/Sub-Directory/Transactions/transactions_homeview.dart';
import 'dart:ui';
import 'package:trackit/Sub-Directory/homescreen.dart';
import 'ProfileSection/ProfileScreens.dart';

class trackitnavbars extends StatefulWidget {
  final String username;
  const trackitnavbars({super.key, required this.username});

  @override
  State<trackitnavbars> createState() => _trackitnavbarsState();
}

class _trackitnavbarsState extends State<trackitnavbars> {
  int _selectedIndex = 0;

  void _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = [
      HomeScreen(username: widget.username),
      Text('Search Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black)),
      transactions_homeview(index: int.fromEnvironment(''), name:String.fromEnvironment(''),),
      CategoriesPage(),
      ProfileScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        height: 63,
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Align(
          heightFactor: 1,
          alignment: Alignment.bottomCenter,
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home, color: Colors.blue),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_outlined),
                activeIcon: Icon(Icons.bar_chart, color:  Colors.blue),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.swap_horiz_outlined),
                activeIcon: Icon(Icons.swap_horiz, color: Colors.blue),
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.layers_outlined),
                activeIcon: Icon(Icons.layers, color:  Colors.blue),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person, color: Colors.blue),
                label: 'Profile',
              ),
            ],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: _selectedIndex,
            iconSize: 25,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            type: BottomNavigationBarType.fixed,
            elevation: double.infinity,
            onTap: _onSelected,
          ),
        ),
      ),
    );
  }
}










// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:trackit/Sub-Directory/homescreen.dart';
// import 'BottomNavScreens/ProfileScreens.dart';
// class trackitnavbars extends StatefulWidget {
//   const trackitnavbars({super.key});
//
//   @override
//   State<trackitnavbars> createState() => _trackitnavbarsState();
// }
//
// class _trackitnavbarsState extends State<trackitnavbars> {
//   int _selectedindex = 0;
//
//   void _onselected(int index){
//     setState(() {
//       _selectedindex = index;
//     });
//   }
//   static List<Widget> _widgetoptions = [
//     HomeScreen(username: String.fromEnvironment('')),
//     Text('Search Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color: Colors.black)),
//     Text('Add Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color: Colors.black)),
//     Text('Notifications Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color: Colors.black)),
//     ProfileScreen()
//     // Text('Profile Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color: Colors.black)),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: _widgetoptions.elementAt(_selectedindex),
//       bottomNavigationBar: Container(
//         height: 63,
//         padding: EdgeInsets.only(left: 20, right: 20),
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.inversePrimary,
//           // color: Colors.deepPurple,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(40),
//             topRight: Radius.circular(40),
//           ),
//         ),
//         child: Align(
//           heightFactor: 1,
//           alignment: Alignment.bottomCenter,
//           child: BottomNavigationBar(
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home_outlined,),
//                 activeIcon: Icon(Icons.home,color: Colors.blueAccent),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.bar_chart_outlined),
//                 activeIcon: Icon(Icons.bar_chart,color:Colors.blueAccent),
//                 label: 'Search',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.swap_horiz_outlined),
//                 activeIcon: Icon(Icons.swap_horiz,color: Colors.blueAccent),
//                 label: 'Add',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.layers_outlined),
//                 activeIcon: Icon(Icons.layers,color:Colors.blueAccent),
//                 label: 'Notifications',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person_outline),
//                 activeIcon: Icon(Icons.person,color: Colors.blueAccent),
//                 label: 'Profile',
//               ),
//             ],
//             showSelectedLabels: false,
//             showUnselectedLabels: false,
//             currentIndex: _selectedindex,
//             iconSize: 25,
//             selectedItemColor: Colors.white,
//             unselectedItemColor: Colors.black,
//             backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//             type: BottomNavigationBarType.fixed,
//             elevation: double.infinity,
//             onTap: _onselected,
//           ),
//         ),
//       ),
//     );
//   }
// }
// // //
