import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homely/Constants/Call_Functions.dart';
import 'package:provider/provider.dart';

import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import '../../Provider/Login_Provider/LoginProvider.dart';
import '../../Provider/Main_Provider/SubAdmin_Provider.dart';
import '../User/Home_Residences.dart';
import 'SubAdminRegPage1.dart';
import 'Sub_AdminCareHomeList.dart';


class SubAdminHomePage extends StatelessWidget {
  String Id; //getting userid
  SubAdminHomePage({super.key, required this.Id});

  @override
  Widget build(BuildContext context) {
    print("SUB ADMIN HOMEPAGE $Id");
    var width = MediaQuery.of(context).size.width;
    SubAdmin_Provider sub_provider = Provider.of(context, listen: false);
    return SafeArea(
        child: Scaffold(
          backgroundColor: subadminBG,
          floatingActionButton: SizedBox(
            height: 42,
            width: 170,
            child: FloatingActionButton(
              elevation: 10,
              backgroundColor: maingreen,
              onPressed: (){
                callNext(context, Home_Residences());

                //provider.cleardata();
                //Navigator.push(context, MaterialPageRoute(builder: (context) => AddDetails(ID: "", todo: 'New',)));
              },
              //tooltip: 'Increment Press',
              //child: const Icon(Icons.add,color: Colors.white,size: 30,),
              child: Page_content("Go to Home Page", 16, FontWeight.bold, Colors.white),
            ),
          ),
          body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Appbar_container(width, maingreen, homelycolor, slogancolor),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          children: [
                            Page_content("WELCOME OPERATOR ", 20, FontWeight.bold, maingreen),
                            Divider(color: maingreen,thickness: 1,),
                            Card(
                              color: textformcolor,
                              child: Container(
                                //height: 170,
                                width: width,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      sub_provider.User_CareHomeList.isEmpty ?
                                      Page_content("Would you like to be added to our care home directory?\n"
                                  "*Please fill out the fields mentioned, especially all fields that have a (*) as these are mandatory "
                                          "fields and you will not be fully registered without these mandatory items.\n"
                                          "Once you have clicked the “SUBMIT” button we will send you a confirmation email and "
                                          "as soon as payment has been received, your residence will be officially added to our website.",
                                          14, FontWeight.w600, black):
                                      Page_content("Would you like to add a new care home?\n"
                                          "*Please fill out the fields mentioned, especially all fields that have a (*) as these are mandatory "
                                          "fields and you will not be fully registered without these mandatory items.\n"
                                          "Once you have clicked the “SUBMIT” button we will send you a confirmation email and "
                                          "as soon as payment has been received, your residence will be officially added to our website.",
                                          14, FontWeight.w600, black),
                                      Padding(
                                        padding: EdgeInsets.only(left:width/2.2),
                                        child: MaterialButton(
                                          onPressed: ()
                                          {
                                            sub_provider.check_allcarehome_regFinished(context,Id);

                                            },
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          color: maingreen,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 5),
                                            child: Page_content("Proceed", 18, FontWeight.bold, Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // crete a pageprofli
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Card(
                                //   color: subadminhomecontainer,
                                //   child: Container(
                                //     height: 145,
                                //     width: 140,
                                //     padding: EdgeInsets.symmetric(vertical: 15),
                                //     child: Column(
                                //       children: [
                                //         Icon(Icons.person,color: Colors.white,size: 85,),
                                //         Page_content("Profile", 20, FontWeight.bold, Colors.black)
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                Consumer<SubAdmin_Provider>(
                                    builder: (context8, value, child) {
                                    return Card(
                                      color: subadminhomecontainer,
                                      child: InkWell(
                                        onTap: ()
                                        {
                                          //value.get_CareHome_Details();
                                          value.find_UserCareHomes(Id);
                                          callNext(context, Sub_AdminCareHomeList(userid: Id,));

                                        },
                                        child: Container(
                                          height: 145,
                                          width: 140,
                                          padding: EdgeInsets.only(top : 22),
                                          child: Column(
                                            children: [
                                              Image.asset("assets/icons/Sadmincarehomeprofile.png",scale: .9,),
                                              Page_content("Care Home", 20, FontWeight.bold, Colors.black)
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                ),
                              ],
                            ),
                            sizebox(),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  //top: 10,
                    child: Image.asset("assets/Logo/Homely_logo.png",scale: 2.5,)),
              ]),
        )
    );
  }
}
