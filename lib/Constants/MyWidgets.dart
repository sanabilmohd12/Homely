import 'dart:collection';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homely/Constants/Call_Functions.dart';
import 'package:homely/Provider/Main_Provider/MainProvider.dart';
import 'package:homely/Screens/User/Events.dart';
import 'package:homely/Screens/User/news.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../Provider/Login_Provider/LoginProvider.dart';
import '../Provider/Main_Provider/SubAdmin_Provider.dart';
import '../Screens/Admin/MainAdminHomePage.dart';
import '../Screens/Admin/MainAdminIntroPage.dart';
import '../Screens/Admin/MainAdminNewsDescription.dart';
import '../Screens/Admin/MainAdminProfile.dart';
import '../Screens/Sub_Admin/Sub_AdminCareHomeList.dart';
import '../Screens/Sub_Admin/Sub_AdminHomePage.dart';
import '../Screens/User/Board_Members.dart';
import '../Screens/User/EventDetails.dart';
import '../Screens/User/FAQ.dart';
import '../Screens/User/Home_Residences.dart';
import '../Screens/User/IntroPage.dart';
import '../Screens/User/Login.dart';
import '../Screens/User/UserRegistration.dart';
import 'Colors.dart';
import 'DropdownLists.dart';

String _selectedDate = '';
String _dateCount = '';
String _range = '';
String _rangeCount = '';

Widget sizebox() {
  return SizedBox(height: 10,);
}

Widget Logo_Text(double fntsize_main, double fntsize_slogan,
    Color fntcolor_main, Color fntcolor_slogan) {
  return Column(mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Homely...",
        style: GoogleFonts.kaushanScript(textStyle: TextStyle(
            shadows: const [
              Shadow(
                color: Colors.black45, // Choose the color of the shadow
                blurRadius: 2.0, // Adjust the blur radius for the shadow effect
                offset: Offset(2.0,
                    2.0), // Set the horizontal and vertical offset for the shadow
              ),
            ],
            color: fntcolor_main, fontSize: fntsize_main)),),
      Text("Where everyone feels at home",
          style: GoogleFonts.kaushanScript(textStyle: TextStyle(
              shadows: const [
                Shadow(
                  color: Colors.black45,
                  // Choose the color of the shadow
                  blurRadius: 2.0,
                  // Adjust the blur radius for the shadow effect
                  offset: Offset(2.0,
                      2.0), // Set the horizontal and vertical offset for the shadow
                ),
              ],
              color: fntcolor_slogan, fontSize: fntsize_slogan))),
    ],
  );
}

PreferredSizeWidget Appbar_MainAdmin(String heading, var context) {
  return AppBar(
    iconTheme: const IconThemeData(color: white,
      shadows: [
        Shadow(
          color: Colors.black26, // Choose the color of the shadow
          blurRadius: 2.0, // Adjust the blur radius for the shadow effect
          offset: Offset(2.0,
              2.0), // Set the horizontal and vertical offset for the shadow
        ),
      ],),
    title: Text(heading),

    titleTextStyle: GoogleFonts.karma(
        textStyle: const TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: white,
          shadows: [
            Shadow(
              color: Colors.black26, // Choose the color of the shadow
              blurRadius: 2.0, // Adjust the blur radius for the shadow effect
              offset: Offset(2.0,
                  2.0), // Set the horizontal and vertical offset for the shadow
            ),
          ],
        )),

    elevation: 10,
    backgroundColor: adminblue,
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: IconButton(
        onPressed: () {
          //back(context);
          callNextReplacement(context, MainAdminHomePage());
        },
        icon: const Icon(Icons.arrow_back, color: white,
          shadows: [
            Shadow(
              color: Colors.black26, // Choose the color of the shadow
              blurRadius: 2.0, // Adjust the blur radius for the shadow effect
              offset: Offset(2.0,
                  2.0), // Set the horizontal and vertical offset for the shadow
            ),
          ],)),
  );
}

