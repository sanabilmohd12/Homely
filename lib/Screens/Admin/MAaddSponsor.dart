import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homely/Provider/Main_Provider/MainProvider.dart';
import 'package:provider/provider.dart';

import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';

class MAaddSponsor extends StatelessWidget {
  String ID,from;
  MAaddSponsor({super.key, required this.ID,required this.from});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of(context, listen: false);
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: Appbar_MainAdmin("Sponsors", context),
        endDrawerEnableOpenDragGesture: true,
        //drawerScrimColor: white,
        endDrawer: Drawerlist(context),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Consumer<MainProvider>(
                          builder: (context, value, child) {
                            return Container(

                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(color: mainAdminfldclr,
                                  image: DecorationImage(
                                      image: value.Sponsor_fileimg!=null ?
                                      FileImage(value.Sponsor_fileimg!):
                                      value.Sponsor_Image_url!=""? NetworkImage(value.Sponsor_Image_url) :
                                      AssetImage("assets/icons/userblack.png") as ImageProvider ,
                                      fit: BoxFit.fill
                                  )
                                  //image: DecorationImage(image: AssetImage("assets/icons/Usericon.png"))
                              ),
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: ()
                                {
                                  showBottomSheet(context);
                                },
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
                      ),
                      SizedBox(height: 20,),
                      Page_content("Site Link", 14, FontWeight.w600, black),
                      Consumer<MainProvider>(
                        builder: (context, value, child) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              keyboardType: TextInputType.url,
                              validator: (value)
                              {
                                if (value == null || value.isEmpty) {return "*Required field";}
                                return null;
                              },
                              controller: value.sponsorlinkcontroller,
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
                          //return Txtformfield_link("", value.sponsorlinkcontroller);
                        }
                      ),
                    ],
                  ),
                  Container(
                    width: width,
                    alignment: Alignment.centerRight,
                    child: MaterialButton(
                      onPressed: ()
                      {
                        if (_formKey.currentState!.validate())
                        {
                          provider.Add_Sponsor(context, ID, from);
                          provider.get_SponsorDetails();
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
                  color: adminblue,
                ),
                title: const Text('Camera',),
                onTap: () => {provider.getImagecamera("Sponsor"), Navigator.pop(context)}),
            ListTile(
                leading:  Icon(Icons.photo, color: adminblue),
                title: const Text('Gallery',),
                onTap: () => {provider.getImage("Sponsor"),Navigator.pop(context)}),
          ],
        );
      });
  //ImageSource
}
