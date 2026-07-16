import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduated_project/cart_checkout/view/widgets/cart3.dart';

class Tracking2 extends StatelessWidget {
  // const
  Tracking2({super.key});
  List<Map<String, dynamic>> delivery_status = [
    {
      "status": "Order Placed",
      "subtitle": "We have received your order",
      "lastline": "",
    },
    {
      "status": "processing",
      "subtitle": "payment confirmed and order verified",
      "lastline": "",
    },
    {
      "status": "Preparing Medicines",
      "subtitle": "our pharmacist is carefully packing your medicines",
      "lastline": "",
    },
    {
      "status": "Out for Delivery",
      "subtitle": "Your order is out for delivery",
      "lastline": "",
    },
    {
      "status": "Delivered",
      "subtitle": "Your order has been delivered",
      "lastline": "",
    },
    // {"status": "completed", "subtitle": "", "lastline": ""},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 63,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4), // shadow من تحت بس
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Image.asset("assets/Button - Go back.png"),
                            // Image.asset("assets/Button - Go back.png"),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Track Order",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Order ID : 123456789",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        "Help",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff2D9F75),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 50),
              Stack(
                children: [
                  // الخريطة (الخلفية)
                  // Positioned(
                  // bottom: 10,
                  // child:
                  Container(
                    width: double.infinity,
                    height: 350,
                    child: Image.asset(
                      "assets/Map showing delivery location (1).png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 400,
                    ),
                  ),
                  Positioned(
                    bottom: 45,
                    left: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              // BorderRadius.circular(32),
                              // shape: BoxShape.circle,
                              color: Colors.grey[200],
                              // borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/SVG 11.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          // const CircleAvatar(
                          //   backgroundColor: Colors.amberAccent,
                          //   radius: 20,
                          //   backgroundImage: AssetImage(
                          //     "assets/OneDrive/SVG 10.png",
                          //   ),
                          // ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Delivery Hero",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Elgamal",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          Image.asset("assets/Button - Call rider.png"),
                          SizedBox(width: 10),
                          Container(
                            width: 43,
                            height: 43,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: Colors.grey[200],
                            ),

                            child: Image.asset("assets/SVG (8).png"),
                          ),
                          // Image.asset(
                          //   "assets/OneDrive/Button - Call rider.png",
                          // ),
                          // _circleIconButton(Icons.call, Colors.green, () {
                          // اتصال بالمندوب
                          // }),
                          const SizedBox(width: 8),
                          // _circleIconButton(Icons.message, Colors.green, () {
                          // رسالة للمندوب
                          // }),
                        ],
                      ),
                    ),
                  ),
                  // ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivery Status",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          "Estimated Delivery : 4:30 pm",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),

                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index <= 2
                                  ? Color(0xff2D9F75)
                                  : Colors.grey[300],
                            ),
                            child: Icon(
                              index < 2 ? Icons.check : Icons.circle,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          title: Text(
                            delivery_status[index]["status"],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                delivery_status[index]["subtitle"],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                // , Color: Colors.grey
                              ),
                              SizedBox(height: 4),
                              Text(
                                delivery_status[index]["lastline"],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 12);
                      },
                      itemCount: delivery_status.length,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Order Summary",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Items (3)",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "42.50 L.E.",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delivery Fee",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Free",

                      style: TextStyle(
                        color: Color(0xff2D9F75),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 0.3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Amount",
                      style: TextStyle(
                        // color: Col,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "42.50 L.E.",
                      style: TextStyle(
                        color: Color(0xff2D9F75),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: double.infinity,
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(26.0),

                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Cart3()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 240,

                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff2D9F75)),

                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "View Items",
                                      style: TextStyle(
                                        // Color(0xff2D9F75)
                                        color: Color(0xff2D9F75),
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 240,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xff2D9F75),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Contact Support",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ],
                    // ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
