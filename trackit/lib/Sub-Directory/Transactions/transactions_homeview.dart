import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackit/Sub-Directory/CategorySection/AddSavings.dart';


// Main widget representing the Expense Details page.
class transactions_homeview extends StatefulWidget {
  const transactions_homeview({super.key,
  required this.index,
    required this.name,
  });

  final String name;
  final int index;

  @override
  State<transactions_homeview> createState() => _transactions_homeviewState();
}

class _transactions_homeviewState extends State<transactions_homeview> {


  int isSelected = 0;

  void changeScreen(int index) {
    setState(() {
      isSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with back button, title, and notification icon.
      appBar: AppBar(
        elevation: 0, // Removes shadow from app bar
        backgroundColor: Theme.of(context).colorScheme.inversePrimary, // Sets background color based on theme
        leading:  IconButton(onPressed: () { Navigator.pop(context);}, icon: Icon(Icons.arrow_back)), // Back button icon
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
            ),
          ),
        ],
        title: const Text('Transactions', style: TextStyle(
          fontFamily: 'Lilita_one',
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),), // Title of the page
        centerTitle: true, // Center align the title
      ),
      body: Container(
        color: Theme.of(context).colorScheme.inversePrimary, // Background color for the page
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 10,top: 24,right: 10),
                child: Column(
                  children: [
                    _buildCategoryItem(  label: 'Total Balance',amount: "\$24,200.00",),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        InfoCard(title: "Income", amount: "\$14,200.00",
                          icon: Icons.vertical_align_top_sharp,
                          color: Colors.deepPurple,
                          isSelected: isSelected == 0,
                          onTap: () => changeScreen(0),
                          index: 0,  ),
                        SizedBox(width: 12,),
                        InfoCard(title: "Expense",
                          amount: "\$563.53",
                          icon: Icons.vertical_align_bottom_sharp,
                          color: Colors.blueAccent,
                          isSelected: isSelected == 1,
                          onTap: () => changeScreen(1),
                          index: 1,
                        ),
                      ],
                    ),
                  ],
                )
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20), // Padding inside the container
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface, // Background color for the inner container
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: isSelected == 0 ? _IncomeExpenseList() : _ExpenseList(),
                // _ExpenseList(), // List of expenses
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _buildCategoryItem extends StatelessWidget {
  final String label;
  final String amount;

  const _buildCategoryItem({
    super.key,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 500,
      decoration: BoxDecoration(
          color: Colors.white54, // Background color for the inner container
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Lilita_one',
              fontSize: 19,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontFamily: 'Lilita_one',
              fontSize: 25,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}


class _IncomeExpenseList extends StatefulWidget {
  @override
  _IncomeExpenseListState createState() => _IncomeExpenseListState();
}

class _IncomeExpenseListState extends State<_IncomeExpenseList> {
  String selectedMonth = DateFormat('MMMM yyyy').format(DateTime.now()); // Default to current month

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(height: 18,),
        // Header with the selected month and calendar icon
        Padding(
          padding: const EdgeInsets.only(left: 20,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedMonth,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue
                ),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today,color: Colors.deepPurpleAccent,),
                onPressed: _showMonthPicker,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              // Each item in the list is an instance of _ExpenseItem
              _SavingsItem(
                iconData: Icons.car_rental_rounded,
                title: 'Salary',
                date: '18:27 - April 30',
                amount: '-\$26.00',
              ),
              _SavingsItem(
                iconData:Icons.car_rental_rounded,
                title: 'Forex',
                date: '15:00 - April 24',
                amount: '-\$18.35',
              ),
              _SavingsItem(
                iconData:Icons.car_rental_rounded,
                title: 'Other',
                date: '12:30 - April 15',
                amount: '-\$15.40',
              ),
              _SavingsItem(
                iconData: Icons.car_rental_rounded,
                title: 'Parent',
                date: '9:30 - April 08',
                amount: '-\$12.13',
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showMonthPicker() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            cardColor: Colors.blue,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null && selectedDate != DateTime.now()) {
      setState(() {
        selectedMonth = DateFormat('MMMM yyyy').format(selectedDate);
      });
    }
  }
}

// Widget for expense transactions

class _ExpenseList extends StatefulWidget {
  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<_ExpenseList> {
  String selectedMonth = DateFormat('MMMM yyyy').format(DateTime.now()); // Default to current month

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(height: 18,),
        // Header with the selected month and calendar icon
        Padding(
          padding: const EdgeInsets.only(left: 20,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedMonth,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue
                ),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today,color: Colors.deepPurpleAccent,),
                onPressed: _showMonthPicker,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              // Each item in the list is an instance of _ExpenseItem
              _SavingsItem(
                iconData: Icons.car_rental_rounded,
                title: 'Car Deposit',
                date: '18:27 - April 30',
                amount: '-\$26.00',
              ),
              _SavingsItem(
                iconData:Icons.car_rental_rounded,
                title: 'Car Wash',
                date: '15:00 - April 24',
                amount: '-\$18.35',
              ),
              _SavingsItem(
                iconData:Icons.car_rental_rounded,
                title: 'Sch Fees',
                date: '12:30 - April 15',
                amount: '-\$15.40',
              ),
              _SavingsItem(
                iconData: Icons.car_rental_rounded,
                title: 'Latop',
                date: '9:30 - April 08',
                amount: '-\$12.13',
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showMonthPicker() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            cardColor: Colors.blue,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null && selectedDate != DateTime.now()) {
      setState(() {
        selectedMonth = DateFormat('MMMM yyyy').format(selectedDate);
      });
    }
  }
}

// Widget representing a single expense item in the list.
class _SavingsItem extends StatelessWidget {
  final IconData iconData; // Icon representing the expense category
  final String title; // Title of the expense (e.g., Dinner)
  final String date; // Date and time of the expense
  final String amount; // Amount spent

  const _SavingsItem({
    required this.iconData,
    required this.title,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0), // Vertical padding for each item
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the icon/label and the amount
        children: [
          Row(
            children: [
              // CircleAvatar for the icon with a background color and icon color based on the theme
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                child: Icon(iconData, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(width: 17), // Spacing between the icon and the text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                children: [
                  Text(title, style: const TextStyle(fontSize: 18)), // Expense title
                  Text(date, style: const TextStyle(fontSize: 14, color: Colors.grey)), // Date and time
                ],
              ),
            ],
          ),
          // Amount text with conditional color based on whether it's a negative amount (expense)
          Text(
            amount,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: amount.startsWith('-') ? Colors.blue : Colors.black, // Red color for negative amounts
            ),
          ),
        ],
      ),
    );
  }
}

//Widget representing goals and amount saved
class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String amount;
  final Color color;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  InfoCard({required this.title,
    required this.amount,
    required this.icon,
    required this.color,
    required this.index,
    required this.isSelected,
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 170,
          height: 110,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color:isSelected ? Colors.blue[800] : Colors.white54,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  color: color,
                  child: Icon(icon, size: 15,
                    color: Colors.black,),
                ),
                SizedBox(width: 10,),
                Text(title, style: TextStyle(color:  Colors.blue,fontSize: 20,fontWeight: FontWeight.bold)),
                SizedBox(width: 6,),
                Text(amount, style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold,fontSize: 25)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
