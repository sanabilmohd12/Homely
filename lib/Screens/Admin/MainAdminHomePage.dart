import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homely/Constants/Call_Functions.dart';
import 'package:homely/Provider/Main_Provider/SubAdmin_Provider.dart';
import 'package:provider/provider.dart';

import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import '../../Provider/Main_Provider/MainProvider.dart';
import 'MAaddSpeaker.dart';
import 'MAadminList.dart';
import 'MAeventsList.dart';
import 'MAresidenceRequestList.dart';
import 'MAresidences.dart';
import 'MAusersList.dart';
import 'MainAdminBoardMmbr.dart';
import 'MainAdminIntroPage.dart';
import 'MainAdminNewsList.dart';
import 'MainAdminProfile.dart';
import 'MainAdminSponsorList.dart';

class MainAdminHomePage extends StatelessWidget {
  const MainAdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of(context, listen: false);
    SubAdmin_Provider sub_provider = Provider.of(context, listen: false);
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Appbar_container(width, adminblue, homelycolor, slogancolor),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //AdminhomeContainer("PROFILE",context, MainAdminProfile(ID: "", from: "edit",)),
                          //AdminhomeContainer("INTRO",context,MainAdminIntroPage()),
                        ],
                      ),
                      sizebox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              provider.getNewsDetails();
                              callNext(context, MainAdminNewsList());
                            },
                              child: AdminhomeContainer("NEWS",context)),
                          InkWell(
                            onTap: ()
                            {
                              provider.get_BMDetails();
                              callNext(context, MainAdminBoardMmbr());
                            },
                              child: AdminhomeContainer("BOARD", context)),
                        ],
                      ),
                       sizebox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: ()
                              {
                                sub_provider.find_ApprovedCareHomes();
                                callNext(context, MAresidences());
                              },
                              child: AdminhomeContainer("RESIDENCES",context)),
                          InkWell(
                              onTap: ()
                              {
                                sub_provider.find_CareHomesRequests();
                                callNext(context, MAresidenceRequestList());
                              },
                              child: AdminhomeContainer("REQUESTS", context)),
                          //AdminhomeContainer("RESIDENCES", context, MAresidences()),
                          //AdminhomeContainer("REQUESTS",context, MAresidenceRequestList()),
                        ],
                      ),
                      sizebox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                             onTap: ()
                             {
                               provider.getEventDetails();
                               provider.get_SpeakerDetails();
                               callNext(context, MAeventsList());
                             },
                              child: AdminhomeContainer("EVENTS", context)
                          ),  //MAeventsList()
                          //AdminhomeContainer("SPONSORS",context,MainAdminSponsorList()),
                          InkWell(
                              onTap: ()
                              {
                                provider.get_SponsorDetails();
                                callNext(context, MainAdminSponsorList());
                              },
                              child: AdminhomeContainer("SPONSORS", context)
                          ),
                        ],
                      ),
                      sizebox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: ()
                              {
                                provider.getUser();
                                callNext(context, MAusersList());
                              },
                              child: AdminhomeContainer("USERS", context)
                          ),
                          InkWell(
                            onTap: ()
                            {
                              provider.getMainAdminDetails();
                              callNext(context, MAadminList());
                            },
                              child: AdminhomeContainer("ADMIN", context )
                          ),
                        ],
                      ),
                      sizebox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                               onTap: ()
                               {
                                 provider.get_SpeakerDetails();
                                 callNext(context, AddSpeakers());
                               },
                              child: AdminhomeContainer("SPEAKERS", context)
                          )
                        ],
                      )


                    ],
                  ),
                )
              ],
            ),
            Positioned(
              //top: 10,
                child: Image.asset("assets/Logo/Homely_logo.png",scale: 2.5,)),
          ]
        ),
      ),
    );
  }
}
