import 'package:flutter/material.dart';
import 'package:homely/Provider/Main_Provider/MainProvider.dart';
import 'package:provider/provider.dart';

import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import '../../Provider/Main_Provider/SubAdmin_Provider.dart';
import 'Sub_AdminHomePage.dart';

class alertsbox extends StatelessWidget {
   alertsbox({super.key,});

  @override
  Widget build(BuildContext context) {
    SubAdmin_Provider sub_provider = Provider.of(context, listen: false);
    return Scaffold(
      body: Center(
          child: Container(
        height: 300,
        width: 300,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            Text(
              "Request Sent",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      )),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(60.0),
        child: InkWell(onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SubAdminHomePage(Id: '',),));
        },
          // child:  Container(
          //       width: 300,
          //       alignment: Alignment.centerRight,
          //       child: MaterialButton(
          //         onPressed: ()
          //         {
          //           sub_provider.Add_CareHome_P3(context, ID, from);
          //           sub_provider.get_CareHome_Details();
          //
          //         },
          //         elevation: 5,
          //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          //         color: maingreen,
          //         child: Padding(
          //           padding: const EdgeInsets.only(top: 5),
          //           child: Page_content("Pay ", 18, FontWeight.bold, Colors.white),
          //         ),
          //       ),
          //     )
          //   ,
          child: Container(
            decoration: ShapeDecoration(
                color: Color(0xff04735b),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            height: 60,
            width: 300,
            child: Center(child: Text("Back to Home",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white,fontSize: 20))),
          ),
        ),
      ),
    );
  }
}
