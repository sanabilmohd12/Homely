import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homely/Constants/Colors.dart';
import 'package:homely/Constants/MyWidgets.dart';
import 'package:provider/provider.dart';

import '../../Constants/Call_Functions.dart';
import '../../Screens/Admin/MainAdminHomePage.dart';
import '../../Screens/Sub_Admin/Sub_AdminHomePage.dart';
import '../../Screens/User/Home_Residences.dart';
import '../../Screens/User/Login.dart';
import '../../Screens/User/OTPpage.dart';
import '../Main_Provider/MainProvider.dart';

class LoginProvider extends ChangeNotifier{

  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;


  String userId='';
  String loginUsertype='';
  String VerificationId='';
  TextEditingController loginphoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool loader = false;


  void sendotp(BuildContext context) async {

    loader= true;
    notifyListeners();
    await auth.verifyPhoneNumber(
      phoneNumber: "+91${loginphoneController.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: maingreen,
          content: Page_content("Verification Completed", 20, FontWeight.w800, Colors.white),
          duration:
          Duration(milliseconds: 3000),
        ));
        if (kDebugMode) {}
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == "invalid-phone-number") {
          print("FAAAAAAAAAAAAAAAAAAAAAAAIL");
          ScaffoldMessenger.of(context)
              .showSnackBar( SnackBar(
            content: Page_content("Sorry, Verification Failed", 20, FontWeight.w800, Colors.red),

            duration: Duration(milliseconds: 3000),
          ));
          //finish(context);
          loader= false;
          loginphoneController.clear();
          notifyListeners();
          if (kDebugMode) {

          }

        }
      },

      codeSent: (String verificationId, int? resendToken) {
        VerificationId = verificationId;
        loader= false;
        notifyListeners();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  OTPpage(),
            ));
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          backgroundColor: maingreen,
          content: Page_content("OTP sent to phone successfully", 18, FontWeight.w600, Colors.white),

          duration: Duration(milliseconds: 3000),
            elevation: 5,
            behavior: SnackBarBehavior.floating,
            width: 300
        ));
        loginphoneController.clear();
        log("Verification Id : $verificationId");

      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: const Duration(seconds: 60),
    );
  }

  void verify(BuildContext context) async {
print("VERify FUNCtION");
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: VerificationId, smsCode: otpController.text);
    print(credential.toString()+"sjjss");
    await auth.signInWithCredential(credential).then((value) {
      final user = value.user;
      if (user != null) {

        userAuthorized(user.phoneNumber, context);

      } else {
        print("ooooooooooooooooooooooo");
        finish(context);
        if (kDebugMode) {
        }
      }
    });
  }

  Future<void> userAuthorized(String? phoneNumber, BuildContext context)
  async {

    String loginUserFirstname='';
    String loginUserLastname='';

    String loginUserid='';

    String loginphno="";
    //String loginPhoto="";
    String email="";
    MainProvider provider = Provider.of<MainProvider>(context, listen: false);
    otpController.clear();

    try {
      var phone = phoneNumber!;
      print(phoneNumber.toString()+"duudud");
      db.collection("USER").where("Phone",isEqualTo:phone).get().then((value)
      {
        if(value.docs.isNotEmpty)
        {
          print("fiifuif");
          for(var element in value.docs) {
            Map<dynamic, dynamic> map = element.data();
            loginUserFirstname = map['First Name'].toString();
            loginUsertype = map['Type'].toString();
            loginphno=map["Phone"].toString();
            loginUserid = element.id;
            userId = map["id"].toString();
            notifyListeners();

            String uid = userId;
            print(loginUsertype);
            if (loginUsertype == "main_admin") {

              print("cb bcb");
              callNextReplacement(context, const MainAdminHomePage());

            }
            else if(loginUsertype == "sub_admin")
            {
              callNextReplacement(context, SubAdminHomePage(Id: userId,));
            }
            else {
              print("mxnxn");

              db.collection("USERDETAILS").doc(userId).get().then((value) {
                if(value.exists) {

                  loginUserLastname=value.get("Last Name").toString();
                  email=value.get("Email").toString();

                  provider.updateUserDetails(userId);
                  //provider.GetNewWork();
                  //provider.GetCustomerfn(userId);

                  //callNextReplacement(context,Bottombar(userId: userId,userName: loginUsername,name: loginUsername,phone: loginphno,address: address,),);
                  callNextReplacement(context, Home_Residences());
                }

              });

              print("dkdkdd");

            }
          }

        }
        else {
          // const snackBar =
              // backgroundColor: Colors.white,
              // duration: Duration(milliseconds: 3000),
              // content: Text("Sorry , You don't have any access",
              //   textAlign: TextAlign.center,
              //   softWrap: true,
              //   style: TextStyle(
              //       fontSize: 18,
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold),
              // )
          //);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Center(child: Text("Sorry , You don't have any access",
                softWrap: true,
                textAlign: TextAlign.center,
                style: GoogleFonts.karma(
                    textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)))),
            backgroundColor: maingreen,
            elevation: 5,
            behavior: SnackBarBehavior.floating,
            width: 300,
          ));
          finish(context);
        }

      });


    } catch (e) {


      // const snackBar = SnackBar(
      //     backgroundColor: Colors.white,
      //     duration: Duration(milliseconds: 3000),
      //     content: Text("Sorry , Some Error Occurred",
      //       textAlign: TextAlign.center,
      //       softWrap: true,
      //       style: TextStyle(
      //           fontSize: 18,
      //           color: Colors.black,
      //           fontWeight: FontWeight.bold),
      //     ));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

////////////////////////////////FIND LOGIN USER ID/////////////////////////////////////////////////

  void getLoginUserID(String? phone,BuildContext context)
  {
    db.collection("USER").where("Phone",isEqualTo: phone).get().then((value)
    {
      if(value.docs.isNotEmpty)
      {
        for(var element in value.docs)
        {
          Map<dynamic, dynamic> map = element.data();
          userId = map["id"].toString();
          loginUsertype = map["Type"];
          print('USeRtYpe= ${map["Type"]}');
          notifyListeners();
        }
      }
      if (loginUsertype == "main_admin") {

        callNextReplacement(context, const MainAdminHomePage());

      }
      else
        callNext(context, Home_Residences());
    });
  }

}