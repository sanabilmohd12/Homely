import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homely/Constants/Call_Functions.dart';
import 'package:provider/provider.dart';

import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import '../Provider/Main_Provider/MainProvider.dart';
import 'User/IntroPage.dart';
import 'User/Login.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {


  @override
  void initState()
  {
    MainProvider provider = Provider.of(context, listen: false);
    Timer( Duration(seconds: 5), () {
//   // if(loginUser==null){
      provider.getNewsDetails();
      callNextReplacement(context, About());
      //callNextReplacement(context, UserLogin());
//   // }else{
//   // loginProvider.userAuthorized(loginUser.phoneNumber, context);
//   //
//   // }
  });
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: GestureDetector(
            onTap:(){
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const About()));
              },
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,opacity: 20,
                      image: AssetImage("assets/background/flash_screen.png"))),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Image.asset("assets/Logo/Homely_logo.png"),
                    SizedBox(height: 50,),

                    SizedBox(
                      height: 150,
                      width: 200,
                      child: Image.asset("assets/Logo/Homely_logo.png"),
                    ),
                    //Logo_Text(54, 20, splash_homelycolor, splash_slogancolor)
                    Column(mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Homely...",
                          style: GoogleFonts.kaushanScript(textStyle: TextStyle(color: splash_homelycolor,fontSize: 54)),),
                        Text("Where everyone feels at home",
                            style: GoogleFonts.kaushanScript(textStyle: TextStyle(color: splash_slogancolor,fontSize: 20))),
                      ],
                    )


                  ],
                ),
              ),
            ),
          )),
    );
  }
}
