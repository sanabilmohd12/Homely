import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Constants/Call_Functions.dart';
import '../../Constants/Colors.dart';
import '../../Constants/DropdownLists.dart';
import '../../Constants/MyWidgets.dart';
import '../../Provider/Main_Provider/SubAdmin_Provider.dart';
import 'SubAdminRegPage3.dart';

class SubAdminRegPage2 extends StatelessWidget {
  String ID, from, userID;
  SubAdminRegPage2({super.key, required this.ID, required this.from, required this.userID});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
print("$ID, $from, $userID");
    String dropdownvalue = '';

    return SafeArea(
      child: Scaffold(
        backgroundColor: subadminBG,
        appBar: Appbar_SubAdmin("Care Home Profile","Stage 2", context),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<SubAdmin_Provider>(
                    builder: (context, value, child) {
                      return Txtformfield_pincode("Number of Beds Available *", value.SA_carehome_bedcountcontroller);
                    }
                  ),
                  Consumer<SubAdmin_Provider>(
                    builder: (context, value, child) {
                      return Txtformfield_pincode("Maximum no: of Licensed Bed *", value.SA_CH_liscencedbedcontroller);
                    }
                  ),
                  Consumer<SubAdmin_Provider>(
                      builder: (dropcontext1, value, child) {
                        return DropDownFormField_carelevel(value.selectedval_carelevel, CareLevel, "Level Of Care *", width, dropcontext1);
                      }
                  ),
                  Consumer<SubAdmin_Provider>(
                      builder: (dropcontext2, value, child) {
                        return DropDownFormField_facility(value.selectedval_facility, Facility,"Facilities *", width, dropcontext2);
                      }
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 10.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //        //Dropdown(CareLevel,"Level Of Care *", width),
                  //       // Dropdown(Facility,"Facilities *", width),
                  //
                  //     ],
                  //   ),
                  // ),
                  Consumer<SubAdmin_Provider>(
                    builder: (context9, value, child) {
                      return TxtformfieldDescription("Description of Home and Services to the Public.",value.SA_carehome_descriptioncontroller);
                    }
                  ),
                  Consumer<SubAdmin_Provider>(
                    builder: (context10, value, child) {
                      return Txtformfield_comments("Notes/Comments for Admin.", value.SA_carehome_commentscontroller);
                    }
                  ),
                  Page_content("*Upload Pictures of Care Home in landscape format.", 14, FontWeight.w500, black),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Consumer<SubAdmin_Provider>(
                        builder: (context11, value, child) {
                          //print("value.image_list.length111111111111111111111111111 ${value.image_list.length}");
                        return Visibility(
                          visible: value.HomeImage_List.isEmpty?value.image_list.isEmpty?false:true:true,
                          child: SizedBox(
                            height: 100,
                            child: value.HomeImage_List.isNotEmpty?
                              ListView.builder(
                                //physics:  NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: value.HomeImage_List.length,
                                itemBuilder: (BuildContext context, int index)
                                {
                                  // print("Listview builder if home_image_list is not empty");
                                  // print(value.HomeImage_List.length.toString()+" ccccccccccccccccccc");
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(border: Border.all(color: txtfrmbordercolor)),
                                      child: InkWell(
                                        onTap: (){Image_alert(context,index);},
                                          child: Image.asset(value.Home_pics_new[index], fit: BoxFit.fill,)),
                                    ),
                                  );
                                }
                            ) :
                            value.image_list.isNotEmpty?
                            ListView.builder(
                              //physics:  NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: value.Home_pics_new.length,
                                itemBuilder: (BuildContext context, int index)
                                {
                                  // print("Listview builder if image_list is not empty");
                                  // print(value.image_list.length.toString()+" dddddddddddddddddddddddd");
                                  return Card(
                                    child: InkWell(
                                        onTap: (){Image_alert(context,index);},
                                        child: Image.network(value.Home_pics_new[index], fit:  BoxFit.fill,)),
                                  );
                                }
                            ):null,
                          ),
                        );
                      }
                    ),
                  ),
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
                      child: InkWell(
                        onTap: (){showBottomSheet(context,from);},
                        child: Container(

                            height: 30,
                            width: width/2.5,
                            alignment: Alignment.center,
                            //color: Colors.yellow,
                            decoration: BoxDecoration(border: Border.all(color: txtfrmbordercolor)),
                            child: Page_content("Upload Images", 14, FontWeight.w500, black)),
                      ),
                    ),

                  ),
                  //sizebox(),
                  SizedBox(height: 9,),
                  Consumer<SubAdmin_Provider>(
                      builder: (context, value, child) {
                      return Txtformfield_link("Virtual Tour Youtube Link", value.SA_CH_youtubecontroller);
                    }
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width : width/2.5,
                          child: Consumer<SubAdmin_Provider>(
                              builder: (context, value, child) {
                              return Txtformfield_link("FaceBook Link", value.SA_CH_FBcontroller);
                            }
                          )),
                      SizedBox(width : width/2.5,
                          child: Consumer<SubAdmin_Provider>(
                              builder: (context, value, child) {
                              return Txtformfield_link("Instagram Link", value.SA_CH_Instacontroller);
                            }
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width : width/2.5,
                          child: Consumer<SubAdmin_Provider>(
                              builder: (context, value, child) {
                              return Txtformfield_link("Twitter Link", value.SA_CH_twittercontroller);
                            }
                          )),
                      SizedBox(width : width/2.5,
                          child: Consumer<SubAdmin_Provider>(
                              builder: (context, value, child) {
                              return Txtformfield_link("Website Link", value.SA_CH_Websitecontroller);
                            }
                          )),
                    ],
                  ),
                  Container(
                    width: width,
                    alignment: Alignment.centerRight,
                    child: Consumer<SubAdmin_Provider>(
                        builder: (context3, value, child) {
                        return TextButton(
                            onPressed: ()
                            {
                              if (_formKey.currentState!.validate())
                              {
                                value.Add_CareHome_P2(context,ID, from, userID);
                                value.updateCareHomeDetails(ID, from);
                                //value.updateCareHomeDetails(ID, from);
                                //value.get_CareHome_Details();

                              }
                              },
                            child: Text("Save & Continue",
                              style: GoogleFonts.karma(textStyle:
                              const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: linkcolor,
                                  decoration: TextDecoration.underline,decorationColor: linkcolor)),
                            )
                        );
                      }
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
void showBottomSheet(BuildContext context, String from) {
  SubAdmin_Provider sub_provider = Provider.of(context, listen: false);

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
                title: Page_content("Camera", 15, FontWeight.bold, Colors.black),
                onTap: () => {sub_provider.getImagecamera(from), Navigator.pop(context)}),
            ListTile(
                leading:  Icon(Icons.photo, color: maingreen),
                title: Page_content("Gallery", 15, FontWeight.bold, Colors.black),
                onTap: () => {sub_provider.getImage(from),Navigator.pop(context)}),
          ],
        );
      });
  //ImageSource
}
