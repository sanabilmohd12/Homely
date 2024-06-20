import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import '../../Provider/Main_Provider/MainProvider.dart';
import '../../Provider/Main_Provider/MyProvider.dart';

class News extends StatelessWidget {
  bool news_loader;
  bool showIndicator = true;
  News({super.key, required this.news_loader});

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 5),(){showIndicator = false;});
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          appBar: Appbar_user("Recent News", context),
          endDrawerEnableOpenDragGesture: true,
          //drawerScrimColor: white,
          endDrawer: Drawerlist(context),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Image.asset("assets/News/news1.png"),
                  Consumer<MainProvider>(
                      builder: (newsPHOTOcontext,value,child) {
                      print(value.news_image);
                      print(showIndicator);
                      return Visibility(
                        visible: value.user_newsmap["photo"].toString() != "" ?true:false,
                        child: Container(
                          width: width,
                            height: 150,
                          child: Center(
                            child: value.newsloader == true ?SizedBox(height: 50, width: 50,
                                child: CircularProgressIndicator(color: maingreen,)):
                            value.news_image != "" ?
                            SizedBox(
                                width: width,
                                height: 150,
                                child: Image.network(value.news_image,fit: BoxFit.fill,)):
                            null,
                          )
                        ),
                        // child: SizedBox(
                        //   width: width,
                        //   height: 150,
                        //   child: value.newsloader == true ? Container(height: 10, width: 10,
                        //       child: CircularProgressIndicator(color: maingreen,)):
                        //    value.news_image != "" ? Image.network(value.news_image,fit: BoxFit.fill,):
                        //   // value.newsloader == true ?
                        //   // SizedBox(height: 50, width: 50,
                        //   //     child: CircularProgressIndicator(color: maingreen,)) :
                        //     null
                        //   //child: value.news_image != "" ? Image.network(value.news_image,fit: BoxFit.fill,): null ,
                        // ),
                      );
                    }
                  ),
                  sizebox(),
                  // Page_content("Nursing Home Wait List Hits Record High "
                  //     "And Is Now Holding Up 500 Hospital Beds.", 20, FontWeight.bold, maingreen),
                  Consumer<MainProvider>(
                      builder: (headlinecontext,value,child) {
                      return Page_content(value.user_newsmap["headline"].toString(), 20, FontWeight.bold, maingreen);
                    }
                  ),
                  Consumer<MainProvider>(
                      builder: (newsDATEcontext,value,child)
                      {
                      return Page_content(
                          value.news_date, 15, FontWeight.bold, Colors.black45);
                    }
                  ),
                  Divider(color: maingreen,thickness: 1,),
                  Consumer<MainProvider>(
                      builder: (newsdesc_context,value,child) {
                      return Card(
                        elevation: 3,
                          color: userlightblue,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Page_content(value.user_newsmap['newsdescription'].toString(), 13, FontWeight.w600, black),
                          ));
                    }
                  ),
                  sizebox()
                ],
              ),
            ),
          ),
        ));
  }
}
