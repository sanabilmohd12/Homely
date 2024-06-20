import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homely/Constants/Colors.dart';
import 'package:provider/provider.dart';

import '../../Constants/Board_Details.dart';
import '../../Constants/Call_Functions.dart';
import '../../Constants/MyWidgets.dart';
import '../../Constants/sponsor_details.dart';
import '../../Provider/Main_Provider/MainProvider.dart';
import 'BoardMemberDetails.dart';
import 'CareHome_details.dart';

class BoardMembers extends StatelessWidget {
  const BoardMembers({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: Appbar_user("Board Of Directors", context),
        endDrawerEnableOpenDragGesture: true,
        //drawerScrimColor: white,
        endDrawer: Drawerlist(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                SizedBox(
                  width: width,
                  child: Consumer<MainProvider>(
                      builder: (BM_cntx, value, child) {
                      return GridView.builder(physics:NeverScrollableScrollPhysics(),

                        shrinkWrap: true,
                        itemCount: value.BM_list.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            //mainAxisSpacing: 2000
                            mainAxisExtent: 170
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: (){
                              value.update_BMDetails(value.BM_list[index].id);
                              callNext(context, BoardMemberDetails());
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  alignment: Alignment.bottomCenter,

                                  //color: Colors.blueGrey,
                                  decoration: BoxDecoration(//border: Border.all(color: Color(0xff4c5463)),

                                    //color: Color(0xff35384a),
                                    //gradient: LinearGradient(colors: Color(0xffCDCDCD)),//[Color(0xffFFFFFF2B), Color(0xffFFFFFF00)]),
                                    //borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                          image: value.BM_list[index].BMphoto != "" ? NetworkImage(value.BM_list[index].BMphoto) :
                                          AssetImage("assets/icons/userblack.png") as ImageProvider ,
                                          fit: BoxFit.fill

                                      )
                                  ),
                                  //child: Text(Home_names[index],style: TextStyle(color: Colors.white),),
                                ),
                                Container(
                                  height: 50,
                                  width: 102,
                                  decoration: BoxDecoration(border: Border.all(color: Color(0xffD1CDCD))),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 25,
                                      //width: 100,
                                      alignment: Alignment.center,
                                      color: maingreen.withOpacity(0.75),
                                        child: Page_content(value.BM_list[index].name.toUpperCase(), 10, FontWeight.bold, white),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Page_content(value.BM_list[index].title.toUpperCase(), 10, FontWeight.bold, maingreen),
                                      ),
                                    ],
                                  ),
                                )

                              ],
                            ),
                          );
                        },
                      );
                    }
                  ),
                ),
                sizebox(),
                Page_content("OUR SPONSORS", 20, FontWeight.bold, maingreen),
                Divider(color: maingreen,thickness: 1,),
                SizedBox(
                  height: 100,
                  width: width,
                  child: Consumer<MainProvider>(
                      builder: (sponsorcontext, value, child) {
                        //print("${value.Sponsor_list.length} ZXZXZX");
                      return ListView.builder(

                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: value.Sponsor_list.length,
                          itemBuilder: (context,index)
                          {

                            return InkWell(
                              onTap: (){},
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: value.Sponsor_list[index].sponsor_photo != "" ?
                                Image.network(value.Sponsor_list[index].sponsor_photo,fit: BoxFit.fill,) :
                                Image.asset("assets/icons/userblack.png"),
                              ),
                            );
                          }
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
