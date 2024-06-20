import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constants/Call_Functions.dart';
import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import '../../Provider/Main_Provider/MainProvider.dart';
import 'MainAdminNewsList.dart';

class NewDescription_MainAdmin extends StatelessWidget {
  String ID,from;
  NewDescription_MainAdmin({super.key, required this.ID,required this.from});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    MainProvider provider = Provider.of(context, listen: false);

    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: Appbar_MainAdmin("News", context),
        endDrawerEnableOpenDragGesture: true,
        //drawerScrimColor: white,
        endDrawer: Drawerlist(context),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Consumer<MainProvider>(
                      builder: (context,value,child) {
                        //print(value.newsdescriptioncontroller);
                        return Container(
                          height: 175,
                          width: 250,
                          color: mainAdminfldclr,

                          child: value.news_fileimg!=null ?
                          Image.file(value.news_fileimg!,fit: BoxFit.fill,) :
                          value.news_Image_url!=""?Image.network(value.news_Image_url,fit: BoxFit.fill,) :
                          Icon(Icons.camera_alt_outlined),
                        );
                      }
                    ),
                  ),
                  sizebox(),
                  Page_content("Upload Image", 14, FontWeight.w600, black),
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
                    child: Consumer<MainProvider>(
                      builder: (context, value, child) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: InkWell(
                            onTap: (){showBottomSheet(context);},
                            child: Container(

                                height: 30,
                                width: width/2.5,
                                alignment: Alignment.center,
                                //color: Colors.yellow,
                                decoration: BoxDecoration(border: Border.all(color: txtfrmbordercolor)),
                                child: Page_content("Choose File", 14, FontWeight.w500, black)),
                          ),
                        );
                      }
                    ),

                  ),
                  sizebox(),
                  sizebox(),
                  Page_content("News Headline", 14, FontWeight.w600, black),
                  Consumer<MainProvider>(
                    builder: (context, value, child) {
                      return Txtformfield("",value.newsheadlinecontroller);
                    }
                  ),
                  sizebox(),
                  Consumer<MainProvider>(
                    builder: (context, value, child) {
                      return Visibility(
                        visible: from == "New"? false : true,
                          child: Textformfield_date("Select Date", value.newsdatecontroller,context));
                    }
                  ),
                  Page_content("Description", 14, FontWeight.w600, black),
                  Consumer<MainProvider>(
                    builder: (context, value, child) {
                      return TxtformfieldDescription("", value.newsdescriptioncontroller);
                    }
                  ),
                  sizebox(),
                  Container(
                    width: width,
                    alignment: Alignment.centerRight,
                    child: MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate())
                        {
                          provider.AddNews(context, ID, from);
                          provider.getNewsDetails();
                          //back(context);
                        }

                      },
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
        ),


      ),
    );
  }
}

void showBottomSheet(BuildContext context) {
  MainProvider provider =Provider.of<MainProvider>(context,listen: false);

  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          )),
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[
            ListTile(
                leading:  Icon(
                  Icons.camera_enhance_sharp,
                  color: maingreen,
                ),
                title: const Text('Camera',),
                onTap: () => {provider.getImagecamera("News"), Navigator.pop(context)}),
            ListTile(
                leading:  Icon(Icons.photo, color: maingreen),
                title: const Text('Gallery',),
                onTap: () => {provider.getImage("News"),Navigator.pop(context)}),
          ],
        );
      });
  //ImageSource
}
