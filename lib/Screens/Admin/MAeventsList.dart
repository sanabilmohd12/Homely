import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homely/Provider/Main_Provider/MainProvider.dart';
import 'package:provider/provider.dart';

import '../../Constants/Call_Functions.dart';
import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import 'MAaddEvents.dart';

class MAeventsList extends StatelessWidget {
  const MAeventsList({super.key});

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of(context, listen: false);
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          appBar: Appbar_MainAdmin("Events", context),
          endDrawerEnableOpenDragGesture: true,
          //drawerScrimColor: white,
          endDrawer: Drawerlist(context),

          floatingActionButton: FloatingActionButton(
            elevation: 10,
            backgroundColor: adminblue,
            onPressed: (){
              provider.clearEventdata();
              callNext(context, MAaddEvents(ID: "", from: "New",));

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
                  Page_content("Upcoming Events", 20, FontWeight.bold, black),
                  Divider(color: adminblue,thickness: 1,),
                  Container(
                    child: Consumer<MainProvider>(
                      builder: (context, value, child) {
                        return value.Event_list.isNotEmpty?
                        ListView.builder(physics:  NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: value.Event_list.length,
                            itemBuilder: (BuildContext context, int index)
                            {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                //child: EventList_MainAdmin(context, MAaddEvents()),
                                child: Card(
                                  color: textformcolor,
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Page_content(value.Event_list[index].event_topic, 15, FontWeight.bold, maingreen),
                                        Divider(color: maingreen.withOpacity(.25),),
                                        Page_content("${value.Event_list[index].from_date} - ${value.Event_list[index].to_date}", 12, FontWeight.w500, black),
                                        Page_content("Venue : ${value.Event_list[index].venue}.", 12, FontWeight.w500, black),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                alignment: Alignment.bottomRight,
                                                onPressed: ()
                                                {
                                                  value.updateEvent(value.Event_list[index].event_id);
                                                  //callNext(context, NewDescription_MainAdmin(ID: value.Newslist[index].id,from: "Edit"));
                                                  callNext(context, MAaddEvents(ID: value.Event_list[index].event_id,from: "Edit",));
                                                  },
                                                icon: Icon(Icons.edit_square,size: 20,),
                                                padding: EdgeInsets.zero),
                                            IconButton(
                                                alignment: Alignment.bottomLeft,
                                                onPressed: ()
                                                {
                                                  //print("hellllllllllllllllllllo");
                                                  provider.DeleteEventalert(context, "Do you want to delete this Event?", value.Event_list[index].event_id);
                                                },
                                                icon: Icon(Icons.delete, color: Colors.red,size: 20,),
                                                padding: EdgeInsets.zero),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }):
                        Page_content("No Events", 18, FontWeight.w600, Colors.black);
                      }
                    ),
                  ),
                ],
              ),
            ),
          )
        )
    );
  }
}