PreferredSizeWidget Appbar_user(String heading, var context) {
  return AppBar(
    iconTheme: const IconThemeData(color: white,
      shadows: [
        Shadow(
          color: Colors.black26, // Choose the color of the shadow
          blurRadius: 2.0, // Adjust the blur radius for the shadow effect
          offset: Offset(2.0,
              2.0), // Set the horizontal and vertical offset for the shadow
        ),
      ],),
    title: Text(heading),

    titleTextStyle: GoogleFonts.karma(
        textStyle: const TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: white,
          shadows: [
            Shadow(
              color: Colors.black26, // Choose the color of the shadow
              blurRadius: 2.0, // Adjust the blur radius for the shadow effect
              offset: Offset(2.0,
                  2.0), // Set the horizontal and vertical offset for the shadow
            ),
          ],
        )),

    elevation: 10,
    backgroundColor: maingreen,
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: IconButton(
        onPressed: () {
          if (heading == "Residences")
            Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const About()),);
          else
            back(context);
        },
        icon: const Icon(Icons.arrow_back, color: white,
          shadows: [
            Shadow(
              color: Colors.black26, // Choose the color of the shadow
              blurRadius: 2.0, // Adjust the blur radius for the shadow effect
              offset: Offset(2.0,
                  2.0), // Set the horizontal and vertical offset for the shadow
            ),
          ],)),
  );
}

PreferredSizeWidget Appbar_SubAdmin(String title1, String title2, var context) {
  LoginProvider LOGINprovider = Provider.of(context, listen: false);
  return AppBar(
    iconTheme: const IconThemeData(color: white,
      shadows: [
        Shadow(
          color: Colors.black26, // Choose the color of the shadow
          blurRadius: 2.0, // Adjust the blur radius for the shadow effect
          offset: Offset(2.0,
              2.0), // Set the horizontal and vertical offset for the shadow
        ),
      ],),
    title: Column(
      children: [
        Text(title1,
          style: GoogleFonts.karma(
              textStyle: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: white,
                shadows: [
                  Shadow(
                    color: Colors.black26,
                    // Choose the color of the shadow
                    blurRadius: 2.0,
                    // Adjust the blur radius for the shadow effect
                    offset: Offset(2.0,
                        2.0), // Set the horizontal and vertical offset for the shadow
                  ),
                ],
              )),),
        Text(title2,
          style: GoogleFonts.karma(
              textStyle: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: white,
                shadows: [
                  Shadow(
                    color: Colors.black26,
                    // Choose the color of the shadow
                    blurRadius: 2.0,
                    // Adjust the blur radius for the shadow effect
                    offset: Offset(2.0,
                        2.0), // Set the horizontal and vertical offset for the shadow
                  ),
                ],
              )),),
      ],
    ),


    elevation: 10,
    backgroundColor: maingreen,
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: IconButton(
        onPressed: () {
          callNextReplacement(context, SubAdminHomePage(Id: LOGINprovider.userId,));
        },
        icon: const Icon(Icons.arrow_back, color: white,
          shadows: [
            Shadow(
              color: Colors.black26, // Choose the color of the shadow
              blurRadius: 2.0, // Adjust the blur radius for the shadow effect
              offset: Offset(2.0,
                  2.0), // Set the horizontal and vertical offset for the shadow
            ),
          ],)),
  );
}

Widget Appbar_container(double width, Color box_color, Color fntcolor_main,
    Color fntcolor_slogan) {
  return Container(
    width: width,
    height: 70,
    color: box_color,
    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.only(left: 60, top: 7),
      child: Logo_Text(20, 15, fntcolor_main, fntcolor_slogan),
    ),
  );
}


