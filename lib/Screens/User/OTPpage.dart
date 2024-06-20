import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homely/Provider/Login_Provider/LoginProvider.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../Constants/Call_Functions.dart';
import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import 'Home_Residences.dart';

class OTPpage extends StatelessWidget {
  const OTPpage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Appbar_container(width, maingreen, homelycolor, slogancolor),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0,right: 25, top: 20),
                      child: Column(
                        children: [
                          //SizedBox(height: 10,),
                          Container(
                            height: height/4,
                            width: width,
                            //color: Color(0xffECF3F2),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                            //color: Color(0xffe5f4ea ),
                            color: Color(0xffeaf1f9 ),
                            ),
                            child: Image.asset("assets/background/otp_text.png",scale: 1.1,),
                            //0xffdce9e7
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(right: 190.0),
                            child: Page_content("Enter OTP", 18, FontWeight.w600, maingreen),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     otpBox(),
                          //     otpBox(),
                          //     otpBox(),
                          //     otpBox(),
                          //     otpBox(),
                          //
                          //   ],
                          // ),
                          Consumer<LoginProvider>(
                            builder: (context1, val, child) {
                              return Pinput(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                controller: val.otpController,
                                keyboardType: TextInputType.number,
                                length: 6,
                                closeKeyboardWhenCompleted: true,
                                defaultPinTheme: PinTheme(
                                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffccddf1),
                                    borderRadius: BorderRadius.circular(10)
                                  )
                                ),
                                onCompleted: (pin){
                                  val.verify(context);
                                },
                              );
                            }
                          ),
                          SizedBox(height: 10,),

                          // MaterialButton(
                          //   onPressed: (){
                          //  },
                          //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          //   color: maingreen,
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(top: 5),
                          //     child: Page_content("SUBMIT", 18, FontWeight.bold, Colors.white),
                          //   ),
                          // )

                        ],
                      ),
                    ),
                    Image.asset("assets/background/otp.png",scale: 1.3,)
                  ],
                ),
                Positioned(
                  //top: 10,
                    child: Image.asset("assets/Logo/Homely_logo.png", scale: 2.5,)),
              ],
            ),
          )
        ));
  }
}
