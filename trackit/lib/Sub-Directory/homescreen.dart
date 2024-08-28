
import 'package:flutter/material.dart';
import 'package:trackit/Sub-Directory/bottomnavbars.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  const HomeScreen({
    super.key, required this.username, });


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  get email => email;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: Icon(Icons.menu),
        actions: [
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
        // color: Colors.deepPurple,
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
                    // color:  Colors.deepPurple,
                    child:  Container(
                      color:Theme.of(context).colorScheme.inversePrimary,
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hi,Welcome Back:\n${widget.username} ",
                                  style: TextStyle( fontSize: 25,fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Good Morning",
                                  style: TextStyle( fontSize: 18,color:  Colors.lightBlueAccent),
                                ),
                                SizedBox(height: 5),
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
                                                  child: Center(child: Icon(Icons.vertical_align_top_sharp,size: 15,color: Colors.black,)),
                                                height: 15,width: 15,color: Colors.white,
                                              ),
                                              SizedBox(width: 5,),
                                              Text(
                                                "Total Balance",
                                                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "\$7,783.00",
                                            style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold),
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
                                                child: Center(child: Icon(Icons.vertical_align_bottom_sharp,size: 15,color: Colors.black,)),
                                                height: 15,width: 15,color: Colors.white,
                                              ),
                                              SizedBox(width: 5,),
                                              Text(
                                                "Total Expense",
                                                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
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
                                SizedBox(height: 05),
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
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Icon(Icons.circle, size: 10),
                                      Checkbox(value: true,
                                          onChanged: (value) {

                                          },
                                        shape: BeveledRectangleBorder(),
                                      ),
                                      // SizedBox(width: 10),
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
                    )
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InfoCard(title: "Savings On Goals", amount: "\$4,000.00"),
                            InfoCard(title: "Food Last Week", amount: "-\$100.00"),
                          ],
                        ),
                        SizedBox(height: 20),
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
                                ToggleButtons(
                                  isSelected: [false, false, true],
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Text("Daily"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Text("Weekly"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Text("Monthly"),
                                    ),
                                  ],
                                  onPressed: (int index) {

                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ListView(
                          shrinkWrap: true,
                          children: [
                            TransactionItem(
                              icon: Icons.attach_money,
                              title: "Salary",
                              date: "18:27 - April 30",
                              amount: "\$4,000.00",
                              subtitle: 'Monthly',
                            ),
                            SizedBox(height: 12),
                            TransactionItem(
                              icon: Icons.shopping_cart,
                              title: "Groceries",
                              date: "17:00 - April 24",
                              amount: "-\$100.00",
                              subtitle: 'Pantry',
                            ),
                            SizedBox(height: 12),
                            TransactionItem(
                              icon: Icons.home,
                              title: "Rent",
                              date: "8:30 - April 15",
                              amount: "-\$674.40",
                              subtitle: 'Rent',
                            ),
                          ],
                        ),
                      ],
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
class InfoCard extends StatelessWidget {
  final String title;
  final String amount;

  InfoCard({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(color:  Colors.lightBlueAccent)),
          Text(amount, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}


class TransactionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String date;
  final String amount;
  final String subtitle;

  TransactionItem({
    required this.icon,
    required this.title,
    required this.date,
    required this.amount,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30,top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            child: Icon(icon, color: Colors.white,size: 35,),
          ),
          SizedBox(width:10 ,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: TextStyle(fontSize: 19),),
              SizedBox(height: 5),
              Text(date,style: TextStyle(fontSize: 15),),
            ],
          ),
          SizedBox(width:25 ,),
          Container(
            height: 30,
            width: 2,
            color: Colors.blue,
          ),
          SizedBox(width:10 ,),
           Text(subtitle,style: TextStyle(fontSize: 15),),
          SizedBox(width:10 ,),
          Container(
            height: 30,
            width: 2,
            color: Colors.blue,
          ),
          SizedBox(width:10 ,),
           Text(amount, style: TextStyle(color: Colors.blue,fontSize: 15)),
        ],
      ),
    );
  }
}



// @override
// Widget build(BuildContext context) {
//   return ListTile(
//     leading: CircleAvatar(
//       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       child: Icon(icon, color: Colors.white),
//     ),
//     title: Text(title),
//     subtitle: Text(date),
//     trailing: Text(amount, style: TextStyle(color: Colors.blue)),
//   );
// }
// }