Widget Drawerlist(var context) {
  MainProvider provider = Provider.of(context, listen: false);
  LoginProvider LOGINprovider = Provider.of(context, listen: false);
  SubAdmin_Provider sub_provider = Provider.of(context, listen: false);
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(color: maingreen),
            child: Image.asset("assets/Logo/Homely_logo.png", scale: 1.5,)),
        //child: Page_content("Homely", 24, FontWeight.bold, Colors.white)),
        ListTile(
          leading: Icon(Icons.person),
          title: Page_content("Profile", 15, FontWeight.w600, black),
          onTap: () {
            provider.updateUserDetails(LOGINprovider.userId);
            callNext(context,
                UserRegistration(ID: LOGINprovider.userId, from: "Edit",));
          },
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Page_content("Residences", 15, FontWeight.w600, black),
          onTap: () {
            callNext(context, Home_Residences());
          },
        ),
        ListTile(
          //leading: Image.asset("assets/icons/about.png",),
          leading: Icon(Icons.info_outline_rounded),
          title: Page_content("About", 15, FontWeight.w600, black),
          onTap: () {
            provider.getNewsDetails();
            callNext(context, About());
          },
        ),
        ListTile(
          leading: Icon(Icons.people_alt),
          title: Page_content("Board Members", 15, FontWeight.w600, black),
          onTap: () {
            provider.get_BMDetails();
            provider.get_SponsorDetails();
            callNext(context, BoardMembers());
          },
        ),
        // ListTile(
        //   leading: Icon(Icons.newspaper_sharp),
        //   title: Page_content("News", 15, FontWeight.w600, black),
        //   onTap: (){callNext(context, News());},
        // ),
        ListTile(
          leading: Icon(Icons.event_sharp),
          title: Page_content("Events", 15, FontWeight.w600, black),
          onTap: () {
            provider.getEventDetails();
            callNext(context, Events());
          },
        ),
        ListTile(
          leading: Icon(Icons.question_mark_outlined),
          title: Page_content("FAQ", 15, FontWeight.w600, black),
          onTap: () {
            callNext(context, Faq());
          },
        ),
        ListTile(
          leading: Icon(Icons.other_houses_outlined),
          title: Page_content("My Care-Homes", 15, FontWeight.w600, black),
          onTap: () {
            //sub_provider.get_CareHome_Details();
            sub_provider.find_UserCareHomes(LOGINprovider.userId);
            if(sub_provider.CareHomeList.isNotEmpty) {
              callNext(context, SubAdminHomePage(Id: LOGINprovider.userId,));
            }
            else
              {
                NoCareHome_alert(context);
              }
          },
        ),
        ListTile(
          leading: Icon(Icons.logout_sharp),
          title: Page_content("Logout", 15, FontWeight.w600, black),
          onTap: () {
            Logoutalert(context);
          },
        ),
      ],
    ),
  );
}

void Logoutalert(BuildContext context) //DELETE ALERT BOX
{
  showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
          title: Page_content("ALERT", 20, FontWeight.bold, Colors.red),
          content: Page_content(
              "Do you want To LOGOUT?", 16, FontWeight.bold, Colors.black),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                //DeleteStudent(context, id);
                //function;
                //deleteNews(context, id);
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => UserLogin()),
                        (Route<dynamic>route) => false);
              },
              child: Container(
                color: Colors.green,
                padding: const EdgeInsets.all(14),
                child: Page_content("Yes", 16, FontWeight.bold, Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                color: Colors.red,
                padding: const EdgeInsets.all(14),
                child: Page_content("NO", 16, FontWeight.bold, Colors.black),
              ),
            ),
          ],
        ),
  );
  //getNewsDetails();
  //notifyListeners();
}

void NoCareHome_alert(BuildContext context)
{
  SubAdmin_Provider sub_provider = Provider.of(context, listen: false);
  LoginProvider LOGINprovider = Provider.of(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        //title: const Text("ALERT"),
        content: Page_content("Sorry, there are no care homes registered under this user.\n"
            "Would you like to add a new care home?", 16, FontWeight.bold, Colors.black),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              //DeleteStudent(context, id);
              //function;
              sub_provider.find_UserCareHomes(LOGINprovider.userId);
              callNext(context, SubAdminHomePage( Id: LOGINprovider.userId));

            },
            child: Container(
              color: Colors.green,
              padding: const EdgeInsets.all(14),
              child: Page_content("Yes", 16, FontWeight.bold, Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.all(14),
              child: Page_content("NO", 16, FontWeight.bold, Colors.black),
            ),
          ),
        ],
      ),
    );
    //getNewsDetails();

}

void Unfinished_CareHome_alert(BuildContext context)
{
  SubAdmin_Provider sub_provider = Provider.of(context, listen: false);
  LoginProvider LOGINprovider = Provider.of(context, listen: false);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Page_content("Please complete all unfinished care home registrations "
          "before adding new Care Homes.", 16, FontWeight.bold, Colors.black),
      actions: <Widget>[
        TextButton(
          onPressed: ()
          {
            sub_provider.find_UserCareHomes(LOGINprovider.userId);
            callNext(context, Sub_AdminCareHomeList(userid: LOGINprovider.userId,));
          },
          child: Container(
            color: maingreen,
            padding: const EdgeInsets.all(14),
            child: Page_content("OK", 16, FontWeight.bold, Colors.black),
          ),
        ),
      ],
    ),
  );
}

void nonEditable_alert(BuildContext context)
{
  SubAdmin_Provider sub_provider = Provider.of(context, listen: false);
  LoginProvider LOGINprovider = Provider.of(context, listen: false);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Page_content("Changes can be made only after evaluation.", 16, FontWeight.bold, Colors.black),
      actions: <Widget>[
        TextButton(
          onPressed: ()
          {
            Navigator.of(context).pop();
          },
          child: Container(
            color: maingreen,
            padding: const EdgeInsets.all(14),
            child: Page_content("OK", 16, FontWeight.bold, Colors.black),
          ),
        ),
      ],
    ),
  );
}

