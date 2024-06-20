import 'package:flutter/material.dart';
import 'package:homely/Provider/Main_Provider/MainProvider.dart';
import 'package:provider/provider.dart';

import '../../Constants/Call_Functions.dart';
import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import 'MainAdminProfile.dart';

class MAadminList extends StatelessWidget {
  const MAadminList({super.key});

  @override
  Widget build(BuildContext context) {

    MainProvider provider = Provider.of(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: Appbar_MainAdmin("Admins", context),
        endDrawerEnableOpenDragGesture: true,
        //drawerScrimColor: white,
        //endDrawer: Drawerlist(context),

        floatingActionButton: FloatingActionButton(
          elevation: 10,
          backgroundColor: adminblue,
          onPressed: (){
            callNext(context, MainAdminProfile(ID: "",from: "new",));
            //provider.cleardata();
            //Navigator.push(context, MaterialPageRoute(builder: (context) => AddDetails(ID: "", todo: 'New',)));
          },
          //tooltip: 'Increment Press',
          child: const Icon(Icons.add,color: Colors.white,size: 30,),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Consumer<MainProvider>(
                  builder: (context1, value, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                        itemCount: value.Adminlist.length,
                        itemBuilder: (BuildContext context, int index)
                        {
                          return Card(
                            color: textformcolor,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0, bottom: 15),
                              child: Consumer<MainProvider>(
                                builder: (context, value, child) {
                                  return Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            IconButton(alignment: Alignment.bottomRight,visualDensity: VisualDensity(vertical: -4),
                                                onPressed: ()
                                                {
                                                  callNext(context, MainAdminProfile(ID: value.Adminlist[index].id,from: "edit",));},
                                                icon: Icon(Icons.edit_square,size: 20,color: adminblue,),padding: EdgeInsets.zero),
                                            IconButton(alignment: Alignment.bottomLeft,visualDensity: VisualDensity(vertical: -4),
                                                onPressed: ()
                                                {
                                                  //provider.Deletealert(context,details.Studentlist[index].id);
                                                },
                                                icon: Icon(Icons.delete, color: Colors.red,size: 20,),padding: EdgeInsets.zero),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Container(
                                          //   //color: mainAdminfldclr,
                                          //   padding: EdgeInsets.all(0),
                                          //   margin: EdgeInsets.zero,
                                          //   width: 100,
                                          //   height: 100,
                                          //   decoration: BoxDecoration(
                                          //       border: Border.all(color: txtfrmbordercolor),
                                          //       color: mainAdminfldclr,
                                          //       image: DecorationImage(image: AssetImage("assets/icons/Usericon.png"))
                                          //   ),),
                                          // SizedBox(width: 20,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Page_content("First Name", 15, FontWeight.w500, black),
                                              Page_content("Email", 15, FontWeight.w500, black),
                                              Page_content("Phone Number", 15, FontWeight.w500, black),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Column(
                                              //crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(":"),
                                                Text(":"),
                                                Text(":"),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Page_content(provider.Adminlist[index].firstname, 15, FontWeight.w500, black),
                                              //Page_content(provider.UserList[index].lastname, 15, FontWeight.w500, black),
                                              Page_content(provider.Adminlist[index].Email, 15, FontWeight.w500, black),
                                              Page_content(provider.Adminlist[index].phone, 15, FontWeight.w500, black),
                                              //Page_content(provider.UserList[index].signup_time, 15, FontWeight.w500, black),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                }
                              ),
                            ),
                          );
                        }
                    );
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
