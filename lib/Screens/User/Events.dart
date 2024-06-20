import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homely/Provider/Main_Provider/MainProvider.dart';
import 'package:homely/Screens/User/EventDetails.dart';
import 'package:provider/provider.dart';

import '../../Constants/Call_Functions.dart';
import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';

class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: Appbar_user("Events", context),
        endDrawerEnableOpenDragGesture: true,
        //drawerScrimColor: white,
        endDrawer: Drawerlist(context),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Page_content("Upcoming Events", 20, FontWeight.bold, black),
                Divider(color: adminblue,thickness: 1,),
                Container(
                  child: Consumer<MainProvider>(
                      builder: (event_context, value, child) {
                      return value.Event_list.isNotEmpty ?
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
                                      GestureDetector(
                                        onTap: ()
                                        {
                                          provider.updateEvent(value.Event_list[index].event_id);
                                          callNext(context, Event_Details());
                                        },
                                          child: Page_content(value.Event_list[index].event_topic, 15, FontWeight.bold, maingreen)
                                      ),
                                      Divider(color: maingreen.withOpacity(.25),),
                                      Page_content("${value.Event_list[index].from_date} - ${value.Event_list[index].to_date}", 12, FontWeight.w500, black),
                                      Page_content("Venue : ${value.Event_list[index].venue}.", 12, FontWeight.w500, black),

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
        ),
      ),
    );
  }
}