Widget IntroText() {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Text(
      "The association does for its members what they cannot easily do for themselves. "
          "The Group Benefit program has been helpful to many and has potential to improve and expand. "
          "Working with government on wage, per diem, and issues of standards is a very important role "
          "that no individual home can do.\n\n"
          "The re-branding as illustrated in these videos is yet another major element of service. "
          "The new corporate structure of the association represents a commitment to strengthen its "
          "organization in its drive to become increasingly strong as a support to individual homes. "
          "Enhanced and expanded education, group purchasing, collaboration with government and other "
          "associations is yet another role. The association becomes stronger as more service providers "
          "get involved.",
      style: GoogleFonts.karma(textStyle: const TextStyle(
          fontSize: 15, fontWeight: FontWeight.w600)),),
  );
}

Widget Page_content(String txt, double fntsize, FontWeight fntweight,
    Color clr) {
  return Text(txt, softWrap: true,
      style: GoogleFonts.karma(
          textStyle: TextStyle(
              fontSize: fntsize, fontWeight: fntweight, color: clr)));
}

Widget head() {
  return Card(
    color: userlightblue,
    elevation: 10,
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text
            ("Nursing home wait list hits record high — and is now"
              "holding up 500 hospital beds",
            style: GoogleFonts.karma(textStyle: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500)),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("27 May 2023",
                style: GoogleFonts.karma(textStyle: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w400)),),
              Text("Read More",
                style: GoogleFonts.karma(textStyle:
                const TextStyle(fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: linkcolor,
                    decoration: TextDecoration.underline,
                    decorationColor: linkcolor)),),
              //Icon(Icons.arrow_forward,color: Color(0xff0029FF),size: 15,)
            ],
          )
        ],
      ),
    ),
  );
}

Widget NewsList_Admin(var context, var classname, var news_list) {
  return Card(
    color: textformcolor,
    elevation: 5,
    child: Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text
            (news_list.headline,
            style: GoogleFonts.karma(textStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500)),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("27 May 2023",
                style: GoogleFonts.karma(textStyle: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w400)),),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: () {
                      callNext(context, classname);
                    },
                        icon: Icon(Icons.edit_square, size: 20,),
                        padding: EdgeInsets.zero),
                    IconButton(onPressed: () {},
                        icon: Icon(Icons.delete, color: Colors.red, size: 20,),
                        padding: EdgeInsets.zero),
                  ],
                ),
              )
            ],
          ),

        ],
      ),
    ),
  );
}

Widget otpBox() {
  return Container(

    height: 45,
    width: 45,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
      color: const Color(0xffccddf1),),
    child: TextFormField(
      keyboardType: TextInputType.number,

      //controller: value.phonecontroller,
      decoration: const InputDecoration(
        //fillColor: Color(0xffA8ABFF),
        //prefixIcon: Icon(Icons.call),
        //icon: Icon(Icons.call),
        //hintText: "Phone Number",
        //fillColor: Colors.orangeAccent,
          border: OutlineInputBorder(borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
                Radius.circular(10)),
          )),
    ),
  );
}

////////////////Text form fields//////////////////////////////////////////////////////////////

Widget Txtformfield(String hint, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "*Required field";
        }
        return null;
      },
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: GoogleFonts.karma(textStyle:
        const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: black,)),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 15),
        filled: true,
        fillColor: textformcolor,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
      ),
      style: GoogleFonts.karma(textStyle:
      const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,)),
    ),
  );
}

Widget Txtformfield_comments(String hint, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(

      //validator: ,
      keyboardType: TextInputType.multiline,
      style: GoogleFonts.karma(textStyle:
      const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,)),
      //maxLines: 2,
      controller: controller,
      // validator: (value)
      // {
      //   if (value == null || value.isEmpty) {return "*Required field";}
      //   return null;
      // },
      decoration: InputDecoration(
        // isDense: true,
        hintText: hint,
        hintStyle: GoogleFonts.karma(textStyle:
        const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: black,)),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 15),
        filled: true,
        fillColor: textformcolor,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),


      ),
    ),
  );
}

Widget Txtformfield_link(String hint, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      keyboardType: TextInputType.url,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: GoogleFonts.karma(textStyle:
        const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: black,)),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 15),
        filled: true,
        fillColor: textformcolor,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
      ),
      style: GoogleFonts.karma(textStyle:
      const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,)),
    ),

  );
}

