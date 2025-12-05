import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, String>> transactions = [
    {"title": "Transaction1", "Amount": "+5000"},
    {"title": "Transaction2", "Amount": "-5000"},
    {"title": "Transaction3", "Amount": "+1000"},
    {"title": "Transaction4", "Amount": "-300"},
    {"title": "Transaction5", "Amount": "+2000"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top bar with icons and title
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 64, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconBox(Icons.line_weight_outlined),
                Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _iconBox(Icons.notification_add_rounded),
              ],
            ),
          ),

          // Greeting
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello,",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Kirthi!",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                    // color: Colors.yellow[900],
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),

          // Balance Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.deepPurpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.4),
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Balance",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "₹2,000,000",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Income
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.arrow_downward, color: Colors.greenAccent, size: 20),
                                SizedBox(width: 5),
                                Text(
                                  "Income",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              "₹200,000",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        // Expenditure
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.arrow_upward, color: Colors.redAccent, size: 20),
                                SizedBox(width: 5),
                                Text(
                                  "Expenditure",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              "₹200,000",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Transactions Header
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Text(
              "Transactions",
              style: TextStyle(
                fontSize: 28,
                // color: Colors.indigo[900],
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Transaction List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple[100],
                        child: Icon(Icons.payment, color: Colors.deepPurple),
                      ),
                      title: Text(
                        transactions[index]["title"]!,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      trailing: Text(
                        transactions[index]["Amount"]!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: transactions[index]["Amount"]!.startsWith("-")
                              ? Colors.red
                              : Colors.green,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  // Helper method for top icons
  Widget _iconBox(IconData icon) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
      ),
      child: Icon(icon, color: Colors.black87),
    );
  }
}
