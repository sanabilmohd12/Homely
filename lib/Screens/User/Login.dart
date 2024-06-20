import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Constants/Call_Functions.dart';
import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import '../../Provider/Login_Provider/LoginProvider.dart';
import '../../Provider/Main_Provider/MainProvider.dart';
import 'OTPpage.dart';
import 'UserRegistration.dart';

class UserLogin extends StatelessWidget {
  UserLogin({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    MainProvider provider = Provider.of(context, listen: false);
    LoginProvider LOGINprovider = Provider.of(context, listen: false);

    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: height,
                  width: width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          opacity: 50,
                          image: AssetImage(
                              "assets/background/login_page.png"))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Appbar_container(
                          width, maingreen, homelycolor, slogancolor),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 70),
                        child: Card(
                          elevation: 30,
                          color: maingreen.withOpacity(0.6),
                          shape: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  50))),
                          child: Container(
                              height: 260,
                              width: width,
                              //color: maingreen,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25, top: 35, bottom: 10),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Consumer<LoginProvider>(
                                              builder: (context, val, child) {
                                                return TextFormField(
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                                                  controller: val.loginphoneController,
                                                  validator: (value)
                                                  {
                                                    if (value == null || value.isEmpty) {return "*Enter phone number";}
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    fillColor: Color(0xffD9D9D9),
                                                      filled: true,
                                                      prefixIcon: Icon(
                                                          Icons.call),
                                                      //icon: Icon(Icons.call),
                                                      hintText: "Phone Number",
                                                      hintStyle: GoogleFonts.karma(
                                                          textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black)),
                                                      //fillColor: Colors.orangeAccent,
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide
                                                            .none,
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(15)),
                                                      )),
                                                );
                                              }
                                          ),
                                          sizebox(),
                                          Consumer<LoginProvider>(
                                            builder: (context, val, child) {
                                              return val.loader == true ? CircularProgressIndicator(color: Colors.cyanAccent,):
                                                TextButton(
                                                  onPressed: () {
                                                    if (_formKey.currentState!.validate())
                                                    {
                                                      LOGINprovider.sendotp(context);
                                                    }
                                                  },
                                                  child: Page_content("LOGIN", 25, FontWeight.bold, Colors.white));
                                            }
                                          ),


                                        ],
                                      ),
                                      Row(
                                        //crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Page_content("Not a member?", 18,
                                              FontWeight.bold, Colors.white),
                                          TextButton(
                                              onPressed: () {
                                                provider.clearRegistration();
                                                callNext(context,
                                                    UserRegistration(
                                                      ID: "", from: "New",));
                                              },
                                              // style: TextButton.styleFrom(elevation: 10,
                                              //     //textStyle: TextStyle(decoration: TextDecoration.overline)
                                              // ),
                                              child: Page_content(
                                                  "SIGN UP",
                                                  20,
                                                  FontWeight.bold,
                                                  Colors.cyanAccent)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  //top: 10,
                    child: Image.asset(
                      "assets/Logo/Homely_logo.png",
                      scale: 2.5,
                    )),
              ],
            ),
          ),
        ));
  }
}