Widget Txtformfield_email(String hint, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      validator: (value) =>
      EmailValidator.validate(value!)
          ? null
          : "Please enter a valid email",
      // {
      //   if (value == null || value.isEmpty) {return "*Required field";}
      //   return null;
      // },
      style: GoogleFonts.karma(textStyle:
      const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.karma(textStyle:
        const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: black,)),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 15),
        isDense: true,
        filled: true,
        fillColor: textformcolor,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
      ),
    ),
  );
}

Widget Txtformfield_number(String hint, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      keyboardType: TextInputType.number,
      style: GoogleFonts.karma(textStyle:
      const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,)),
      inputFormatters: [
        LengthLimitingTextInputFormatter(10)
      ],
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Phone number cannot be empty";
        }
        else if (value.length < 10) {
          return "Invalid Phone Number";
        }
        return null;
      },
      decoration: InputDecoration(
        //prefixIcon: Icon(Icons.call),
        hintText: hint,
        hintStyle: GoogleFonts.karma(textStyle:
        const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: black,)),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 15),
        isDense: true,
        filled: true,
        fillColor: textformcolor,

        //border: OutlineInputBorder(borderRadius: BorderRadius.zero),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),

      ),
    ),
  );
}

Widget Textformfield_date(String hint, TextEditingController controller,
    BuildContext ctx) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Consumer<MainProvider>(
        builder: (context11, value, child) {
          return TextFormField(
            onTap: () {
              value.selectDate(ctx, controller);
            },
            keyboardType: TextInputType.none,
            //enabled: false,
            controller: controller,
            style: GoogleFonts.karma(textStyle:
            const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,)),
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_month_outlined),
              isDense: true,
              hintText: hint,
              hintStyle: GoogleFonts.karma(textStyle:
              const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: black,)),
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 15),
              filled: true,
              fillColor: textformcolor,
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: txtfrmbordercolor)),
              disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: txtfrmbordercolor)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: txtfrmbordercolor)),
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
              focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
            ),
          );
        }
    ),
  );
}


Widget Txtformfield_pincode(String hint, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      keyboardType: TextInputType.number,
      style: GoogleFonts.karma(textStyle:
      const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,)),
      inputFormatters: [
        LengthLimitingTextInputFormatter(6)
      ],
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "*Required field";
        }
        return null;
      },
      decoration: InputDecoration(
        //prefixIcon: Icon(Icons.call),
        hintText: hint,
        hintStyle: GoogleFonts.karma(textStyle:
        const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: black,)),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 15),
        isDense: true,
        filled: true,
        fillColor: textformcolor,

        //border: OutlineInputBorder(borderRadius: BorderRadius.zero),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),

      ),
    ),
  );
}

Widget Txtformfield_bedcount(String hint, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(5)
      ],
      style: GoogleFonts.karma(textStyle:
      const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,)),
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "*Required field";
        }
        return null;
      },
      decoration: InputDecoration(
        //prefixIcon: Icon(Icons.call),
        hintText: hint,
        hintStyle: GoogleFonts.karma(textStyle:
        const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: black,)),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 15),
        isDense: true,
        filled: true,
        fillColor: textformcolor,

        //border: OutlineInputBorder(borderRadius: BorderRadius.zero),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),

      ),
    ),
  );
}

Widget Txtformfieldaddress(String hint, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(minLines: 4,
      maxLines: 5,
      //minLines: 4,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "*Required field";
        }
        return null;
      },
      style: GoogleFonts.karma(textStyle:
      const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,)),
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: GoogleFonts.karma(textStyle:
        const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: black,)),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 15),
        filled: true,
        fillColor: textformcolor,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),

      ),
    ),
  );
}

Widget TxtformfieldDescription(String hint, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "*Required field";
        }
        return null;
      },
      //onTap: (){print(object)},
      maxLines: 4,
      keyboardType: TextInputType.multiline,
      style: GoogleFonts.karma(textStyle:
      const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,)),
      //inputFormatters: [],
      //minLines: 4,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: GoogleFonts.karma(textStyle:
        const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: black,)),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 15),
        filled: true,
        fillColor: textformcolor,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),

      ),
    ),
  );
}

Widget Txtformfield_eventdaytopic(String hint,
    TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "*Required field";
        }
        return null;
      },
      style: GoogleFonts.karma(textStyle:
      const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,)),
      //onTap: (){daycount--;},
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: GoogleFonts.karma(textStyle:
        const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: black,)),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 15),
        filled: true,
        fillColor: textformcolor,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
      ),
    ),
  );
}

