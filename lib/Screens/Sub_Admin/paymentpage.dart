import 'package:flutter/material.dart';
import 'package:homely/Provider/Main_Provider/MainProvider.dart';
import 'package:homely/Screens/Sub_Admin/alert.dart';
import 'package:provider/provider.dart';

import '../../Constants/Call_Functions.dart';
import '../../Constants/MyWidgets.dart';
import 'Sub_AdminHomePage.dart';

class paymentPage extends StatelessWidget {
  const paymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: Appbar_SubAdmin("Payment","Homely", context),

      body: Center(
          child: Container(
            height: height/3.2,
            width: width/1.5,
            decoration: BoxDecoration(color: Color(0xfffff1e2),
                borderRadius: BorderRadius.circular(15),boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 1,blurRadius: 1)]),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Pay Amount",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "₹ 1000",
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          )),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Consumer<MainProvider>(
          builder: (context, value, child) {


            return InkWell(onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => alertsbox(),));
              value.razorpayGateway();
            },

              child: Container(
                decoration: ShapeDecoration(
                    color: Color(0xff04735b),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                height: 60,
                width: 300,
                child: Center(child: Text("Pay Now",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white,fontSize: 20))),
              ),
            );
          }
        ),
      ),





    );
  }
}
