// import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:graduated_project/track&history/view/tracking.dart';

class Cart3 extends StatelessWidget {
  // const
  Cart3({super.key});
  List<Map<String, dynamic>> trackorcontinue = [
    {
      "title": "Track Order",
      "color": Color(0xff2D9F75),
      "color2": Colors.white,
    },
    {
      "title": "Continue Shopping",
      "color": Colors.white,
      "color2": Colors.black,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 210,
                horizontal: 20,
              ),
              child: Center(
                child: Column(
                  spacing: 20,
                  children: [
                    Image.asset("assets/SuccessIllustration.png"),
                    Center(
                      child: Text(
                        "Order Placed Successfully!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // SizedBox(height: 20,),
                    Text(
                      "Your order has been confirmed and is being processed. You will receive an email confirmation shortly.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                    // SizedBox(height: 20,),
                    Container(
                      width: 200,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffEAF5F1),
                      ),

                      child: Center(
                        child: Text(
                          "Order ID : SP-8829410",
                          style: TextStyle(
                            color: Color(0xff2D9F75),
                            fontSize: 16,
                          ),
                        ),
                      ), // Replace this with your desired icon or widget
                    ),
                    // SizedBox(height: 20,),
                    ListView.separated(
                      itemCount: trackorcontinue.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final item = trackorcontinue[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Tracking(),
                              ),
                            );
                          },
                          child: Container(
                            width: 250,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Color(0xff2D9F75),
                                width: 1.5,
                              ),
                              color: item['color'],
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item['title'],
                                    style: TextStyle(
                                      color: item['color2'],
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    //  Container(
                    //   width: 100,
                    //   height: 100,
                    //   color: Colors.green,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
