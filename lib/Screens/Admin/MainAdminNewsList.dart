import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homely/Constants/Call_Functions.dart';
import 'package:homely/Provider/Main_Provider/MainProvider.dart';
import 'package:provider/provider.dart';

import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import 'MainAdminNewsDescription.dart';

class MainAdminNewsList extends StatelessWidget {
  const MainAdminNewsList({super.key});

  @override
  Widget build(BuildContext context) {

    MainProvider provider = Provider.of(context, listen: false);

    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: Appbar_MainAdmin("News", context),
        endDrawerEnableOpenDragGesture: true,
        //drawerScrimColor: white,
        endDrawer: Drawerlist(context),

        floatingActionButton: FloatingActionButton(
          elevation: 10,
          backgroundColor: adminblue,
          onPressed: (){
            provider.clearNewsdata();
            callNext(context, NewDescription_MainAdmin(ID: "",from: "New",));

            //provider.cleardata();
            //Navigator.push(context, MaterialPageRoute(builder: (context) => AddDetails(ID: "", todo: 'New',)));
          },
          //tooltip: 'Increment Press',
          child: const Icon(Icons.add,color: Colors.white,size: 30,),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Column(
              children: [
                Container(
                  child: Consumer<MainProvider>(
                    builder: (context,value,child) {
                      //print(value.Newslist);
                      return ListView.builder(physics:  NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: value.Newslist.length,
                          itemBuilder: (BuildContext context, int index)
                          {
                            //print("hi");
                            //return NewsList_Admin(context,NewDescription_MainAdmin(ID: value.Newslist[index].id,from: "Edit"),value.Newslist[index]);

                            return Card(
                              color: textformcolor,
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text
                                      (value.Newslist[index].headline,
                                      style: GoogleFonts.karma(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(value.Newslist[index].date,
                                          style: GoogleFonts.karma(textStyle: const TextStyle(fontSize: 13,fontWeight: FontWeight.w400)),),
                                        SizedBox(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  onPressed: ()
                                                  {
                                                    value.updateNewsDetails(value.Newslist[index].id);
                                                    callNext(context, NewDescription_MainAdmin(ID: value.Newslist[index].id,from: "Edit"));
                                                    },
                                                  icon: Icon(Icons.edit_square,size: 20,),padding: EdgeInsets.zero),
                                              IconButton(
                                                  onPressed: ()
                                                  {
                                                    provider.DeleteNewsalert(context,"Do you want to delete this news?",value.Newslist[index].id);
                                                  },
                                                  icon: Icon(Icons.delete, color: Colors.red,size: 20,),padding: EdgeInsets.zero),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            );
                          });
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
