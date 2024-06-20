import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import '../../Provider/Main_Provider/MainProvider.dart';

class MainAdminBoardMmbrDetails extends StatelessWidget {
  String ID,from;

  MainAdminBoardMmbrDetails({super.key, required this.ID,required this.from});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of(context, listen: false);
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: Appbar_MainAdmin("Board Members", context),
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
                      builder: (ctx1, value, child) {
                        //print('helloooooooo');
                        //print(value);
                        //print(value.BM_Image_url);
                        //print(value.BM_fileimg.toString()+"dydyydydy");
                        return Container(
                          height: 125,
                          width: 125,
                          decoration: BoxDecoration(color: mainAdminfldclr,

                              image: DecorationImage(
                                  image: value.BM_fileimg!=null ?
                                  FileImage(value.BM_fileimg!):
                                value.BM_Image_url!=""? NetworkImage(value.BM_Image_url) :
                              AssetImage("assets/icons/userblack.png") as ImageProvider ,
                                  fit: BoxFit.fill
                              )
                          ),
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
                  ),
                  SizedBox(height: 20,),
                  Page_content("Name", 14, FontWeight.w600, black),
                  Consumer<MainProvider>(
                      builder: (ctx2, value, child) {
                        return Txtformfield("",value.BM_namecontroller);
                      }
                  ),
                  Page_content("Title", 14, FontWeight.w600, black),
                  Consumer<MainProvider>(
                    builder: (ctx3, value, child) {
                      return Txtformfield("",value.BM_titlecontroller);
                    }
                  ),
                  //sizebox(),
                  Page_content("Description", 14, FontWeight.w600, black),
                  Consumer<MainProvider>(
                      builder: (ctx4, value, child) {
                      return TxtformfieldDescription("", value.BM_descriptioncontroller);
                    }
                  ),
                  //sizebox(),
                  Page_content("Mobile", 14, FontWeight.w600, black),
                  Consumer<MainProvider>(
                    builder: (context, value, child) {
                      return Txtformfield_number("",value.BM_phonecontroller);
                    }
                  ),
                  //sizebox(),
                  Page_content("Email", 14, FontWeight.w600, black),
                  Consumer<MainProvider>(
                    builder: (context, value, child) {
                      return Txtformfield_email("", value.BM_emailcontroller);
                    }
                  ),
                  //sizebox(),
                  Page_content("FaceBook Link", 14, FontWeight.w600, black),
                  Consumer<MainProvider>(
                      builder: (context, value, child) {
                      return Txtformfield_link("", value.BM_FBcontroller);
                    }
                  ),
                  //sizebox(),
                  Page_content("LinkedIn Link", 14, FontWeight.w600, black),
                  Consumer<MainProvider>(
                      builder: (context, value, child) {
                      return Txtformfield_link("", value.BM_LinkedIncontroller);
                    }
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: width,
                    alignment: Alignment.centerRight,
                    child: MaterialButton(
                      onPressed: ()
                      {
                        if (_formKey.currentState!.validate())
                        {
                          provider.Add_BoardMember(context, ID, from);
                          provider.get_BMDetails();
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
                  color: adminblue,
                ),
                title: const Text('Camera',),
                onTap: () => {provider.getImagecamera("BM"), Navigator.pop(context)}),
            ListTile(
                leading:  Icon(Icons.photo, color: adminblue),
                title: const Text('Gallery',),
                onTap: () => {provider.getImage("BM"),Navigator.pop(context)}),
          ],
        );
      });
  //ImageSource
}