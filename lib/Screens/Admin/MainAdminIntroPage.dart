import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';

class MainAdminIntroPage extends StatelessWidget {
  const MainAdminIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: Appbar_MainAdmin("Intro", context),
        endDrawerEnableOpenDragGesture: true,
        //drawerScrimColor: white,
        endDrawer: Drawerlist(context),
        
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Page_content("Upload Introduction Video", 20, FontWeight.bold, black),
              sizebox(),
              Container(
                height: 170,
                width: 275,
                color: Colors.black,
                child: Icon(Icons.play_circle_outlined, color: Colors.white,size: 40),
              ),
              sizebox(),
              sizebox(),
              Container(
                //color: textformcolor,
                height: 45,
                width: width,
                decoration: BoxDecoration(
                    border: Border.all(color: txtfrmbordercolor,),
                    color: textformcolor,
                    borderRadius:BorderRadius.circular(5)
                ),
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(

                      height: 30,
                      width: width/2.5,
                      alignment: Alignment.center,
                      //color: Colors.yellow,
                      decoration: BoxDecoration(border: Border.all(color: txtfrmbordercolor)),
                      child: Page_content("Choose File", 14, FontWeight.w500, black)),
                ),

              ),
              SizedBox(height: 50,),
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
                    child: Page_content("Save", 18, FontWeight.bold, Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
