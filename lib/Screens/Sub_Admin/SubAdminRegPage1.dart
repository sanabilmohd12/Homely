import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homely/Constants/Call_Functions.dart';
import 'package:provider/provider.dart';

import '../../Constants/Colors.dart';
import '../../Constants/DropdownLists.dart';
import '../../Constants/MyWidgets.dart';
import '../../Provider/Main_Provider/SubAdmin_Provider.dart';
import 'SubAdminRegPage2.dart';

class SubAdminRegPage1 extends StatelessWidget {
  String ID, from, userID;
  SubAdminRegPage1({super.key, required this.ID, required this.from, required this.userID});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          backgroundColor: subadminBG,
          appBar: Appbar_SubAdmin("Care Home Profile","Stage 1", context),
          //endDrawerEnableOpenDragGesture: true,
          //drawerScrimColor: white,
          //endDrawer: Drawerlist(context),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'Showcase Your Special Care Home With',
                          style: GoogleFonts.karma(
                              textStyle: const TextStyle(height: 1,fontSize: 22,fontWeight: FontWeight.w600,color: Colors.black)),
                          children: <TextSpan>[
                            TextSpan(text: ' Homely',
                                style: GoogleFonts.kaushanScript(textStyle: const TextStyle(
                                    shadows: [
                                      Shadow(
                                        color: Colors.black45,      // Choose the color of the shadow
                                        blurRadius: 1.0,          // Adjust the blur radius for the shadow effect
                                        offset: Offset(1.0, 1.0), // Set the horizontal and vertical offset for the shadow
                                      ),
                                    ],
                                    fontSize: 25),
                                )

                            )
                          ]
                      ),
                    ),
                    sizebox(),

                    Page_content("*Required Fields", 15, FontWeight.w400, black),
                    Consumer<SubAdmin_Provider>(
                      builder: (context1,value, child) {
                        return Txtformfield("Special Care Home Name *",value.SA_carehomenamecontroller);
                      }
                    ),
                    Consumer<SubAdmin_Provider>(
                      builder: (context2,value, child) {
                        return Txtformfieldaddress("Address *", value.SA_carehome_addresscontroller);
                      }
                    ),
                    Consumer<SubAdmin_Provider>(
                      builder: (context3,value, child) {
                        return Txtformfield_pincode("Postal Code *", value.SA_carehome_pincodecontroller);
                      }
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Consumer<SubAdmin_Provider>(
                              builder: (context4,value,child) {
                              return AutoCompleteDropdown(width, value.SA_carehome_districtcontroller);
                            }
                          ),
                          //Dropdown(District ,"District *", width),
                          //Dropdown(States,"State *", width),
                        ],
                      ),
                    ),
                    Consumer<SubAdmin_Provider>(
                      builder: (context5,value,child) {
                        return Txtformfield("Contact Person *", value.SA_carehome_cntctPersonNamecontroller);
                      }
                    ),
                    Consumer<SubAdmin_Provider>(
                      builder: (context6, value, child) {
                        return Txtformfield_email("Email *", value.SA_carehome_emailcontroller);
                      }
                    ),
                    Consumer<SubAdmin_Provider>(
                      builder: (context7, value, child) {
                        return Txtformfield_number("Phone Number *", value.SA_carehome_phonecontroller);
                      }
                    ),

                    Consumer<SubAdmin_Provider>(
                        builder: (context8, value, child) {
                        return Container(
                          width: width,
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: ()
                              {
                                if (_formKey.currentState!.validate())
                                  {
                                    value.Add_CareHome_P1(context, ID, from, userID);
                                    value.updateCareHomeDetails(ID, from);
                                    //value.get_CareHome_Details();

                                  }
                                },
                              child: Text("Save & Continue",
                                  style: GoogleFonts.karma(textStyle:
                                  const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: linkcolor,
                                      decoration: TextDecoration.underline,decorationColor: linkcolor)),
                              )
                          ),
                        );
                      }
                    )

                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
