import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpenseForm extends StatefulWidget {
  final ValueChanged<String?>? onCategorySelected;

  AddExpenseForm({
    Key? key,
    this.onCategorySelected,
  }) : super(key: key);

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  String selectedMonth = DateFormat('dd MMMM yyyy').format(DateTime.now());
 // Default to current month

  @override
  void dispose() {
    dateController.dispose();
    amountController.dispose();
    titleController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return  Scaffold(
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
        title: const Text('Add Expenses', style: TextStyle(
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
            Expanded(
              child: Container(
                padding:  EdgeInsets.all(20), // Padding inside the container
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface, // Background color for the inner container
                  borderRadius:  BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child:  Form(
                  key: _formKey,
                  child: ListView(
                    children: [ Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 80,),
                        Text('Date',style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 20,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),),
                        SizedBox(height: 10,),
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
                            padding:  EdgeInsets.symmetric(
                                horizontal: 30.0),
                            child: TextField(
                              controller: dateController,
                              keyboardType: TextInputType.datetime,
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: selectedMonth,
                                labelStyle: theme.textTheme.labelLarge,
                                suffixIcon:  IconButton(
                                  icon:  Icon(Icons.calendar_today,color: Colors.deepPurpleAccent,),
                                  onPressed: _showMonthPicker,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16,),
                        Text('Category',style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 20,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),),
                        SizedBox(height: 10,),
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
                            padding:  EdgeInsets.symmetric(
                                horizontal: 30.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                hintText: 'Select Expense Category',
                                labelStyle: theme.textTheme.labelLarge,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none,
                                ),
                              ),
                              items: [
                                DropdownMenuItem(value: 'Food', child: Text('Food')),
                                DropdownMenuItem(value: 'Transport', child: Text('Transport')),
                                DropdownMenuItem(value: 'Entertainment', child: Text('Entertainment')),
                              ],
                              onChanged: widget.onCategorySelected,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text('Amount',style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 20,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),),
                        SizedBox(height: 10,),
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
                            padding:  EdgeInsets.symmetric(
                                horizontal: 30.0),
                            child: TextField(
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'amount spent',
                                labelStyle: theme.textTheme.labelLarge,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text('Expense Title',style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 20,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),),
                        SizedBox(height: 10,),
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
                            padding:  EdgeInsets.symmetric(
                                horizontal: 30.0),
                            child:TextField(
                              controller: titleController,
                              decoration: InputDecoration(
                                hintText: "e.g dinner, fuel, pantry, rent e.t.c",
                                labelStyle: theme.textTheme.labelLarge,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
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
                            padding:  EdgeInsets.symmetric(
                                horizontal: 30.0),
                            child:TextField(
                              controller: messageController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                labelText: 'Enter Message',
                                labelStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                // Process data
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:Theme.of(context).colorScheme.inversePrimary, //
                              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                            child: Text(
                              'Save',
                              style:TextStyle(color: Theme.of(context).buttonTheme.colorScheme?.primary),
                            ),
                          ),
                        ),
                      ],
                    ),],
                  ),
                ), // List of expenses
              ),
            ),
          ],
        ),
      ),
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
        selectedMonth = DateFormat('dd MMMM yyyy').format(selectedDate);
      });
    }
  }
}
