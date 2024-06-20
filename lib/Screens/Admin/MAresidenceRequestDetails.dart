import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Constants/CarehomeFacilityList.dart';
import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import '../../Constants/Residences_Details.dart';
import '../../Provider/Main_Provider/MainProvider.dart';
import '../../Provider/Main_Provider/MyProvider.dart';
import '../../Provider/Main_Provider/SubAdmin_Provider.dart';

class MAresidenceRequestDetails extends StatelessWidget {
  String homeID;
  MAresidenceRequestDetails({super.key, required this.homeID});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    SubAdmin_Provider sub_provider = Provider.of(context, listen: false);
    MainProvider provider = Provider.of(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: Appbar_MainAdmin("Residences Request", context),
        // endDrawerEnableOpenDragGesture: true,
        // //drawerScrimColor: white,
        // endDrawer: Drawerlist(context),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<MyProvider>(
                    builder: (context, value, child){
                      return CarouselSlider(//disableGesture: false,
                          //items: home_images.map((String homeimage){
                          items: sub_provider.image_list.map((String homeimage){
                            print(homeimage);
                            return Builder(
                                builder: (BuildContext context){
                                  return Container(
                                    width: width,
                                    //margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: Image.network(homeimage,fit: BoxFit.fill),
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
                  sub_provider.image_list.map((String homeimage){
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
                Consumer<SubAdmin_Provider>(
                    builder: (context1, value, child) {
                    return Page_content(value.MA_carehomemap["homename"].toString().toUpperCase(), 20, FontWeight.bold, maingreen);
                  }
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_pin,color: Colors.red,),
                    Consumer<SubAdmin_Provider>(
                        builder: (context2, value, child) {
                        return Page_content('${value.MA_carehomemap["address"]} \n${value.MA_carehomemap["district"]}, ${value.MA_carehomemap["pincode"]}',
                            15, FontWeight.w600, black);
                      }
                    ),

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
                        Consumer<SubAdmin_Provider>(
                            builder: (context3, value, child) {
                            return Page_content(value.MA_carehomemap["description"], 13, FontWeight.w600, black);
                          }
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
                    child: Consumer<SubAdmin_Provider>(
                        builder: (context4, value, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Page_content("Capacity", 15, FontWeight.bold, maingreen),
                            Divider(color: maingreen,thickness: 2,),
                            Page_content("Licensed Beds: ${value.MA_carehomemap['licensed_bed']}", 13, FontWeight.w600, black),
                            Page_content("Current Vacancy: ${value.MA_carehomemap['available_bed']}", 13, FontWeight.w600, black),
                            Page_content("Level of Care: ${value.MA_carehomemap['care_level']}", 13, FontWeight.w600, black),
                            Page_content("Facility: ${value.MA_carehomemap['facilities']}", 13, FontWeight.w600, black),
                          ],
                        );
                      }
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
                        Page_content("Contact Details", 15, FontWeight.bold, maingreen),
                        Divider(color: maingreen,thickness: 2,),
                        Consumer<SubAdmin_Provider>(
                            builder: (context5, value, child) {
                            return Page_content("Contact Name : ${value.MA_carehomemap['contact_person'].toString().toUpperCase()} \n"
                                "Phone Number :  ${value.MA_carehomemap['phone']}\n"
                                "Email :  ${value.MA_carehomemap['email']}\n"
                                "Web : ${value.MA_carehomemap['web']}", 13, FontWeight.w600, black);
                          }
                        ),
                        Row(
                          children: [
                            InkWell(
                                onTap: (){},
                                child: Image.asset("assets/icons/Facebook.png",scale: 4,)
                            ),
                            SizedBox(width: 10,),
                            InkWell(
                                onTap: (){},
                                child: Image.asset("assets/icons/Instagram.png",scale: 4,)
                            ),
                            SizedBox(width: 10,),
                            InkWell(
                                onTap: (){},
                                child: Image.asset("assets/icons/Twitter.png",scale: 4,)
                            ),

                            //Icon(Icons.facebook, color: CupertinoColors.activeBlue,),
                            // IconButton(
                            //   //padding: EdgeInsets.,
                            //     onPressed: (){
                            //       //provider.launchUrl(value.user_BMmap['facebook'].toString());
                            //     },
                            //     icon: Image.asset("assets/icons/Facebook.png",scale: 4,),
                            //   //iconSize: 50,
                            //
                            // ),
                            // IconButton(
                            //   padding: EdgeInsets.zero,
                            //   onPressed: (){
                            //     //provider.launchUrl(value.user_BMmap['linkedin'].toString());
                            //   },
                            //   icon: Image.asset("assets/icons/Linkedin.png",scale: 4,),
                            //   //iconSize: 50,
                            // ),
                          ],
                        ),
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
                          height: 500,
                          width: width,
                          child: Consumer<SubAdmin_Provider>(
                              builder: (dropcontext, value, child) {
                                return ListView.builder(shrinkWrap: true,
                                    itemCount: facilityList.length,
                                    itemBuilder: (BuildContext context, int index)
                                    {
                                      print(facilityList[index].isChecked);
                                      print(facilityList.length);
                                      return Row(
                                        children: [
                                          //facilityList[index].isChecked,
                                          facilityList[index].isChecked == true ?
                                              Icon(Icons.check,color: Colors.green,): Icon(Icons.close, color: Colors.red,) ,
                                          Expanded(child: Page_content(facilityList[index].facilities, 14, FontWeight.w500, black))
                                        ],
                                      );
                                    });
                              }
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                sizebox(),
                // Card(
                //   elevation: 10,
                //   color: userlightblue,
                //   child: Padding(
                //     padding: const EdgeInsets.all(15.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Page_content("What Our Customers Say", 15, FontWeight.bold, maingreen),
                //         Divider(color: maingreen,thickness: 2,),
                //         //Page_content("Licensed Beds: 13 \nCurrent Vacancy: 1", 13, FontWeight.w600, black)
                //         Image.asset("assets/reviews/home1review.png")
                //
                //       ],
                //     ),
                //   ),
                // ),
                sizebox(),
                // Row(
                //   children: [
                //     Page_content("Payment Satus : Not Done", 14, FontWeight.bold, Colors.black),
                //     TextButton(
                //         onPressed: (){},
                //         child: Text("Request To Pay",
                //           style: GoogleFonts.karma(textStyle:
                //           const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: linkcolor,
                //               decoration: TextDecoration.underline,decorationColor: linkcolor)),
                //         )
                //     ),
                //   ],
                // ),
                Form(key: _formKey,
                  child: Consumer<MainProvider>(
                    builder: (context, value, child) {

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            onPressed: ()
                            {
                              if(_formKey.currentState!.validate()){
                                provider.approve_residences(context,homeID,"ACCEPTED");
                                sub_provider.get_CareHome_Details();
                              }


                            },
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            color: adminblue,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Page_content("Accept", 18, FontWeight.bold, Colors.white),
                            ),
                          ),
                          SizedBox(width: 10,),
                          MaterialButton(
                            onPressed: ()
                            {
                              provider.approve_residences(context,homeID,"REJECTED");
                            },
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            color: adminblue,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Page_content("Reject", 18, FontWeight.bold, Colors.white),
                            ),
                          ),
                        ],
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
