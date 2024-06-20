import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homely/Constants/Colors.dart';

import '../../Constants/MyWidgets.dart';
import '../../Provider/Main_Provider/MyProvider.dart';

class Faq extends StatelessWidget {
  const Faq({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: Appbar_user("FAQ", context),
        endDrawerEnableOpenDragGesture: true,
        //drawerScrimColor: white,
        endDrawer: Drawerlist(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Page_content("What questions should I ask operators "
                    "when enquiring about a placement?", 20, FontWeight.bold, maingreen),
                Divider(color: maingreen,thickness: 1,),
                Page_content("When enquiring about a placement, always make "
                  "sure to ask essential questions before deciding."
                  "Here are some questions you should consider:", 15, FontWeight.w600, black),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Page_content(faq, 15, FontWeight.w500, black),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
