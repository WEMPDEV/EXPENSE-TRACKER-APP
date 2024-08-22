
import 'package:flutter/material.dart';
import 'package:trackit/Sub-Directory/CategorySection/EntertainmentCategory.dart';
import 'package:trackit/Sub-Directory/CategorySection/FoodCategory.dart';
import 'package:trackit/Sub-Directory/CategorySection/AddExpense.dart';
import 'package:trackit/Sub-Directory/CategorySection/GiftsCategory.dart';
import 'package:trackit/Sub-Directory/CategorySection/GrociesCategory.dart';
import 'package:trackit/Sub-Directory/CategorySection/MedcineCategory.dart';
import 'package:trackit/Sub-Directory/CategorySection/RentCatogory.dart';
import 'package:trackit/Sub-Directory/CategorySection/TransportCategory.dart';

import 'SavingsCategory.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 90),
            child: Center(
              child: Text(
                'Categories',
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
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    child: Container(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 35),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                child: Center(child: Icon(Icons.vertical_align_top_sharp, size: 15, color: Colors.black)),
                                                height: 15,
                                                width: 15,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "Total Balance",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "\$7,783.00",
                                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 2,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 35),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                child: Center(child: Icon(Icons.vertical_align_bottom_sharp, size: 15, color: Colors.black)),
                                                height: 15,
                                                width: 15,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "Total Expense",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "-\$1,187.40",
                                            style: TextStyle(color: Colors.lightBlueAccent, fontSize: 24, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 27,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12.5),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12.5),
                                          child: LinearProgressIndicator(
                                            value: 0.3,
                                            backgroundColor: Colors.white,
                                            // color: Theme.of(context).colorScheme.secondary,
                                            color: Colors.black,
                                            minHeight: 25,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 20,
                                        top: 5,
                                        bottom: 5,
                                        child: Text(
                                          "30%",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'Nunito-Bold',
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 30,
                                        top: 5,
                                        bottom: 5,
                                        child: Text(
                                          "\$20,000.00",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontFamily: 'Nunito-Bold',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        value: true,
                                        onChanged: (value) {},
                                        shape: BeveledRectangleBorder(),
                                      ),
                                      Text(
                                        "30% of Your Expenses, Looks Good.",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 80,left: 20,right: 20),
                      child: GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                        children: [
                          _buildCategoryItem(
                            ontap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Foodcategory()),
                            ),
                            iconData: Icons.restaurant,
                            label: 'Food',),

                          _buildCategoryItem(
                            ontap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TransportCategory()),
                          ), iconData:  Icons.directions_bus, label: 'Transport',),

                          _buildCategoryItem(
                            ontap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MedicineCategory()),
                            ), iconData:Icons.medical_services, label: 'Medicine',),

                          _buildCategoryItem(
                            ontap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GroceriesCategory()),
                            ), iconData: Icons.local_grocery_store_rounded, label: 'Groceries',),

                          _buildCategoryItem(
                            ontap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RentCategory()),
                            ), iconData:Icons.home, label:'Rent',),

                          _buildCategoryItem(
                            ontap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GiftsCategory()),
                            ), iconData:Icons.card_giftcard, label: 'Gifts',),

                          _buildCategoryItem(
                            ontap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SavingsCategory()),
                            ), iconData: Icons.savings,label: 'Savings',),

                          _buildCategoryItem(
                            ontap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EntertainmentCategory()),
                            ), iconData: Icons.movie, label: 'Entertainment',),

                          _buildCategoryItem(
                            ontap: () =>  showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Form(
                                  key: _formKey,
                                  child: AlertDialog(
                                    title: Center(child: const Text('New Category',style: TextStyle(
                                      fontFamily: 'Lilita_one',
                                    ),)),
                                    content: Container(
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
                                          decoration: InputDecoration(
                                            labelText: 'Enter Category',
                                            labelStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,fontWeight: FontWeight.bold),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
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
                                              onPressed: () {
                                                if (_formKey.currentState?.validate() ?? false) {
                                                  // Process data
                                                }
                                              },
                                              child: const Text('Save',style: TextStyle(
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
                                  ),
                                );
                              },
                            ), iconData:  Icons.add, label: 'More',),
                          // buildCategoryItem(context, Icons.co2, 'checker')
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
    );
  }
}

class _buildCategoryItem extends StatelessWidget {
  final VoidCallback ontap;
  final IconData iconData;
  final String label;

  const _buildCategoryItem({
    super.key,
    required this.ontap,
    required this.iconData,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Icon(
              iconData,
              size: 40,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
class CategoryDetailPage extends StatelessWidget {
  final String label;

  const CategoryDetailPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      body: Center(
        child: Text('Welcome to $label page!', style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}