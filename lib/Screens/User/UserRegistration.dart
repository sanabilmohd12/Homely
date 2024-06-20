import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Constants/Call_Functions.dart';
import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import '../../Provider/Main_Provider/MainProvider.dart';
import 'Home_Residences.dart';
import 'Login.dart';

class UserRegistration extends StatelessWidget {
  String ID,from;
  UserRegistration({super.key, required this.ID,required this.from});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          //appBar: ,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Appbar_container(width, maingreen, homelycolor, slogancolor),
                    Image.asset("assets/background/register.png",scale: 1.5,),
                    //Page_content("“It is not how much you do,but how much love you put in the doing.” — Mother Teresa", 25, FontWeight.normal, Color(0xff5C4B4B)),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("“It is not how much you do, but how much love you put in the doing.” — Mother Teresa",
                                style: GoogleFonts.kaushanScript(textStyle: const TextStyle(
                                    shadows: [
                                      Shadow(
                                        color: Colors.black45,      // Choose the color of the shadow
                                        //blurRadius: 1.0,          // Adjust the blur radius for the shadow effect
                                        offset: Offset(.5, .5), // Set the horizontal and vertical offset for the shadow
                                      ),
                                    ],
                                    color: Color(0xff5C4B4B),fontSize: 21))),
                            SizedBox(height: 20,),
                            //Page_content("*Required Fields", 13, FontWeight.normal, Colors.red),
                            Consumer<MainProvider>(
                              builder: (context, value, child) {
                                return Txtformfield("First Name", value.Firstnamecontroller);
                              }
                            ),
                            Consumer<MainProvider>(
                              builder: (context, value, child) {
                                return Txtformfield("Last Name", value.Lastnamecontroller);
                              }
                            ),
                            Consumer<MainProvider>(
                              builder: (context, value, child) {
                                return Txtformfield_email("Email",value.emailcontroller);
                              }
                            ),
                            Consumer<MainProvider>(
                              builder: (context, value, child) {
                                return Txtformfield_number("Phone Number", value.phonecontroller);
                              }
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width/1.8),
                              child: Consumer<MainProvider>(
                                  builder: (context, value, child) {
                                  return MaterialButton(
                                    onPressed: (){
                                      if (_formKey.currentState!.validate())
                                      {
                                        value.user_registration(context, ID, from);
                                        //callNextReplacement(context, const UserLogin());
                                      }
                                      },
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    color: maingreen,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Page_content(from == "New"?"Register":"Update", 18, FontWeight.bold, Colors.white),
                                    ),
                                  );
                                }
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  //top: 10,
                    child: Image.asset("assets/Logo/Homely_logo.png",scale: 2.5,)),
              ],
            ),
          ),
        ));
  }
}
