import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homely/Provider/Main_Provider/SubAdmin_Provider.dart';
import 'package:provider/provider.dart';

import '../../Constants/Call_Functions.dart';
import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import '../../Constants/Residences_Details.dart';
import '../User/CareHome_details.dart';

class MAresidences extends StatelessWidget {
  const MAresidences({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: Appbar_MainAdmin("Residences", context),
        endDrawerEnableOpenDragGesture: true,
        //drawerScrimColor: white,
        endDrawer: Drawerlist(context),

        // floatingActionButton: FloatingActionButton(
        //   elevation: 10,
        //   backgroundColor: adminblue,
        //   onPressed: (){
        //     //callNext(context, MainAdminProfile());
        //
        //     //provider.cleardata();
        //     //Navigator.push(context, MaterialPageRoute(builder: (context) => AddDetails(ID: "", todo: 'New',)));
        //   },
        //   //tooltip: 'Increment Press',
        //   child: const Icon(Icons.add,color: Colors.white,size: 30,),
        // ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                General_Search(),
                sizebox(),
                SizedBox(
                  //height: height/1.8,
                  width: width,
                  child: Consumer<SubAdmin_Provider>(
                      builder: (context1, value, child) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: value.User_CareHomeList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          //mainAxisSpacing: 2000
                          mainAxisExtent: 170),
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(children: [
                          GestureDetector(
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
                                Page_content(Home_names[index], 15,
                                    FontWeight.bold, maingreen)
                              ],
                            ),
                          ),
                          Positioned(
                              top: 0,
                              right: 15,
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  color:
                                      textformcolor, //alignment: Alignment.center,
                                  child: IconButton(
                                    visualDensity: VisualDensity(
                                        vertical: -4, horizontal: -4),
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    padding: EdgeInsets.only(bottom: 5),
                                  )))
                        ]);
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// NetworkImage(
// value.CareHome_ApprovedList[index].homeImage_list[1]),fit: BoxFit.fill)
