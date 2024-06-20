import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homely/Provider/Main_Provider/MainProvider.dart';
import 'package:provider/provider.dart';

import '../../Constants/Call_Functions.dart';
import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import '../../Provider/Login_Provider/LoginProvider.dart';
import '../../Provider/Main_Provider/MyProvider.dart';
import '../../Provider/Main_Provider/SubAdmin_Provider.dart';
import '../../Screens/Admin/MainAdminHomePage.dart';
import 'Home_Residences.dart';
import 'Login.dart';
import 'news.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {

    LoginProvider LOGINprovider = Provider.of(context, listen: false);
    FirebaseAuth auth = FirebaseAuth.instance;
    var loginUser = auth.currentUser;

    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          // appBar:
          // AppBar(
          //   title: Logo_Text(30, 18, homelycolor, slogancolor),
          //   //backgroundColor: maingreen,
          //   automaticallyImplyLeading: false,
          // ),
          floatingActionButton: SizedBox(
            height: 40,
            width: 100,
            child: FloatingActionButton(elevation: 10,
              backgroundColor: maingreen,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.white54)),
              //shape: Border.all(color: Color(0xff668698),),
              onPressed: (){
                 if(loginUser==null)
                 {
                  callNext(context, UserLogin());
                  }
                 else{
                   LOGINprovider.getLoginUserID(loginUser.phoneNumber, context);

                 }
              //Navigator.push(context, MaterialPageRoute(builder: (context) => UserLogin()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Page_content("SKIP", 20, FontWeight.bold, Colors.white),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Appbar_container(width, maingreen, homelycolor, slogancolor),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [

                          const SizedBox(height: 20,),

                          Text("HOW HOMELY WORKS FOR YOU..",
                          style: GoogleFonts.karma(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: maingreen,
                                  decoration: TextDecoration.underline,
                                decorationColor: maingreen,
                              ))
                              // style: TextStyle(
                              // fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              // color: maingreen,
                              // decorationColor: maingreen,
                              // decoration: TextDecoration.underline,),
                          ),
                          const SizedBox(height: 10,),
                          Container(
                            height: 160,
                            width: 275,
                            color: Colors.black87,
                            alignment: Alignment.center,
                            child:  Image.asset("assets/Logo/introcarehome.png",fit: BoxFit.fill),
                          ),
                          const SizedBox(height: 10,),
                          Card(
                            elevation: 5,
                            color: userlightblue,
                            child: SizedBox(
                              width: width,
                                child: IntroText()),
                          ),
                          const SizedBox(height: 10,),
                          Container(
                            //height: 36,
                            //color: Colors.cyan,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("RECENT ",
                                      style: GoogleFonts.karma(textStyle:
                                        TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: maingreen,height: 1))
                                      // style: TextStyle(
                                      //     fontSize: 20,
                                      //     fontWeight: FontWeight.bold,
                                      //     color: maingreen,
                                      //     height: 1,
                                      //     //decoration: TextDecoration.underline,
                                      //     //decorationColor: maingreen
                                      //   ),
                                    ),
                                    Text("NEWS",
                                        style: GoogleFonts.karma(textStyle:
                                        TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xffD50000),height: 1))
                                      // style: TextStyle(
                                      //   fontSize: 20,
                                      //   fontWeight: FontWeight.bold,
                                      //   color: Color(0xffD50000),
                                      //   height: 1,
                                      //   //decoration: TextDecoration.underline,
                                      //   //decorationColor: maingreen
                                      // ),
                                    ),
                                  ],
                                ),
                                const Divider(height: 0.5,color: maingreen,indent: 20,endIndent: 20,),
                                SizedBox(height: 10,),
                                Container(
                                  child: Consumer<MainProvider>(
                                    builder: (context ,value, child) {
                                      return ListView.builder(physics:  NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: value.Newslist.length,
                                          itemBuilder: (BuildContext context, int index)
                                          {
                                            return Card(
                                              color: userlightblue,
                                              elevation: 10,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text
                                                      (value.Newslist[index].headline,
                                                      style: GoogleFonts.karma(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600)),),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(value.Newslist[index].date,
                                                          style: GoogleFonts.karma(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400)),),
                                                        GestureDetector(
                                                          onTap: ()
                                                          {
                                                            value.user_newsclear();
                                                            value.updateNewsDetails(value.Newslist[index].id);
                                                            callNext(context, News(news_loader: value.newsloader));
                                                          },
                                                          child: Text("Read More",
                                                            style: GoogleFonts.karma(textStyle:
                                                            const TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: linkcolor,
                                                                decoration: TextDecoration.underline,decorationColor: linkcolor)),),
                                                        ),
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


                        ],
              ),
                    ),
                  ],
                ),
                Positioned(
                    //top: 10,
                    child: Image.asset("assets/Logo/Homely_logo.png",scale: 2.5,)),
                // Positioned(
                //     bottom: 20,
                //     child: ElevatedButton(onPressed: (){},
                //       //style: ButtonStyle(backgroundColor: Color(0xff04745B)),
                //       child: Page_content("SKIP", 20, FontWeight.bold, Colors.white),))
              ]
            ),
          ),
        ));
  }
}