Widget TxtformfieldeventDescription(String hint,
    TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "*Required field";
        }
        return null;
      },
      //onTap: (){print("daycount = $daycount , qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");},
      maxLines: 4,
      keyboardType: TextInputType.multiline,
      style: GoogleFonts.karma(textStyle:
      const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,)),
      //inputFormatters: [],
      //minLines: 4,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: GoogleFonts.karma(textStyle:
        const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: black,)),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 15),
        filled: true,
        fillColor: textformcolor,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),

      ),
    ),
  );
}


Widget Datetimepicker_syncfusion() {
  return SfDateRangePicker(
    onSelectionChanged: _onSelectionChanged,
    selectionMode: DateRangePickerSelectionMode.range,
  );
}


void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
  if (args.value is PickerDateRange) {
    _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
    // ignore: lines_longer_than_80_chars
        ' ${DateFormat('dd/MM/yyyy').format(
        args.value.endDate ?? args.value.startDate)}';
  } else if (args.value is DateTime) {
    _selectedDate = args.value.toString();
  } else if (args.value is List<DateTime>) {
    _dateCount = args.value.length.toString();
  } else {
    _rangeCount = args.value.length.toString();
  }

  // TODO: implement your code here
}

Widget Dropdown(List<String> dropdownlist, String hint, double width, String dropdownvalue) {
  return Container(
    width: width / 2.5,
    height: 45,
    //alignment: Alignment.center,
    decoration: BoxDecoration(
        color: textformcolor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: txtfrmbordercolor)
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
      child: DropdownButton(

        // Initial Value
        //value: dropdownvalue,
        disabledHint: Page_content(hint, 14, FontWeight.w500, black),
        hint: Page_content(hint, 14, FontWeight.w500, black),
        isExpanded: true,
        isDense: true,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: dropdownlist.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Page_content(items, 14, FontWeight.w600, black),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {},

      ),
    ),
  );
}

Widget Dropdown_Payment(List<String> dropdownlist, String hint, double width) {
  return Container(
    width: width,
    height: 45,
    //alignment: Alignment.center,
    decoration: BoxDecoration(
        color: textformcolor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: txtfrmbordercolor)
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
      child: DropdownButton(

        // Initial Value
        //value: dropdownvalue,
        disabledHint: Page_content(hint, 14, FontWeight.w500, black),
        hint: Page_content(hint, 14, FontWeight.w500, black),
        isExpanded: true,
        isDense: true,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: dropdownlist.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Page_content(items, 15, FontWeight.w600, Colors.black),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String?newValue) {},
      ),
    ),
  );
}

Widget General_Search() {
  return TextFormField(
    //controller: value.phonecontroller,
    style: GoogleFonts.karma(textStyle:
    const TextStyle(
      fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,)),
    decoration: InputDecoration(
      isDense: true,
      prefixIcon: Icon(Icons.search_sharp, color: Colors.grey,),
      hintText: "Search Care Home By Name",
      hintStyle: GoogleFonts.karma(textStyle:
      const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey,)),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      //filled: true,
      //fillColor: textformcolor,
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: txtfrmbordercolor),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: txtfrmbordercolor),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: txtfrmbordercolor),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      //errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      //focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    ),
  );
}

Widget EventList(var context) {
  return Card(
    color: userlightblue,
    elevation: 5,
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                callNext(context, Event_Details());
              },
              child: Page_content(
                  "Responding To The Challenges Of Long Term Care", 15,
                  FontWeight.bold, maingreen)),
          Divider(color: maingreen.withOpacity(.25),),
          Page_content("Oct 30 - 31", 12, FontWeight.w500, black),
          Page_content(
              "Venue : Sheraton Hotels, Cochin.", 12, FontWeight.w500, black),
        ],
      ),
    ),
  );
}

