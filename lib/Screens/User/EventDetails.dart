import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homely/Constants/Colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Constants/MyWidgets.dart';
import '../../Provider/Main_Provider/MainProvider.dart';
import '../../Provider/Main_Provider/MyProvider.dart';

class Event_Details extends StatelessWidget {
  const Event_Details({super.key});

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<MainProvider>(
                    builder: (Topic_context, value, child) {
                    return Text(value.user_eventmap['event_topic'].toString(),
                      style: GoogleFonts.kavivanar(
                          textStyle: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: maingreen,)),
                    );
                  }
                ),
                sizebox(),
                Container(
                  height: 70,
                  width: width,
                  color: maingreen,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0,top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Page_content("Oct 30 - 31", 18, FontWeight.bold, white),
                        Consumer<MainProvider>(
                            builder: (DURATion_context, value, child) {
                            return Page_content(DateFormat('yMMMd').format(value.user_eventmap["fromdate"].toDate()).toString()+
                                " - "+ DateFormat('yMMMd').format(value.user_eventmap["todate"].toDate()).toString(),
                                16, FontWeight.bold, white);
                          }
                        ),
                        Consumer<MainProvider>(
                            builder: (venue_context, value, child) {
                            return Page_content("Venue: "+value.user_eventmap['venue'].toString(), 16, FontWeight.bold, white);
                          }
                        )
                      ],
                    ),
                  ),
                ),
                sizebox(),
                // Card(
                //   color: userlightblue,
                //   elevation: 3,
                //   child: Padding(
                //     padding: const EdgeInsets.all(15.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Page_content("MONDAY EVENING RECEPTION AND WORKSHOP", 15, FontWeight.bold, maingreen),
                //         Divider(color: maingreen.withOpacity(.25),),
                //         Page_content("Investigations, navigating resident benefits and subsidies, "
                //         "incident reporting, reassessment tips, managing vacancies, admission contracts, "
                //         "scheduling methods, menus, financial management tips and more!! \n"
                //           "Don't miss out!", 15, FontWeight.w500, black),
                //
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  child: Consumer<MainProvider>(
                      builder: (ctx, value, child) {
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: value.EventDaysdetails_list_MP
                                .length,
                            itemBuilder: (BuildContext ctx, int index) {
                              //evnt_date = value.EventDaysdetails_list_MP[index].date.toString();
                              //evnt_date = outputDateFormat.format(value.EventDaysdetails_list_MP[index].date);
                              return Card(
                                color: userlightblue,
                                elevation: 3,
                                child: Container(
                                  //color: textformcolor,
                                  decoration: BoxDecoration(

                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Page_content(value
                                              .EventDaysdetails_list_MP[index]
                                              .date, 15, FontWeight.bold,
                                              maingreen),
                                          Page_content(value
                                              .EventDaysdetails_list_MP[index]
                                              .dayTopic.toUpperCase(), 15,
                                              FontWeight.bold, maingreen),
                                          Divider(
                                            color: maingreen.withOpacity(
                                                .25),),
                                          Page_content(value
                                              .EventDaysdetails_list_MP[index]
                                              .dayDescription, 15,
                                              FontWeight.w500, black),
                                          //SizedBox(height: 10,)


                                        ]
                                    ),
                                  ),
                                ),
                              );
                            }
                        );
                      }
                  ),
                ),
                // Card(
                //   color: userlightblue,
                //   elevation: 3,
                //   child: Padding(
                //     padding: const EdgeInsets.all(15.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Page_content("TUESDAY", 15, FontWeight.bold, maingreen),
                //         Divider(color: maingreen.withOpacity(.25),),
                //         Page_content("Great speakers dealing with topics of serious importance to all owners "
                //             "and operators in these changing times. \n"
                //           "Not a member?\n"
                //           "Contact: Kristy Zavior - secretory@homely.com", 15, FontWeight.w500, black),
                //
                //       ],
                //     ),
                //   ),
                // ),
                sizebox(),
                SizedBox(
                  height: 175,//height/4,
                  width: width,
                  child: Consumer<MainProvider>(
                      builder: (SpeakeRctx, value, child) {
                      return ListView.builder(

                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: value.Speakers.length,
                          itemBuilder: (context,index)
                          {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 120,
                                width: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 120,
                                      width: 100,
                                      //child: Image.asset(speakerimages[index]),
                                      child: value.Speakers[index]
                                          .speaker_photo != "" ?
                                      Image.network(
                                        value.Speakers[index].speaker_photo!,
                                        fit: BoxFit.fill,) :
                                      Image.asset(
                                        "assets/icons/userblack.png",
                                        fit: BoxFit.fill,),
                                    ),
                                    Page_content(value.Speakers[index].name, 13, FontWeight.w500, black),
                                    Page_content(value.Speakers[index].designation, 13, FontWeight.w500, black),
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    }
                  ),
                ),
                sizebox(),
                Page_content("CONFERENCE REGISTRATION:", 15, FontWeight.bold, maingreen),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: width/1.7,
                      child: Page_content("To register for the conference, "
                        "click on this link: ", 14, FontWeight.w500, black),
                    ),
                    InkWell(
                        onTap: (){},
                        child: Page_content("Register Now", 14, FontWeight.bold, Colors.red)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
