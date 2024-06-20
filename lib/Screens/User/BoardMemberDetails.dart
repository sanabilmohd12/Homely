import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import '../../Provider/Main_Provider/MainProvider.dart';
import '../../Provider/Main_Provider/MyProvider.dart';

class BoardMemberDetails extends StatelessWidget {
  const BoardMemberDetails({super.key});

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: Appbar_user("Board Of Directors", context),
        endDrawerEnableOpenDragGesture: true,
        //drawerScrimColor: white,
        endDrawer: Drawerlist(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                //Page_content("PRESIDENT", 30, FontWeight.bold, black),
                Consumer<MainProvider>(
                    builder: (BMtitle_cntx, value, child) {
                    return Page_content(value.user_BMmap['title'].toString().toUpperCase(), 30, FontWeight.bold, black);
                  }
                ),
                Divider(color: maingreen.withOpacity(.25),),
                Consumer<MainProvider>(
                    builder: (BMimage_cntx, value, child) {
                    //return Image.asset("assets/boardMembers/AnnaMary.jpeg");
                      return SizedBox(
                        height: 125,
                        width: 125,
                        child: value.user_BMmap["BMphoto"].toString() != "" ?
                        Image.network(value.user_BMmap["BMphoto"].toString(),fit: BoxFit.fill,) :
                        Image.asset("assets/icons/userblack.png"),
                      );
                  }
                ),

                Consumer<MainProvider>(
                    builder: (BMname_cntx, value, child) {
                    return Page_content(value.user_BMmap['name'].toString().toUpperCase(), 25, FontWeight.bold, maingreen);
                  }
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Consumer<MainProvider>(
                    builder: (BMdesc_cntx, value, child) {
                    return Card(
                        elevation: 10,
                        color: userlightblue,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Page_content(value.user_BMmap['description'].toString(), 13, FontWeight.w600, black),
                        ));
                  }
                ),
                sizebox(),
                Consumer<MainProvider>(
                    builder: (BMcontact_cntx, value, child) {
                    return Card(
                        elevation: 10,
                        color: userlightblue,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Page_content("Contact Me", 15, FontWeight.bold, maingreen),
                              Divider(color: maingreen.withOpacity(.25),),
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.call,color: maingreen,),
                                  SizedBox(width: 10,),
                                  Page_content(value.user_BMmap['phone'].toString(), 15, FontWeight.w600, black),
                                ],
                              ),
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  Icon(Icons.mail_sharp,color: maingreen,),
                                  SizedBox(width: 10,),
                                  Page_content(value.user_BMmap['email'].toString(), 15, FontWeight.w600, black),
                                ],

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
                                      child: Image.asset("assets/icons/Linkedin.png",scale: 4,)
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
                        ));
                  }
                ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
