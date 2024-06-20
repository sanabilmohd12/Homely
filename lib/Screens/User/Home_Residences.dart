import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homely/Constants/Call_Functions.dart';
import 'package:homely/Constants/Colors.dart';
import 'package:homely/Constants/MyWidgets.dart';
import 'package:provider/provider.dart';

import '../../Constants/Residences_Details.dart';
import '../../Provider/Login_Provider/LoginProvider.dart';
import '../../Provider/Main_Provider/SubAdmin_Provider.dart';
import '../Sub_Admin/Sub_AdminHomePage.dart';
import 'CareHome_details.dart';

class Home_Residences extends StatelessWidget {
  const Home_Residences({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    var loginUser = auth.currentUser;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    SubAdmin_Provider sub_provider = Provider.of(context, listen: false);
    return SafeArea(
        child: Scaffold(
      appBar: Appbar_user("Residences", context),
      endDrawerEnableOpenDragGesture: true,
      //drawerScrimColor: white,
      endDrawer: Drawerlist(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              General_Search(),
              SizedBox(height: 14),

// advanced search
//                   Padding(
//                     padding: EdgeInsets.only(left: width/2.05),
//                     child: TextButton(
//                         onPressed: (){},
//                         child: Text("Advanced Search",
//                           style: GoogleFonts.karma(textStyle:
//                           const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: linkcolor,
//                               decoration: TextDecoration.underline,decorationColor: linkcolor)),),
//                     ),
//                   ),
// advanced search boxes
// Residences grid view
              SizedBox(
                height: height / 1.5,
                width: width,
                child: Consumer<SubAdmin_Provider>(

                    builder: (context, value, child) {
                  return GridView.builder(
                    itemCount: value.User_CareHomeList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        //mainAxisSpacing: 2000
                        mainAxisExtent: 170),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          callNext(context, CareHomeDetails());
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 140,
                              width: 140,
                              alignment: Alignment.bottomCenter,

                              //color: Colors.blueGrey,
                              decoration: BoxDecoration(
                                  //border: Border.all(color: Color(0xff4c5463)),

                                  //color: Color(0xff35384a),
                                  //gradient: LinearGradient(colors: Color(0xffCDCDCD)),//[Color(0xffFFFFFF2B), Color(0xffFFFFFF00)]),
                                  //borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image: AssetImage(Home_pics[index]),
                                      fit: BoxFit.fill)),
                              //child: Text(Home_names[index],style: TextStyle(color: Colors.white),),
                            ),
                            Page_content(Home_names[index], 15, FontWeight.bold,
                                maingreen)
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 5,
                child: Row(
                  children: [
                    SizedBox(
                      width: width / 1.8,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, top: 10, bottom: 8),
                        child: Page_content(
                            "Get listed on our website and access membership "
                            "benefits by registering your homes.",
                            13,
                            FontWeight.bold,
                            black),
                      ),
                    ),
                    Consumer<LoginProvider>(builder: (context1, value, child) {
                      return MaterialButton(
                        onPressed: () {
                          sub_provider.find_UserCareHomes(value.userId);
                          callNext(context, SubAdminHomePage(Id: value.userId));
                        },
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: maingreen,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Page_content(
                              "Join Us", 18, FontWeight.bold, Colors.white),
                        ),
                      );
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    )

        // ListTile(
        // leading: Icon(Icons.message),
        // title: Text('Messages'),
        // ),
        // ListTile(
        // leading: Icon(Icons.account_circle),
        // title: Text('Profile'),
        // ),
        // ListTile(
        // leading: Icon(Icons.settings),
        // title: Text('Settings'),
        // ),
        // ],
        // ),
        //),
        // )
        );
  }
}
