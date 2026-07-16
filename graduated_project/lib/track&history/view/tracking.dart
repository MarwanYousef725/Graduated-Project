import 'package:flutter/material.dart';
import 'package:graduated_project/track&history/view/tracking2.dart';

class Tracking extends StatelessWidget {
  // const
  Tracking({super.key});
  List<Map<String, dynamic>> trackorcontinue = [
    {
      "order no": "Order #ORD-88219",
      "history": "Oct 24, 2023 • 10:45 AM",
      "type": "Paracetamol, Vitamin C + 2 more",
      "price": "42.50 L.E",
      "no of items": "4 Items total",
      "status": "DELIVERED",
    },
    {
      "order no": "Order #ORD-77541",
      "history": "Oct 12, 2023 • 02:15 PM",
      "type": "Ibuprofen, Ascorbic Acid + 1 more",
      "price": "12.75 L.E",
      "no of items": "3 Items total",
      "status": "CANCELLED",
    },
    {
      "order no": "Order #ORD-66120",
      "history": "Sep 28, 2023 • 09:00 AM",
      "type": "Cough Syrup, Bandages",
      "price": "25.75 L.E",
      "no of items": "2 Items total",
      "status": "DELIVERED",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                    itemCount: trackorcontinue.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = trackorcontinue[index];
                      return Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 14,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // assets/SVG (6).png
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(item["order no"]),
                                      Text(
                                        item["history"],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: item["status"] == "CANCELLED"
                                          ? Color(0xffFEE2E2)
                                          : Color(0xffDCFCE7),
                                      // Color(0xffDCFCE7),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      item["status"],

                                      style: TextStyle(
                                        color: item["status"] == "CANCELLED"
                                            ? Color(0xffB91C1C)
                                            : Color(0xff15803D),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  spacing: 26,
                                  children: [
                                    Container(
                                      width: 45,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Image.asset("assets/SVG (6).png"),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 4,
                                      children: [
                                        Text(
                                          item["type"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          item["no of items"],
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      item["price"],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: item["status"] == "CANCELLED"
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => Tracking2(),
                                            ),
                                          );
                                          // Handle reorder action here
                                        },
                                        child: Container(
                                          width: 280,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: Color(0xffFEE2E2),
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Reorder",
                                              style: TextStyle(
                                                color: Color(0xffB91C1C),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            width: 280,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Color(0xff2D9F75),
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "view details",
                                                style: TextStyle(
                                                  color: Color(0xff2D9F75),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 280,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: Color(0xff2D9F75),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Reorder",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