Widget EventList_MainAdmin(var context, var classname) {
  return Card(
    color: textformcolor,
    elevation: 5,
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Page_content("Responding To The Challenges Of Long Term Care", 15,
              FontWeight.bold, maingreen),
          Divider(color: maingreen.withOpacity(.25),),
          Page_content("Oct 30 - 31", 12, FontWeight.w500, black),
          Page_content(
              "Venue : Sheraton Hotels, Cochin.", 12, FontWeight.w500, black),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(alignment: Alignment.bottomRight,
                  onPressed: () {
                    callNext(context, classname);
                  },
                  icon: Icon(Icons.edit_square, size: 20,),
                  padding: EdgeInsets.zero),
              IconButton(alignment: Alignment.bottomLeft,
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Colors.red, size: 20,),
                  padding: EdgeInsets.zero),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget AdminhomeContainer(String txt, var context) {
  return Card(
    elevation: 3,
    //color: mainAdminfldclr1,
    //color: MA_homebarcolor,
    child: Container(
      color: MA_homebarcolor,
      alignment: Alignment.center,
      height: 90,
      width: 145,
      //padding: EdgeInsets.symmetric(vertical: 15),
      child: Page_content(txt, 20, FontWeight.bold, Colors.black),
    ),
  );
}
// width: width/1.165,
Widget AutoCompleteDropdown(double width, TextEditingController controller)
{
  return SizedBox(
    //height: 45,
    width: width/1.165,
    child: Autocomplete<String>(optionsBuilder: (TextEditingValue textEditingValue){
      return (Kerala)
          .where((String district) => district.toLowerCase()
          .contains(textEditingValue.text.toLowerCase()))
          .toList();
      },
      displayStringForOption: (String option) => option,
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          fieldTextEditingController.text = controller.text;
        });
      return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "*Required field";
          }
          return null;
        },
        decoration:  InputDecoration(
          //contentPadding: EdgeInsets.only(top: ),
          isDense: true,
          fillColor: textformcolor,
          filled: true,
          // hintStyle: blackPoppinsR12,
          hintText:'Select District *',
          hintStyle: GoogleFonts.karma(textStyle:
          const TextStyle(height: 1,
            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black,)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: txtfrmbordercolor),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: txtfrmbordercolor),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: txtfrmbordercolor),
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        controller: fieldTextEditingController,
        focusNode: fieldFocusNode,
        style: GoogleFonts.karma(textStyle:
        const TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,)),

      );
      },
      onSelected: (String selection)
      {
        controller.text = selection;
      },
        optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options)
        {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              child: Container(
                width: double.infinity,
                height: 250,
                color: Colors.white,
                child: ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);

                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child:  Container(
                        color: Colors.white,
                        height: 50,
                        width: double.infinity,
                        child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(option,
                                  style: GoogleFonts.karma(textStyle: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black,)),),
                              const SizedBox(height: 10)
                            ]),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }
    ),
  );
}

Widget AutoCompleteSearchDropdown(BuildContext context, double width, TextEditingController controller)
{
  SubAdmin_Provider sub_provider = Provider.of(context,listen: false);
  return SizedBox(
    //height: 45,
    width: width/1.165,
    child: Autocomplete<String>(optionsBuilder: (TextEditingValue textEditingValue){
      return (sub_provider.CareHomeNAME_ApprovedList)
          .where((String homename) => homename.toLowerCase()
          .contains(textEditingValue.text.toLowerCase()))
          .toList();
    },
        displayStringForOption: (String option) => option,
        fieldViewBuilder: (BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            fieldTextEditingController.text = controller.text;
          });
          return TextFormField(

            decoration:  InputDecoration(
              //contentPadding: EdgeInsets.only(top: ),
              isDense: true,
              fillColor: textformcolor,
              filled: true,
              // hintStyle: blackPoppinsR12,
              hintText:'Search Care home...',
              hintStyle: GoogleFonts.karma(textStyle:
              const TextStyle(height: 1,
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey,)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: txtfrmbordercolor),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: txtfrmbordercolor),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: txtfrmbordercolor),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
            controller: fieldTextEditingController,
            focusNode: fieldFocusNode,
            style: GoogleFonts.karma(textStyle:
            const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,)),

          );
        },
        onSelected: (String selection)
        {
          controller.text = selection;
        },
        optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options)
        {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              child: Container(
                width: double.infinity,
                height: 250,
                color: Colors.white,
                child: ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);

                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child:  Container(
                        color: Colors.white,
                        height: 50,
                        width: double.infinity,
                        child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(option,
                                style: GoogleFonts.karma(textStyle: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black,)),),
                              const SizedBox(height: 10)
                            ]),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }
    ),
  );
}

