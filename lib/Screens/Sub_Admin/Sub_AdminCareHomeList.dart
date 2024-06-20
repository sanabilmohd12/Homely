import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constants/Call_Functions.dart';
import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import '../../Provider/Main_Provider/SubAdmin_Provider.dart';
import '../Admin/MainAdminNewsDescription.dart';
import 'SubAdminRegPage1.dart';

class Sub_AdminCareHomeList extends StatelessWidget {
  String userid;
  Sub_AdminCareHomeList({super.key, required this.userid});

  @override
  Widget build(BuildContext context) {
    SubAdmin_Provider sub_provider = Provider.of(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: subadminBG,
        appBar: Appbar_SubAdmin("Care Home","", context),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Page_content("Care Home", 20, FontWeight.bold, black),
                Divider(color: maingreen,thickness: 1,),
                Container(

                  child: Consumer<SubAdmin_Provider>(
                      builder: (context8, value, child) {
                      return value.User_CareHomeList.isNotEmpty?
                        ListView.builder(
                        physics:  NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: value.User_CareHomeList.length,
                        itemBuilder: (BuildContext context, int index)
                        {
                          return Card(
                            color: textformcolor,
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0,left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Page_content(value.User_CareHomeList[index].carehomename.toUpperCase(), 16, FontWeight.bold, Colors.black),
                                  Page_content(value.User_CareHomeList[index].district, 14, FontWeight.bold, Colors.black),
                                  Consumer<SubAdmin_Provider>(
                                      builder: (context9, value, child) {
                                        return Row(
                                          children: [
                                            Page_content("Approval Status : ", 15, FontWeight.bold, Colors.black),
                                            Page_content(value.User_CareHomeList[index].approval_status, 15, FontWeight.bold,
                                                value.User_CareHomeList[index].approval_status == "APPROVED" ? maingreen :
                                                value.User_CareHomeList[index].approval_status == "REQUESTED" ? Colors.blue : Colors.red),
                                          ],
                                        );
                                      }
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [

                                      Consumer<SubAdmin_Provider>(
                                          builder: (context8, value, child) {
                                          return IconButton(
                                              onPressed: ()
                                              {
                                                sub_provider.clearCareHomedata();
                                                if(value.User_CareHomeList[index].approval_status != "REQUESTED")
                                                {
                                                  value.updateCareHomeDetails(value.User_CareHomeList[index].id, "Edit");
                                                  callNext(context, SubAdminRegPage1(ID: value.User_CareHomeList[index].id, from: "Edit", userID: userid,));
                                                }
                                                else
                                                  {
                                                    nonEditable_alert(context);
                                                  }
                                              },
                                              icon: Icon(Icons.edit_square,size: 20,
                                                  color: value.User_CareHomeList[index].approval_status == "REQUESTED" ? Colors.grey:Colors.black),
                                              padding: EdgeInsets.zero);
                                        }
                                      ),
                                      IconButton(
                                          onPressed: ()
                                          {
                                            value.Delete_CareHomeAlert(context,"Do you want to delete this?",value.User_CareHomeList[index].id,userid);
                                            value.Delete_CareHomeAlert(context,"Do you want to delete this?",value.CareHome_RequestList[index].id,userid);
                                            //provider.DeleteNewsalert(context,"Do you want to delete this news?",value.Newslist[index].id);
                                          },
                                          icon: Icon(Icons.delete, color: Colors.red,size: 20,),padding: EdgeInsets.zero),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ):
                      Page_content("No Care home to show", 18, FontWeight.w600, Colors.black);
                    }
                  ),
        ),
              ],
            ),
          ),
      ),
    ));
  }
}
