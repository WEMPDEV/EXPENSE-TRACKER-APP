import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'AddExpense.dart'; // Import intl package for date formatting

// Main widget representing the Expense Details page.
class EntertainmentCategory extends StatelessWidget {
  const EntertainmentCategory({super.key});

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
        title: const Text('Entertainment', style: TextStyle(
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
            const SizedBox(height: 10), // Spacing at the top
            _BalanceSummary(
              balance: "\$7,783.00",
              expense: "-\$1,187.40",
              progressValue: 0.3,
              totalLimit: "\$20,000.00",
              isChecked: true,
              onCheckboxChanged: (value) {},
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
                child: _ExpenseList(), // List of expenses
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget representing the balance summary section with progress indicator and checkbox.
class _BalanceSummary extends StatelessWidget {
  final String balance; // Total balance amount
  final String expense; // Total expense amount
  final double progressValue; // Progress of the expense limit
  final String totalLimit; // Total spending limit
  final bool isChecked; // Checkbox value
  final ValueChanged<bool?> onCheckboxChanged; // Callback when checkbox is changed

  const _BalanceSummary({
    required this.balance,
    required this.expense,
    required this.progressValue,
    required this.totalLimit,
    required this.isChecked,
    required this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, // Evenly spaces the children across the row
            children: [
              _BalanceInfo(label: 'Total Balance', amount: balance),
              Container(height: 50, width: 2, color: Colors.white), // Divider between balance and expense info
              _BalanceInfo(label: 'Total Expense', amount: expense, isExpense: true),
            ],
          ),
          const SizedBox(height: 10), // Spacing between balance info and progress bar
          Stack(
            children: [
              Container(
                height: 27, // Height of the progress bar container
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.5), // Rounded corners for the container
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.5), // Clip the progress bar with rounded corners
                  child: LinearProgressIndicator(
                    value: progressValue, // Progress value
                    backgroundColor: Colors.white, // Background color for the progress bar
                    // color: Theme.of(context).colorScheme.primary, // Progress color based on theme
                    color: Colors.black,
                    minHeight: 25, // Minimum height of the progress bar
                  ),
                ),
              ),
              // Text displaying the progress percentage, positioned on top of the progress bar
              Positioned(
                left: 20,
                top: 5,
                bottom: 5,
                child: Text(
                  "${(progressValue * 100).toInt()}%", // Converts the progress value to percentage
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Nunito-Bold',
                  ),
                ),
              ),
              // Text displaying the total limit, positioned on the right of the progress bar
              Positioned(
                right: 30,
                top: 5,
                bottom: 5,
                child: Text(
                  totalLimit,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Nunito-Bold',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5), // Spacing between progress bar and checkbox
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center align the row
            children: [
              Checkbox(
                value: isChecked, // Checkbox value
                onChanged: onCheckboxChanged, // Callback when checkbox is changed
                shape: const BeveledRectangleBorder(), // Shape of the checkbox
              ),
              const Text(
                "30% of Your Expenses, Looks Good.", // Checkbox label
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget representing individual balance information (e.g., Total Balance, Total Expense).
class _BalanceInfo extends StatelessWidget {
  final String label; // Label for the balance info (e.g., Total Balance)
  final String amount; // Amount displayed (e.g., $7,783.00)
  final bool isExpense; // Whether this info represents an expense

  const _BalanceInfo({
    required this.label,
    required this.amount,
    this.isExpense = false, // Defaults to not an expense
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Center align the children vertically
      children: [
        Row(
          children: [
            // Small container for the icon with a specific size and color
            Container(
              height: 15,
              width: 15,
              color: Colors.white,
              child: Center(
                child: Icon(
                  isExpense ? Icons.vertical_align_bottom_sharp : Icons.vertical_align_top_sharp, // Different icon for expense or balance
                  size: 15,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 5), // Spacing between icon and label
            Text(
              label, // Label text
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        // Amount text with conditional styling based on whether it's an expense or not
        Text(
          amount,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isExpense ? Colors.lightBlueAccent : Colors.black, // Different color for expense
          ),
        ),
      ],
    );
  }
}

class _ExpenseList extends StatefulWidget {
  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<_ExpenseList> {
  String selectedMonth = DateFormat('MMMM yyyy').format(DateTime.now()); // Default to current month

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              _ExpenseItem(
                iconData:  Icons.movie,
                title: 'Netflix',
                date: '18:27 - April 30',
                amount: '-\$26.00',
              ),
              _ExpenseItem(
                iconData: Icons.movie,
                title: 'Cartoons',
                date: '15:00 - April 24',
                amount: '-\$18.35',
              ),
              _ExpenseItem(
                iconData:  Icons.movie,
                title: 'Video Games',
                date: '12:30 - April 15',
                amount: '-\$15.40',
              ),
              _ExpenseItem(
                iconData:  Icons.movie,
                title: 'Netflix',
                date: '9:30 - April 08',
                amount: '-\$12.13',
              ),
              _ExpenseItem(
                iconData:  Icons.movie,
                title: 'Cinema',
                date: '20:50 - March 31',
                amount: '-\$27.20',
              ),
            ],
          ),
        ),
        // Centered Accept button below the expense list
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddExpenseForm()),

                );  // Handle button press action here
              },
              child: Text('Add Expense',style: TextStyle(color: Theme.of(context).buttonTheme.colorScheme?.primary),),
              style: ElevatedButton.styleFrom(
                backgroundColor:Theme.of(context).colorScheme.inversePrimary, // Background color based on theme
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                textStyle: const TextStyle(fontSize: 16,),
              ),
            ),
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
class _ExpenseItem extends StatelessWidget {
  final IconData iconData; // Icon representing the expense category
  final String title; // Title of the expense (e.g., Dinner)
  final String date; // Date and time of the expense
  final String amount; // Amount spent

  const _ExpenseItem({
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