Widget DropDownFormField_carelevel(String? selectedValue, List<String> dropdownlist, String hint, double width, var context)
{
  SubAdmin_Provider sub_provider = Provider.of(context, listen: false);
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: SizedBox(height: 48,
      child: DropdownButtonFormField(
        style: GoogleFonts.karma(textStyle:
        const TextStyle(height: 1,
          fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,),),
        //padding: EdgeInsets.zero,
        isDense: false,
        value: selectedValue,
        //hint: Page_content(hint, 15, FontWeight.w500, Colors.grey),
        isExpanded: true,
        onChanged: (value) {
          sub_provider.onSelected_carelevel(value);

        },
        onSaved: (value) {
          sub_provider.onSelected_carelevel(value);
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "*Required field";
          }
          return null;
        },

        //itemHeight: null,
        //menuMaxHeight: 70,
        items: dropdownlist
            .map((String val) {
          return DropdownMenuItem(
            value: val,
            child: Page_content(val, 14, FontWeight.w600, Colors.black)
          );
        }).toList(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          //isDense: true,
          fillColor: textformcolor,
          filled: true,
          // hintStyle: blackPoppinsR12,
          hintText: hint,
          hintStyle: GoogleFonts.karma(textStyle:
          const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black,)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: txtfrmbordercolor),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: txtfrmbordercolor),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: txtfrmbordercolor),
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ),
    ),
  );
}

Widget DropDownFormField_facility(String? selectedValue, List<String> dropdownlist, String hint, double width, var context)
{
  SubAdmin_Provider sub_provider = Provider.of(context, listen: false);
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: DropdownButtonFormField(
      value: selectedValue,
      // hint: Page_content(hint, 15, FontWeight.w500, Colors.grey),
      isExpanded: true,
      onChanged: (value) {
        sub_provider.onSelected_facility(value);

      },
      onSaved: (value) {
        sub_provider.onSelected_facility(value);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "*Required field";
        }
        return null;
      },
      items: dropdownlist
          .map((String val) {
        return DropdownMenuItem(
            value: val,
            child: Page_content(val, 14, FontWeight.w600, Colors.black)
        );
      }).toList(),
      decoration: InputDecoration(
        isDense: true,
        fillColor: textformcolor,
        filled: true,
        // hintStyle: blackPoppinsR12,
        hintText: hint,
        hintStyle: GoogleFonts.karma(textStyle:
        const TextStyle(height: 1,
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black,)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: txtfrmbordercolor),
            borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
    ),
  );
}

Widget DropDownFormField_payment(String? selectedValue, List<String> dropdownlist, String hint, double width, var context)
{
  SubAdmin_Provider sub_provider = Provider.of(context, listen: false);
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: SizedBox(height: 48,
      child: DropdownButtonFormField(
        style: GoogleFonts.karma(textStyle:
        const TextStyle(height: 1,
          fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,),),
        //padding: EdgeInsets.zero,
        isDense: false,
        value: selectedValue,
        //hint: Page_content(hint, 15, FontWeight.w500, Colors.grey),
        isExpanded: true,
        onChanged: (value) {
          sub_provider.onSelected_payment(value);

        },
        onSaved: (value) {
          sub_provider.onSelected_payment(value);
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "*Required field";
          }
          return null;
        },

        //itemHeight: null,
        //menuMaxHeight: 70,
        items: dropdownlist.map((String val)
        {
          return DropdownMenuItem(
              value: val,
              child: Page_content(val, 14, FontWeight.w600, Colors.black)
          );
        }).toList(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          //isDense: true,
          fillColor: textformcolor,
          filled: true,
          // hintStyle: blackPoppinsR12,
          hintText: hint,
          hintStyle: GoogleFonts.karma(textStyle:
          const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black,)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: txtfrmbordercolor),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: txtfrmbordercolor),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: txtfrmbordercolor),
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ),
    ),
  );
}

void Image_alert(BuildContext context, int index)
{
  SubAdmin_Provider sub_provider = Provider.of(context, listen: false);
  LoginProvider LOGINprovider = Provider.of(context, listen: false);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(contentPadding: EdgeInsets.zero,
      //title: const Text("ALERT"),
      content: sub_provider.HomeImage_List.isNotEmpty?Image.file(sub_provider.HomeImage_List[index], fit: BoxFit.fill,):
      sub_provider.image_list.isNotEmpty?Image.network(sub_provider.image_list[index], fit:  BoxFit.fill,):
      Page_content("No image to show", 16, FontWeight.bold, Colors.black),
      //actions: <Widget>[

        // TextButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: Container(
        //     color: Colors.red,
        //     padding: const EdgeInsets.all(14),
        //     child: Page_content("NO", 16, FontWeight.bold, Colors.black),
        //   ),
        // ),
      //],
    ),
  );
  //getNewsDetails();

}