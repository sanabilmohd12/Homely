import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homely/Constants/Colors.dart';
import 'package:homely/Constants/Residences_Details.dart';
import 'package:provider/provider.dart';

import '../../Constants/MyWidgets.dart';
import '../../Provider/Main_Provider/MyProvider.dart';

class CareHomeDetails extends StatelessWidget {
  const CareHomeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: Appbar_user("Residences", context),
        endDrawerEnableOpenDragGesture: true,
        //drawerScrimColor: white,
        endDrawer: Drawerlist( context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<MyProvider>(
                    builder: (context, value, child){
                      return CarouselSlider(//disableGesture: false,
                          items: home_images.map((String homeimage){
                            return Builder(
                                builder: (BuildContext context){
                                  return Container(
                                    width: width,
                                    //margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: Image.asset(homeimage,fit: BoxFit.fitWidth),
                                  );
                                });
                          }).toList(),
                          options: CarouselOptions(
                            height: 150,
                            enlargeCenterPage: true,
                            autoPlay: false,
                            onPageChanged: (index, reason){
                              value.changeindex(index);
                            },
                            enableInfiniteScroll: false,
                            //viewportFraction: .9,
                            //scrollPhysics: BouncingScrollPhysics(),
                          ));
                    }
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                    home_images.map((String homeimage){
                      int index = home_images.indexOf(homeimage);
                      return Consumer<MyProvider>(
                          builder: (context,value, child){
                            return Container(
                              width: 8,
                              height: 8,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: value.currentIndex == index ? maingreen : Colors.grey
                              ),
                            );
                          });
                    }).toList(),

                ),
                sizebox(),
                //DotsIndicator(dotsCount: 3,),
                Page_content("GRANDNEST CARE HOME", 20, FontWeight.bold, maingreen),
                Row(
                  children: [
                    Icon(Icons.location_pin,color: Colors.red,),
                    Page_content("560 Front Mountain Road,\n"
                      "Moncton NB E1G 3H3", 15, FontWeight.w600, black),

                  ],
                ),
                Divider(color: maingreen.withOpacity(.2),thickness: 2,),
                //sizebox(),
                Card(
                  elevation: 10,
                  color: userlightblue,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Page_content("Description", 15, FontWeight.bold, maingreen),
                        Divider(color: maingreen,thickness: 2,),
                        Page_content("At times, aged people are forced to stay away from their homes. "
                            "In such cases, old age homes can be of great help. These homes are managed "
                            "by government and non - governmental organisations. The homes make sure that the"
                          "aged get the basic care and facilities needed during this"
                          "fragile phase of their lives. In addition to healthy and"
                          "hygienic meals, the homes also conduct a lot of activities so"
                          "that they don't get lonely. They also have a registered nurse"
                          "on duty round the clock to handle emergencies.", 13, FontWeight.w600, black)
                      ],
                    ),
                  ),
                ),
                sizebox(),
                Card(
                  elevation: 10,
                  color: userlightblue,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Page_content("Capacity", 15, FontWeight.bold, maingreen),
                        Divider(color: maingreen,thickness: 2,),
                        Page_content("Licensed Beds: 13 \nCurrent Vacancy: 1", 13, FontWeight.w600, black)
                      ],
                    ),
                  ),
                ),
                sizebox(),
                Card(
                  elevation: 10,
                  color: userlightblue,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Page_content("Details", 15, FontWeight.bold, maingreen),
                        Divider(color: maingreen,thickness: 2,),
                        Page_content("Phone Number : 9846578963 \n"
                          "Contact Name : Akhil Raj \n"
                          "Level of Care : B2 \n"
                          "Email : akhilraj@hillview.com \n"
                          "Facility : Elderly", 13, FontWeight.w600, black)
                      ],
                    ),
                  ),
                ),
                sizebox(),
                Card(
                  elevation: 10,
                  color: userlightblue,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Page_content("Features Of Services", 15, FontWeight.bold, maingreen),
                        Divider(color: maingreen,thickness: 2,),
                        SizedBox(
                          //height: 500,
                          width: width,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.close,color: Colors.red,),
                                  Flexible(child: Page_content("Do you provide outings for your residents?", 13, FontWeight.w600, black)),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.done,color: Colors.green,),
                                  Flexible(child: Page_content("Do staff have training in Dementia Care?", 13, FontWeight.w600, black)),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.done,color: Colors.green,),
                                  Flexible(child: Page_content("Do staff have training in Diabetes and insulin management?", 13, FontWeight.w600, black)),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.done,color: Colors.green,),
                                  Flexible(child: Page_content("Do you provide transportation to and from medical visits?", 13, FontWeight.w600, black)),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                sizebox(),
                Card(
                  elevation: 10,
                  color: userlightblue,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Page_content("What Our Customers Say", 15, FontWeight.bold, maingreen),
                        Divider(color: maingreen,thickness: 2,),
                        //Page_content("Licensed Beds: 13 \nCurrent Vacancy: 1", 13, FontWeight.w600, black)
                        Image.asset("assets/reviews/home1review.png")

                      ],
                    ),
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
