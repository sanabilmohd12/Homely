import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homely/Constants/Call_Functions.dart';
import 'package:provider/provider.dart';

import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import '../../Constants/Residences_Details.dart';
import '../../Provider/Main_Provider/SubAdmin_Provider.dart';
import 'MAresidenceRequestDetails.dart';

class MAresidenceRequestList extends StatelessWidget {
  const MAresidenceRequestList({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    SubAdmin_Provider sub_provider = Provider.of(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: Appbar_MainAdmin("Residence Requests", context),
        // endDrawerEnableOpenDragGesture: true,
        // //drawerScrimColor: white,
        // endDrawer: Drawerlist(context),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                General_Search(),
                sizebox(),
                sizebox(),
                SizedBox(
                  //height: height/1.8,
                  width: width,
                  child: Consumer<SubAdmin_Provider>(
                      builder: (context1, value, child) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: value.CareHome_RequestList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            //mainAxisSpacing: 20,
                            mainAxisExtent: 185
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          print(value.CareHome_RequestList.length);
                          return InkWell(
                            onTap: ()
                            {
                              sub_provider.updateCareHomeDetails(value.CareHome_RequestList[index].id, "Request");
                              callNext(context, MAresidenceRequestDetails( homeID: value.CareHome_RequestList[index].id,));
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 140,
                                  width: 140,
                                  //alignment: Alignment.center,

                                  //color: Colors.blueGrey,
                                  decoration: BoxDecoration(border: Border.all(color: Colors.grey),

                                    //color: Color(0xff35384a),
                                    //gradient: LinearGradient(colors: Color(0xffCDCDCD)),//[Color(0xffFFFFFF2B), Color(0xffFFFFFF00)]),
                                    borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                          //image: AssetImage(Home_pics[index]),fit: BoxFit.fill
                                        image: value.CareHome_RequestList[index].homeImage_list.isEmpty?
                                        AssetImage("assets/icons/House.png") :
                                            NetworkImage(value.CareHome_RequestList[index].homeImage_list[1]) as ImageProvider,
                                        fit: BoxFit.fill,
                                      )
                                  ),
                                  // child: value.CareHome_RequestList[index].homeImage_list.isNotEmpty?
                                  // Image.network(value.CareHome_RequestList[index].homeImage_list[1],fit: BoxFit.fill,):
                                  // Image.asset("assets/icons/House.png",color: Colors.grey,scale: 5),
                                  // child: Container(
                                  //   height: 40,
                                  //   width: 40,
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(25),
                                  //     color: textformcolor
                                  //   ),
                                  //   child: IconButton(
                                  //       onPressed: ()
                                  //       {
                                  //         sub_provider.updateCareHomeDetails(value.CareHome_RequestList[index].id, "Request");
                                  //         callNext(context, MAresidenceRequestDetails());
                                  //         },
                                  //       icon: Icon(Icons.remove_red_eye,color: adminblue,)),
                                  // ),
                                ),
                                Page_content(value.CareHome_RequestList[index].carehomename, 15, FontWeight.bold, maingreen),
                                //Page_content("25-6-2023", 15, FontWeight.bold, black),
                              ],
                            ),
                          );
                        },
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
