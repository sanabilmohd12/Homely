import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homely/Constants/Call_Functions.dart';
import 'package:homely/Provider/Main_Provider/MainProvider.dart';
import 'package:homely/Provider/Main_Provider/SubAdmin_Provider.dart';
import 'package:homely/Screens/Sub_Admin/paymentpage.dart';
import 'package:provider/provider.dart';

import '../../Constants/CarehomeFacilityList.dart';
import '../../Constants/Colors.dart';
import '../../Constants/DropdownLists.dart';
import '../../Constants/MyWidgets.dart';
import '../Admin/MainAdminHomePage.dart';
import 'alert.dart';

class SubAdminRegPage3 extends StatelessWidget {
  String ID, from, userID;
  SubAdminRegPage3({super.key, required this.ID, required this.from, required this.userID});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SubAdmin_Provider sub_provider = Provider.of(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: subadminBG,
        appBar: Appbar_SubAdmin("Care Home Profile","Stage 3", context),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Page_content("PLEASE CHECK THE BOXES IF YOU ANSWER YES "
                    "TO ANY OF THE FOLLOWING QUERIES :", 15, FontWeight.w600, black),
                Container(
                  padding: EdgeInsets.all(10),
                  color: white,
                  height: height/2,
                  width: width,
                  child : Consumer<SubAdmin_Provider>(
                      builder: (dropcontext, value, child) {
                      return ListView.builder(shrinkWrap: true,
                          itemCount: facilityList.length,
                          itemBuilder: (BuildContext context, int index)
                          {
                            return Row(
                              children: [
                                Checkbox(
                                  value: facilityList[index].isChecked,
                                  onChanged: ( value)
                                  {
                                    sub_provider.onCheckboxChanged(value, index);
                                  },
                                  activeColor: Colors.blue, // Change the checkbox color when checked
                                  checkColor: Colors.white, // Change the checkmark color
                                ),
                                Expanded(child: Page_content(facilityList[index].facilities, 14, FontWeight.w500, black))
                              ],
                            );
                          });
                    }
                  )
                ),
                sizebox(),
                Page_content("PLEASE CLICK NEXT TO SENT REQUEST:", 15, FontWeight.w600, black),
                // Dropdown_Payment(PaymentOption,"Select *", width),
                Consumer<SubAdmin_Provider>(
                    builder: (paymentcontext, value, child) {
                    return DropDownFormField_payment(value.selected_payment, PaymentOption, "Select *", width, paymentcontext);
                  }
                ),
                sizebox(),
                Consumer<SubAdmin_Provider>(
                  builder: (context,value,child) {
                    return Txtformfield("Payment Info",value.SA_carehome_payinfocontroller);
                  }
                ),

                Consumer<MainProvider>(
                  builder: (context, value, child) {


                    return Container(
                      width: width,
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        onPressed: ()
                        {
                          sub_provider.Add_CareHome_P3(context, ID, from);
                          sub_provider.get_CareHome_Details();
                          callNext(context, paymentPage());
                          // value.razorpayGateway();
                          },
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: maingreen,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Page_content("Next", 18, FontWeight.bold, Colors.white),
                        ),
                      ),
                    );
                  }
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
