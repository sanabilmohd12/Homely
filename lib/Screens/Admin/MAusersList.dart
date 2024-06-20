import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homely/Constants/Colors.dart';
import 'package:provider/provider.dart';

import '../../Constants/MyWidgets.dart';
import '../../Provider/Main_Provider/MainProvider.dart';

class MAusersList extends StatelessWidget {
  MAusersList({super.key});


  @override
  Widget build(BuildContext context) {

    MainProvider provider = Provider.of(context, listen: false);
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: Appbar_MainAdmin("Users", context),
        endDrawerEnableOpenDragGesture: true,
        //drawerScrimColor: white,
        endDrawer: Drawerlist(context),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Page_content("Registered Users", 15, FontWeight.bold, black),
                const Divider(color: adminblue,thickness: 1,),
                SizedBox(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: provider.UserList.length,
                      itemBuilder: (context,index)
                      {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Card(
                            elevation: 3,
                            child: Container(

                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: MA_homebarcolor1,),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20,top: 15, bottom: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Page_content("First Name", 15, FontWeight.w500, black),
                                        Page_content("Last Name", 15, FontWeight.w500, black),
                                        Page_content("Email", 15, FontWeight.w500, black),
                                        Page_content("Phone Number", 15, FontWeight.w500, black),
                                        Page_content("Signup Time", 15, FontWeight.w500, black),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Column(
                                        //crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(":"),
                                          Text(":"),
                                          Text(":"),
                                          Text(":"),
                                          Text(":"),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Page_content(provider.UserList[index].firstname, 15, FontWeight.w500, black),
                                        Page_content(provider.UserList[index].lastname, 15, FontWeight.w500, black),
                                        Page_content(provider.UserList[index].Email, 15, FontWeight.w500, black),
                                        Page_content(provider.UserList[index].phone, 15, FontWeight.w500, black),
                                        Page_content(provider.UserList[index].signup_time, 15, FontWeight.w500, black),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            // child: Row(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Container(
                            //       //color: Colors.blueGrey,
                            //       //height: 55,
                            //       width: 230,
                            //
                            //       margin: const EdgeInsets.only(left: 20,top: 15, bottom: 15),
                            //       alignment: Alignment.center,
                            //       child: const Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Row(
                            //             children: [
                            //               Text("First Name        :   "),
                            //               //Text(details.Studentlist[index].name),
                            //             ],
                            //           ),
                            //           Row(
                            //             children: [
                            //               Text("Last Name         :   "),
                            //               //Text(details.Studentlist[index].name),
                            //             ],
                            //           ),
                            //           Row(
                            //             children: [
                            //               Text("Email  :   "),
                            //               //Text(details.Studentlist[index].name),
                            //             ],
                            //           ),
                            //           Row(
                            //             children: [
                            //               Text("Phone Number :   "),
                            //               //Text(details.Studentlist[index].phone),
                            //             ],
                            //           ),
                            //           Row(
                            //             children: [
                            //               Text("Login Time  :   "),
                            //               //Text(details.Studentlist[index].name),
                            //             ],
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ),
                        );
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
