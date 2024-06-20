import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homely/Constants/Colors.dart';
import 'package:provider/provider.dart';

import '../../Constants/Board_Details.dart';
import '../../Constants/Call_Functions.dart';
import '../../Constants/MyWidgets.dart';
import '../../Provider/Main_Provider/MainProvider.dart';
import '../User/BoardMemberDetails.dart';
import 'MainAdminBoardMmbrDetails.dart';

class MainAdminBoardMmbr extends StatelessWidget {
  const MainAdminBoardMmbr({super.key});

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of(context, listen: false);
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: Appbar_MainAdmin("Board Members", context),
        endDrawerEnableOpenDragGesture: true,
        //drawerScrimColor: white,
        endDrawer: Drawerlist(context),

        floatingActionButton: FloatingActionButton(
          elevation: 10,
          backgroundColor: adminblue,
          onPressed: (){
            provider.clear_BMdata();
            callNext(context, MainAdminBoardMmbrDetails(ID: "", from: "New",));

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
                              callNext(context, MainAdminBoardMmbrDetails(ID: value.BM_list[index].id,from: 'Edit',));
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  alignment: Alignment.bottomRight,
                                  decoration: BoxDecoration(border: Border.all(color: Color(0xff4c5463)),
                                    //color: Color(0xff35384a),
                                      image: DecorationImage(
                                        image: value.BM_list[index].BMphoto != "" ? NetworkImage(value.BM_list[index].BMphoto) :
                                        AssetImage("assets/icons/userblack.png") as ImageProvider ,
                                          fit: BoxFit.fill
                                          // image: value.BM_fileimg!=null ?
                                          // FileImage(value.BM_fileimg!):
                                          // value.BM_Image_url!=""? NetworkImage(value.BM_Image_url) :
                                          // AssetImage("assets/icons/Usericon.png") as ImageProvider ,
                                          //fit: BoxFit.fill
                                      )
                                  ),
                                  child: InkWell(
                                    onTap: ()
                                    {
                                      provider.Delete_BMalert(context,"Do you want to delete this member?",value.BM_list[index].id);
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      height: 30,
                                      width: 30,
                                      child: Icon(Icons.delete,color: Colors.red,),
                                    ),
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
                                        //width: 102,
                                        alignment: Alignment.center,
                                        color: adminblue.withOpacity(0.75),
                                        child: Page_content(value.BM_list[index].name.toUpperCase(), 10, FontWeight.bold, white),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Page_content(value.BM_list[index].title.toUpperCase(), 10, FontWeight.bold, adminblue),
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
              ],
            ),
          ),
        ),


      ),
    );
  }
}
