import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Constants/Call_Functions.dart';
import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import '../../Provider/Main_Provider/MainProvider.dart';
import 'MAaddEvents.dart';

class AddSpeakers extends StatelessWidget {
   AddSpeakers({super.key});

   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   final FocusNode _textFocusNode1 = FocusNode();
   final FocusNode _textFocusNode2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    String from = "New";
    String ID = "";
    MainProvider provider = Provider.of(context, listen: false);
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: Appbar_MainAdmin("Speakers", context),
        endDrawerEnableOpenDragGesture: true,
        //drawerScrimColor: white,
        endDrawer: Drawerlist(context),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Card(
                    child: Container(
                      height: 220,
                      width: width,
                      //color: textformcolor,
                      decoration: BoxDecoration(color: textformcolor,
                          border: Border.all(color: txtfrmbordercolor,),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0,top: 15,right: 10),
                        child:  Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Page_content("Speakers", 14, FontWeight.w600, black),
                                    Consumer<MainProvider>(
                                        builder: (context,value,child) {
                                        return Container(

                                          height: 120,
                                          width: 100,
                                          decoration: BoxDecoration(color: mainAdminfldclr,
                                            image: DecorationImage(
                                                image: value.Speaker_fileimg!=null ?
                                                FileImage(value.Speaker_fileimg!):
                                                value.Speaker_Image_url!=""? NetworkImage(value.Speaker_Image_url) :
                                                AssetImage("assets/icons/userblack.png") as ImageProvider ,
                                                fit: BoxFit.fill
                                            ),),
                                          alignment: Alignment.bottomRight,
                                          child: InkWell(
                                            onTap: (){showBottomSheet(context);},
                                            child: Container(
                                              color: adminblue,
                                              height: 40,
                                              width: 40,
                                              child: Icon(Icons.add,color: Colors.white,),
                                            ),
                                          ),
                                        );
                                      }
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Page_content("Name", 14, FontWeight.w600, black),
                                      Consumer<MainProvider>(
                                          builder: (context, value, child) {
                                            //return Txtformfield("", value.speakernamecontroller);
                                            return Padding(
                                              padding: const EdgeInsets.only(bottom: 10),
                                              child: TextFormField(
                                                focusNode: _textFocusNode1,
                                                controller: value.speakernamecontroller,
                                                validator: (value)
                                                {
                                                  if (value == null || value.isEmpty) {return "*Required field";}
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText: "",
                                                  hintStyle: GoogleFonts.karma(textStyle:
                                                  const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: black,)),
                                                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                                  filled: true,
                                                  fillColor: textformcolor,
                                                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: txtfrmbordercolor)),
                                                  disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: txtfrmbordercolor)),
                                                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: txtfrmbordercolor)),
                                                  errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                                  focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                                ),
                                              ),
                                            );
                                          }
                                      ),
                                      Page_content("Designation", 14, FontWeight.w600, black),
                                      Consumer<MainProvider>(
                                          builder: (context, value, child) {
                                            //return Txtformfield("", value.speakerDesignationcontroller);
                                            return Padding(
                                              padding: const EdgeInsets.only(bottom: 10),
                                              child: TextFormField(
                                                focusNode: _textFocusNode2,
                                                controller: value.speakerDesignationcontroller,
                                                validator: (value)
                                                {
                                                  if (value == null || value.isEmpty) {return "*Required field";}
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText: "",
                                                  hintStyle: GoogleFonts.karma(textStyle:
                                                  const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: black,)),
                                                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                                  filled: true,
                                                  fillColor: textformcolor,
                                                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: txtfrmbordercolor)),
                                                  disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: txtfrmbordercolor)),
                                                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: txtfrmbordercolor)),
                                                  errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                                  focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                                ),
                                              ),
                                            );
                                          }
                                      ),

                                    ],
                                  ),
                                )
                              ],
                            )

                      ),
                    ),
                  ),
                  sizebox(),
                  Container(
                    width: width,
                    alignment: Alignment.centerRight,
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      onPressed: ()
                      {
                        if (_formKey.currentState!.validate())
                        {
                          provider.Add_Speaker(context, ID, from);
                          from = "New";
                          _textFocusNode1.unfocus();
                          _textFocusNode2.unfocus();
                        }
                      },
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: adminblue,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5,left: 10,right: 10),
                        child: Page_content("Add Speaker", 18, FontWeight.bold, Colors.white),
                      ),
                    ),
                  ),
                  sizebox(),
                  SizedBox(
                    child: Consumer<MainProvider>(
                        builder: (ctx,value,child) {

                          return ListView.builder(
                              physics:  NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: value.Speaker_list.length,
                              itemBuilder: (BuildContext ctx, int index)
                              {
                                //evnt_date = value.EventDaysdetails_list_MP[index].date.toString();
                                //evnt_date = outputDateFormat.format(value.EventDaysdetails_list_MP[index].date);
                                return Card(
                                  elevation: 5,
                                  child: Container(
                                    //color: textformcolor,
                                    decoration: BoxDecoration(
                                        //color: textformcolor,
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 120,
                                            width: 100,
                                            child: value.Speaker_list[index].speaker_photo != "" ?
                                                Image.network(value.Speaker_list[index].speaker_photo!,fit: BoxFit.fill, ) :
                                                Image.asset("assets/icons/userblack.png", fit: BoxFit.fill,)
                                            //Image.file(value.Speaker_list[index].speaker_photo!,fit: BoxFit.fill,) :,
                                          ),
                                          Column(
                                            children: [
                                              Page_content(value.Speaker_list[index].name, 15, FontWeight.w600, Colors.black),
                                              Page_content(value.Speaker_list[index].designation, 15, FontWeight.w600, Colors.black),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                      alignment: Alignment.bottomRight,
                                                      onPressed: ()
                                                      {
                                                        from = "Edit";
                                                        ID = value.Speaker_list[index].id;
                                                        value.update_SpeakerDetails(value.Speaker_list[index].id);

                                                      },
                                                      icon: Icon(Icons.edit_square,size: 20,),
                                                      padding: EdgeInsets.zero),
                                                  IconButton(
                                                      alignment: Alignment.bottomLeft,
                                                      onPressed: ()
                                                      {
                                                        value.Delete_Speakeralert(context,"Do you want to delete this Speaker?",value.Speaker_list[index].id);
                                                        //value.get_SpeakerDetails();
                                                      },
                                                      icon: Icon(Icons.delete, color: Colors.red,size: 20,),
                                                      padding: EdgeInsets.zero),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                          );
                        }
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
                  color: adminblue,
                ),
                title: const Text('Camera',),
                onTap: () => {provider.getImagecamera("Speaker"), Navigator.pop(context)}),
            ListTile(
                leading:  Icon(Icons.photo, color: adminblue),
                title: const Text('Gallery',),
                onTap: () => {provider.getImage("Speaker"),Navigator.pop(context)}),
          ],
        );
      });
  //ImageSource
}
