import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Constants/Call_Functions.dart';
import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import '../../Provider/Main_Provider/MainProvider.dart';
import '../User/IntroPage.dart';

class MainAdminProfile extends StatelessWidget {
  String ID,from;
  MainAdminProfile({super.key, required this.ID,required this.from});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          appBar: Appbar_MainAdmin("PROFILE", context),
          endDrawerEnableOpenDragGesture: true,
          //drawerScrimColor: white,
          endDrawer: Drawerlist(context),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child:  Column(
                      children: [
                        Container(
                          width: width,
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: (){callNext(context, About());},
                              child: Text("Logout",
                                style: GoogleFonts.karma(textStyle:
                                const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: linkcolor,
                                    decoration: TextDecoration.underline,decorationColor: linkcolor)),
                              )
                          ),
                        ),
                        Container(
                        //color: mainAdminfldclr,
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        width: 100,
                        height: 100,
                        alignment: Alignment.bottomRight,
                        decoration: BoxDecoration(
                        border: Border.all(color: txtfrmbordercolor),
                        color: mainAdminfldclr,
                        image: DecorationImage(image: AssetImage("assets/icons/Usericon.png"))
                        ),
                          child: Container(
                            color: adminblue,
                            height: 40,
                            width: 40,
                            child: Icon(Icons.add,color: Colors.white,),
                          ),
                        ),
                        sizebox(),
                        Consumer<MainProvider>(
                          builder: (context, value, child) {
                            return Txtformfield("First Name *", value.Firstnamecontroller);
                          }
                        ),
                        Consumer<MainProvider>(
                          builder: (context, value, child) {
                            return Txtformfield("Last Name",value.Lastnamecontroller);
                          }
                        ),
                        Consumer<MainProvider>(
                          builder: (context, value, child) {
                            return Txtformfield_email("Email", value.emailcontroller);
                          }
                        ),
                        Consumer<MainProvider>(
                          builder: (context, value, child) {
                            return Txtformfield_number("Phone Number *", value.phonecontroller);
                          }
                        ),

                        Container(
                          width: width,
                          alignment: Alignment.centerRight,
                          child: MaterialButton(
                            onPressed: (){},
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            color: adminblue,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Page_content("Save/Update", 18, FontWeight.bold, Colors.white),
                            ),
                          ),
                        ),

                      ],
                    )


              ),
            ),
          ),
        ));
  }
}
