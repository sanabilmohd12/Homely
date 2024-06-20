import 'dart:collection';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homely/Constants/Colors.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../Constants/Call_Functions.dart';
import '../../Constants/CarehomeFacilityList.dart';
import '../../Constants/MyWidgets.dart';
import '../../Model_Class/model_class.dart';
import '../../Screens/Sub_Admin/SubAdminRegPage1.dart';
import '../../Screens/Sub_Admin/SubAdminRegPage2.dart';
import '../../Screens/Sub_Admin/SubAdminRegPage3.dart';

class SubAdmin_Provider extends ChangeNotifier {

  FirebaseFirestore db = FirebaseFirestore.instance;

  firebase_storage.Reference ref = FirebaseStorage.instance.ref("HomeImages");

  TextEditingController SA_carehomenamecontroller = TextEditingController();
  TextEditingController SA_carehome_cntctPersonNamecontroller = TextEditingController();
  TextEditingController SA_carehome_emailcontroller = TextEditingController();
  TextEditingController SA_carehome_phonecontroller = TextEditingController();
  TextEditingController SA_carehome_payinfocontroller = TextEditingController();
  TextEditingController SA_carehome_addresscontroller = TextEditingController();
  TextEditingController SA_carehome_pincodecontroller = TextEditingController();
  TextEditingController SA_carehome_districtcontroller = TextEditingController();
  TextEditingController SA_carehome_bedcountcontroller = TextEditingController();
  TextEditingController SA_CH_liscencedbedcontroller = TextEditingController();
  TextEditingController SA_carehome_descriptioncontroller = TextEditingController();
  TextEditingController SA_carehome_commentscontroller = TextEditingController();
  TextEditingController SA_CH_youtubecontroller = TextEditingController();
  TextEditingController SA_CH_FBcontroller = TextEditingController();
  TextEditingController SA_CH_Instacontroller = TextEditingController();
  TextEditingController SA_CH_twittercontroller = TextEditingController();
  TextEditingController SA_CH_Websitecontroller = TextEditingController();

  List<CareHome> CareHomeList = [];
  List<CareHome> User_CareHomeList = [];
  List<CareHome> CareHome_RequestList = [];
  List<CareHome> CareHome_ApprovedList = [];
  List<String> CareHomeNAME_ApprovedList = [];
  List<CareHome> MA_CareHome = [];

  List<String> image_list  = [];  //data is added while editing cAre home

  Map<dynamic, dynamic> MA_carehomemap = {};
  Map<dynamic, dynamic> user_carehomemap = {};

  String request_status = "NOT FINISHED";

  void showSA_addsnackbar(BuildContext context, Color clr) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text("Added Successfully", softWrap: true,
              style: GoogleFonts.karma(
                  textStyle: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)))),
          backgroundColor: clr,
          elevation: 5,
          behavior: SnackBarBehavior.floating,
          width: 300,)
    );
  }

  void showSA_updatesnackbar(BuildContext context, Color clr) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(
          child: Text("Updated Successfully", softWrap: true,
              style: GoogleFonts.karma(
                  textStyle: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)))),
      backgroundColor: clr,
      elevation: 5,
      behavior: SnackBarBehavior.floating,
      width: 300,)
    );
  }

  void show_deletesnackbar(BuildContext context, Color clr)        //DELETE SNACKBAR
  {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text("Deleted Successfully",softWrap: true,
              style: GoogleFonts.karma(
                  textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)))),
          backgroundColor: clr,
          elevation: 5,
          behavior: SnackBarBehavior.floating,
          width: 300,)
    );
    //ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }


  /////////////////////////////////PAGE 1/////////////////////////////////////////////////////////////

  void Add_CareHome_P1(BuildContext context, String homeId, String from, String userID)
   {
    String ID = DateTime.now().millisecondsSinceEpoch.toString();

    HashMap<String, Object> carehomemap_1 = HashMap();
    carehomemap_1["userID"] = userID;
    carehomemap_1["homename"] = SA_carehomenamecontroller.text;
    carehomemap_1["address"] = SA_carehome_addresscontroller.text;
    carehomemap_1["pincode"] = SA_carehome_pincodecontroller.text;
    carehomemap_1["district"] = SA_carehome_districtcontroller.text;
    carehomemap_1["state"] = "KERALA";
    carehomemap_1["contact_person"] = SA_carehome_cntctPersonNamecontroller.text;
    carehomemap_1["email"] = SA_carehome_emailcontroller.text;
    carehomemap_1["phone"] = SA_carehome_phonecontroller.text;
    carehomemap_1["approval_status"] = "NOT FINISHED";

    notifyListeners();

    if(from == "New")
    {
      carehomemap_1["phase"] = "1";
      db.collection("CARE_HOME").doc(ID).set(carehomemap_1);
      notifyListeners();
      //get_CareHome_Details();
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text("Added Successfully",softWrap: true,
                style: GoogleFonts.karma(
                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)))),
            backgroundColor: maingreen,
            elevation: 5,
            behavior: SnackBarBehavior.floating,
            width: 300,)
      );
    }
    else
    {

      db.collection("CARE_HOME").doc(homeId).update(carehomemap_1);
      get_CareHome_Details();
      notifyListeners();
      showSA_updatesnackbar(context,maingreen);

    }
    //clearCareHomedata();
    notifyListeners();
    callNextReplacement(context, SubAdminRegPage2(ID: homeId, from: from, userID: userID,));

  }

  void get_CareHome_Details()
  {
    db.collection("CARE_HOME").get().then((value)
    {
      if(value.docs.isNotEmpty)
      {
        CareHomeList.clear();

        for(var element in value.docs)
        {
          Map<dynamic,dynamic>map=element.data();
          if(map.containsKey("facility_list"))
          {
            map["facility_list"].forEach((key, value) {
              facilityList.add(Facility(value["isChecked"], value["facilities"]));
            });
          }
          if(map.containsKey("homeImage_list")) {
            if (map["homeImage_list"] != null || map["homeImage_list"] != "") {
              map["homeImage_list"].forEach((key, value) {
                image_list.add(value);
              });
            }
          }
          CareHomeList.add(
              CareHome(
                  element.id,
                  map["userID"],
                  map["homename"],
                  map["address"],
                  map["pincode"],
                  map["district"],
                  map["state"],
                  map["contact_person"],
                  map["email"],
                  map["phone"],
                  //phase 2
                  map["available_bed"] ?? "",
                  map["licensed_bed"] ?? "",
                  map["care_level"] ?? "",
                  map["facilities"] ?? "",
                  map["description"] ?? "",
                  map["comments"] ?? "",
                  image_list,
                  map["youtube"] ?? "",
                  map["facebook"] ?? "",
                  map["instagram"] ?? "",
                  map["twitter"] ?? "",
                  map["web"] ?? "",
                  //PHASE 3
                  facilityList,
                  map["Pay_option"]?? "",
                  map["Pay_info"]?? "",
                  map["approval_status"],
                  map["phase"],
              ));
          notifyListeners();
        }
      }
    });
    clearCareHomedata();
    notifyListeners();
  }

  // void user_newsclear()
  // {
  //   user_newsmap.clear();
  //   newsloader = true;
  //   notifyListeners();
  // }
  //
  void updateCareHomeDetails(String id, String from)
  {
    print("updateCareHomeDetails(String id, String from)");
    db.collection("CARE_HOME").doc(id).get().then((value)
    {
      if(value.exists)
      {
        clearCareHomedata();

        print("IMAGE_LIST LENGTH IN THE BEGINNING OF UPDATE FUNCTION IS ${image_list.length}");
        print("homeImage_list LENGTH IN THE BEGINNING OF UPDATE FUNCTION IS ${HomeImage_List.length}");
        MA_carehomemap.clear();
        user_carehomemap.clear();
        MA_carehomemap = value.data() as Map;
        user_carehomemap = value.data() as Map;
        Map<dynamic, dynamic> carehomemap = value.data() as Map;
        //carehomemap.forEach((key,value){print("$key : $value");});
        SA_carehomenamecontroller.text = carehomemap['homename'];
        SA_carehome_addresscontroller.text = carehomemap['address'];
        SA_carehome_pincodecontroller.text = carehomemap['pincode'];
        SA_carehome_districtcontroller.text = carehomemap['district'];
        SA_carehome_cntctPersonNamecontroller.text = carehomemap['contact_person'];
        SA_carehome_emailcontroller.text = carehomemap['email'];
        SA_carehome_phonecontroller.text = carehomemap['phone'];

        SA_carehome_bedcountcontroller.text = carehomemap["available_bed"]??"";
        SA_CH_liscencedbedcontroller.text =carehomemap["licensed_bed"]??"";
        selectedval_carelevel =carehomemap["care_level"];
        selectedval_facility =carehomemap["facilities"];
        SA_carehome_descriptioncontroller.text =carehomemap["description"]??"";
        SA_carehome_commentscontroller.text =carehomemap["comments"]??"";
        SA_CH_youtubecontroller.text =carehomemap["youtube"]??"";
        SA_CH_FBcontroller.text =carehomemap["facebook"]??"";
        SA_CH_Instacontroller.text =carehomemap["instagram"]??"";
        SA_CH_twittercontroller.text =carehomemap["twitter"]??"";
        SA_CH_Websitecontroller.text =carehomemap["web"]??"";
        selected_payment = carehomemap["pay_option"];
        SA_carehome_payinfocontroller.text = carehomemap["pay_info"]??"";
        List<Facility> facility = [];
        if(carehomemap.containsKey("facility_list"))
        {
          facilityList.clear();
          print("trUEEEEEEEEEEEEEEEEEEEEEEE");
          carehomemap["facility_list"].forEach((key, value) {

            facilityList.add(Facility(value["isChecked"], value["facilities"]));
            //facility.add(Facility(value["isChecked"], value["facilities"]));

          });
        }
        if(carehomemap.containsKey("homeImage_list"))
        {
          if (carehomemap["homeImage_list"] != null || carehomemap["homeImage_list"] != "") {
            carehomemap["homeImage_list"].forEach((key, value) {

              image_list.add(value);
              print("IMAGE_LIST LENGTH AFTER GETTING DATA FROM FIREBASE IN UPDATE FUNCTION IS ${image_list.length}");
              print("image_list.add(value); = ${image_list.length}");
            });
            // for(var x in image_list)
            //   {
            //     HomeImage_List.add(Image.network(x) as File);
            //   }
            // print("HomeImage_List.add(Image.network(x) as File);");
            // print(HomeImage_List.length);
          }
        }

        notifyListeners();
      }
    });
    notifyListeners();
  }

  void Delete_CareHomeAlert(BuildContext context, String txt, String id, String userid)     //DELETE ALERT BOX
  {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Page_content("ALERT", 20, FontWeight.bold, Colors.red),
        content: Page_content(
            "Do you want to delete this Care Home?", 16, FontWeight.bold, Colors.black),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              //DeleteStudent(context, id);
              //function;
              delete_CareHome(context, id, userid);
              Navigator.of(context).pop();

            },
            child: Container(
              color: Colors.green,
              padding: const EdgeInsets.all(14),
              child: Page_content("Yes", 16, FontWeight.bold, Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.all(14),
              child: Page_content("NO", 16, FontWeight.bold, Colors.black),
            ),
          ),
        ],
      ),
    );
    //getNewsDetails();
    notifyListeners();
  }

  delete_CareHome(BuildContext context, String homeid, String userid)
  {
    db.collection("CARE_HOME").doc(homeid).delete();
    notifyListeners();
    show_deletesnackbar(context,adminblue);
    find_UserCareHomes(userid);
    notifyListeners();
  }

  void clearCareHomedata()
  {
    SA_carehomenamecontroller.clear();
    SA_carehome_addresscontroller.clear();
    SA_carehome_pincodecontroller.clear();
    SA_carehome_districtcontroller.clear();
    SA_carehome_cntctPersonNamecontroller.clear();
    SA_carehome_emailcontroller.clear();
    SA_carehome_phonecontroller.clear();
    SA_carehome_bedcountcontroller.clear();
    SA_CH_liscencedbedcontroller.clear();
    selectedval_carelevel = null;
    selectedval_facility = null;
    SA_carehome_descriptioncontroller.clear();
    SA_carehome_commentscontroller.clear();
    SA_CH_youtubecontroller.clear();
    SA_CH_FBcontroller.clear();
    SA_CH_Instacontroller.clear();
    SA_CH_twittercontroller.clear();
    SA_CH_Websitecontroller.clear();
    SA_carehome_payinfocontroller.clear();
    selected_payment = null;
    facilityList = default_facilityList;
    //reset_facilityList();
    HomeImage_List.clear();
    image_list.clear();
    CareHomeList.clear();
    CareHome_ApprovedList.clear();
    CareHome_RequestList.clear();
    notifyListeners();
  }

  //////////////////////////////////////////PAGE 2/////////////////////////////////////
String? selectedval_carelevel;

void onSelected_carelevel(String? val)
{
  selectedval_carelevel = val;
  notifyListeners();
}

  String? selectedval_facility;

  void onSelected_facility(String? val)
  {
    selectedval_facility = val;
    notifyListeners();
  }

  List<File> HomeImage_List = [];
  //List<File> HomeImage_updateList = [];

  Future getImagecamera(String from)
  async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      cropImage(pickedImage.path,from);
    }
    else
    {
      print('No image selected.');
    }
  }

  Future getImage(String from)
  async {
    final imagePick = ImagePicker();
    final pickedImg = await imagePick.pickImage(source: ImageSource.gallery);

    if (pickedImg != null) {
      cropImage(pickedImg.path,from);
      //print(image.toString()+"jdhhd");
    } else {
      print('No image selected.');
    }
  }

  File? fileimg;
  String Image_url='';

  Future<void> cropImage(String path, String from) async
  {
    print(path);
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      fileimg = File(croppedFile.path);
      HomeImage_List.add(fileimg!);

      notifyListeners();
    }
  }

  Future<void> Add_CareHome_P2(BuildContext context, String homeId, String from, String userID )
  async {
    //String ID = DateTime.now().millisecondsSinceEpoch.toString();

    HashMap<String, Object> carehomemap_2 = HashMap();
    HashMap<String, Object> homeImagemap = HashMap();
if(from == "New") {
  if (HomeImage_List.isNotEmpty) {
    //print(HomeImage_List.length);
    print("HomeImage_List.isNotEmpty");
    int i = 0;
    for (File e in HomeImage_List) {
      print("for(File e in HomeImage_List){$i");
      i++;
      String img_key = "Image $i";
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();
      ref = firebase_storage.FirebaseStorage.instance.ref().child(photoId);
      //ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(e).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          print("img_key = $img_key");
          homeImagemap[img_key] = value;
          notifyListeners();
        });
        notifyListeners();
      });
    }

    notifyListeners();
  }
  else {
    int j = 0;
    for (var i in image_list) {
      j++;
      String imgKey = "Image $j";
      homeImagemap[imgKey] = i;
      // from=="New"?newsmap['photo'] = "":newsmap['photo'] = news_Image_url;
      notifyListeners();
      // editMap['IMAGE_URL'] = imageUrl;
    }
  }
}
else {
  print("EDIT...........................");
  int j = 0;
  print("length of image list is ${image_list.length}");
  for (var i in image_list) {
    j++;
    String imgKey = "Image $j";
    homeImagemap[imgKey] = i;
    // from=="New"?newsmap['photo'] = "":newsmap['photo'] = news_Image_url;
    notifyListeners();
    // editMap['IMAGE_URL'] = imageUrl;
    print("j = $j");
  }
  print("Exited for loop........");
  if (j == image_list.length){
    print("Entered j == image_list.length");
    if (HomeImage_List.isNotEmpty) {
      print(HomeImage_List.length);
      print("HomeImage_List.isNotEmpty");
      print("aaaaaaaaaaaaaaaaaaa");
      for (File e in HomeImage_List) {
        print("for(File e in HomeImage_List){$j");
        j++;
        String img_key = "Image $j";
        String photoId = DateTime
            .now()
            .millisecondsSinceEpoch
            .toString();
        ref = FirebaseStorage.instance.ref().child(photoId);
        await ref.putFile(e).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            print("img_key = $img_key");
            homeImagemap[img_key] = value;
            notifyListeners();
          });
          notifyListeners();
        });
      }

      notifyListeners();
    }
}
}
    carehomemap_2["available_bed"] = SA_carehome_bedcountcontroller.text;
    carehomemap_2["licensed_bed"] = SA_CH_liscencedbedcontroller.text;
    carehomemap_2["care_level"] = selectedval_carelevel!;
    carehomemap_2["facilities"] = selectedval_facility!;
    carehomemap_2["description"] = SA_carehome_descriptioncontroller.text;
    carehomemap_2["comments"] = SA_carehome_commentscontroller.text;
    carehomemap_2["homeImage_list"] = homeImagemap;
    carehomemap_2["youtube"] = SA_CH_youtubecontroller.text;
    carehomemap_2["facebook"] = SA_CH_FBcontroller.text;
    carehomemap_2["instagram"] = SA_CH_Instacontroller.text;
    carehomemap_2["twitter"] = SA_CH_twittercontroller.text;
    carehomemap_2["web"] = SA_CH_Websitecontroller.text;
    carehomemap_2["phase"] = "2";

    notifyListeners();

    if(from == "New")
    {

      db.collection("CARE_HOME").doc(homeId).set(carehomemap_2, SetOptions(merge: true));
      notifyListeners();
      //get_CareHome_Details();
      //notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text("Added Successfully",softWrap: true,
                style: GoogleFonts.karma(
                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)))),
            backgroundColor: maingreen,
            elevation: 5,
            behavior: SnackBarBehavior.floating,
            width: 300,)
      );
    }
    else
    {

      db.collection("CARE_HOME").doc(homeId).set(carehomemap_2, SetOptions(merge: true));
      //get_CareHome_Details();

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text("Updated Successfully",softWrap: true,
                style: GoogleFonts.karma(
                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)))),
            backgroundColor: maingreen,
            elevation: 5,
            behavior: SnackBarBehavior.floating,
            width: 300,)
      );
      notifyListeners();
    }
    //clearCareHomedata();
    notifyListeners();
    callNextReplacement(context, SubAdminRegPage3(ID: homeId, from: from, userID: userID,));
    // finish(context);

  }

//////////////////////////////////////// PAGE 3 /////////////////////////////////////////////////

List<Facility> selected_facility = [];
List<Facility> selected_facility1 = facilityList;

  bool isChecked = false;

void reset_facilityList()
{
  for(var e in facilityList)
    {
      e.isChecked = false;
    }
}

void onCheckboxChanged(bool? value, int index)
{
  print("${facilityList[index].isChecked}.......................");
  print("$value.......................");
  facilityList[index].isChecked = value ?? false;
  //selected_facility1[index].isChecked = value ?? false;
  if(selected_facility.isNotEmpty)
  {
    if (selected_facility.contains(facilityList[index])) {
      selected_facility.remove(facilityList[index]);
    }
    else
    {
      selected_facility.add(facilityList[index]);

    }
    // print("selected facilitY = ${selected_facility.first.facilities} , ${selected_facility.first.isChecked}");
  }
  else
    {
      selected_facility.add(facilityList[index]);
    }


  print(selected_facility.length);
  for(var e in selected_facility)
    {
      print("${e.isChecked} : ${e.facilities}");
    }
  //isChecked = value ?? false;
  notifyListeners();
}

String? selected_payment;

  void onSelected_payment(String? val)
  {
    selected_payment = val;
    notifyListeners();
  }

  void Add_CareHome_P3(BuildContext context, String homeId, String from)
  {
    print("eNTered intO ADD PAGE 3 111111111111111111111111");
    HashMap<String, Object> carehomemap_3 = HashMap();
    HashMap<String, Object> facilitylist_map = HashMap();
    int i =1;
    for(var e in  facilityList)
    {
      HashMap<String, Object> facility_map = HashMap();
      facility_map["isChecked"] = e.isChecked;
      facility_map["facilities"] = e.facilities;

      facilitylist_map[i.toString()]=facility_map;
      i++;
    }
    carehomemap_3["facility_list"] = facilitylist_map;
    carehomemap_3["pay_option"] = selected_payment!;
    carehomemap_3["pay_info"] = SA_carehome_payinfocontroller.text;
    carehomemap_3["approval_status"] = "REQUESTED";
    carehomemap_3["phase"] = "3";

    if(from == "New")
    {
print("new 22222222222222222222222222222222222222222222222222222222222222");
      db.collection("CARE_HOME").doc(homeId).set(carehomemap_3, SetOptions(merge: true));
      notifyListeners();
      request_status = "REQUESTED";
      get_CareHome_Details();
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text("Added Successfully",softWrap: true,
                style: GoogleFonts.karma(
                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)))),
            backgroundColor: maingreen,
            elevation: 5,
            behavior: SnackBarBehavior.floating,
            width: 300,)
      );
    }
    else
    {
print("EDIT 33333333333333333333333333333333333333333333");
      db.collection("CARE_HOME").doc(homeId).set(carehomemap_3, SetOptions(merge: true));
      get_CareHome_Details();
      notifyListeners();
      showSA_updatesnackbar(context,maingreen);

    }
    clearCareHomedata();
    notifyListeners();
    finish(context);
  }

  /////////////////////////////////////////////////////////////////////////////////////

void find_UserCareHomes(String userId)     //for displaying on drawer
{

  db.collection("CARE_HOME").where("userID",isEqualTo: userId).get().then((value)
      {
        if(value.docs.isNotEmpty)
          {
            reset_facilityList();
            User_CareHomeList.clear();
            for(var element in value.docs)
            {
              Map<String,dynamic>map=element.data();
              if(map.containsKey("facility_list"))
              {
              map["facility_list"].forEach((key,value)
              {
                facilityList.add(Facility(value["isChecked"], value["facilities"]));
              });
              }
              if(map.containsKey("homeImage_list")) {
                if (map["homeImage_list"] != null ||
                    map["homeImage_list"] != "") {
                  map["homeImage_list"].forEach((key, value) {
                    image_list.add(value);
                  });
                }
              }
              User_CareHomeList.add(
                  CareHome(
                    element.id,
                    map["userID"],
                    map["homename"],
                    map["address"],
                    map["pincode"],
                    map["district"],
                    map["state"],
                    map["contact_person"],
                    map["email"],
                    map["phone"],
                    //phase 2
                    map["available_bed"] ?? "",
                    map["licensed_bed"] ?? "",
                    map["care_level"] ?? "",
                    map["facilities"] ?? "",
                    map["description"] ?? "",
                    map["comments"] ?? "",
                    image_list,
                    map["youtube"] ?? "",
                    map["facebook"] ?? "",
                    map["instagram"] ?? "",
                    map["twitter"] ?? "",
                    map["web"] ?? "",
                    //PHASE 3
                    facilityList,
                    map["pay_option"] ?? "",
                    map["pay_info"] ?? "",
                    map["approval_status"],
                    map["phase"] ?? "",
                  ));
              notifyListeners();
            }
          }
      });
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Residence list to display on main-admin side

  void find_CareHomesRequests()
  {

    db.collection("CARE_HOME").where("approval_status",isEqualTo: "REQUESTED").get().then((value)
    {
      if(value.docs.isNotEmpty)
      {
        reset_facilityList();
        CareHome_RequestList.clear();
        clearCareHomedata();
        for(var element in value.docs)
        {
          Map<String,dynamic>map=element.data();
          if(map.containsKey("facility_list"))
          {
            map["facility_list"].forEach((key, value) {
              facilityList.add(
                  Facility(value["isChecked"], value["facilities"]));
            });
          }
          List<String> images = [];
          if(map.containsKey("homeImage_list"))
          {
            if (map["homeImage_list"] != null) {
              print("home image list is not empty...................");
              print(map["homeImage_list"]);

              map["homeImage_list"].forEach((key, value) {
                images.add(value);
              });
            }
          }
          CareHome_RequestList.add(
              CareHome(
                element.id,
                map["userID"],
                map["homename"],
                map["address"],
                map["pincode"],
                map["district"],
                map["state"],
                map["contact_person"],
                map["email"],
                map["phone"],
                //phase 2
                map["available_bed"] ?? "",
                map["licensed_bed"] ?? "",
                map["care_level"] ?? "",
                map["facilities"] ?? "",
                map["description"] ?? "",
                map["comments"] ?? "",
                images,
                map["youtube"] ?? "",
                map["facebook"] ?? "",
                map["instagram"] ?? "",
                map["twitter"] ?? "",
                map["web"] ?? "",
                //PHASE 3
                facilityList,
                map["pay_option"] ?? "",
                map["pay_info"] ?? "",
                map["approval_status"],
                map["phase"] ?? "",
              ));
          notifyListeners();
        }
      }
    });
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Residence list to display on user side

  void find_ApprovedCareHomes()
  {

    db.collection("CARE_HOME").where("approval_status",isEqualTo: "APPROVED").get().then((value)
    {
      if(value.docs.isNotEmpty)
      {
        reset_facilityList();
        CareHome_ApprovedList.clear();
        CareHomeNAME_ApprovedList.clear();
        for(var element in value.docs)
        {
          Map<String,dynamic>map=element.data();
          if(map.containsKey("facility_list"))
          {
            map["facility_list"].forEach((key, value) {
              facilityList.add(Facility(value["isChecked"], value["facilities"]));
            });
          }
          List<String> images = [];
          if(map.containsKey("homeImage_list"))
          {
            if (map["homeImage_list"] != null) {
              print("home image list is not empty...................");
              print(map["homeImage_list"]);

              map["homeImage_list"].forEach((key, value) {
                images.add(value);
              });
            }
          }
          CareHome_ApprovedList.add(
              CareHome(
                element.id,
                map["userID"],
                map["homename"],
                map["address"],
                map["pincode"],
                map["district"],
                map["state"],
                map["contact_person"],
                map["email"],
                map["phone"],
                //phase 2
                map["available_bed"] ?? "",
                map["licensed_bed"] ?? "",
                map["care_level"] ?? "",
                map["facilities"] ?? "",
                map["description"] ?? "",
                map["comments"] ?? "",
                images,
                map["youtube"] ?? "",
                map["facebook"] ?? "",
                map["instagram"] ?? "",
                map["twitter"] ?? "",
                map["web"] ?? "",
                //PHASE 3
                facilityList,
                map["pay_option"] ?? "",
                map["pay_info"] ?? "",
                map["approval_status"],
                map["phase"] ?? "",
              ));
          CareHomeNAME_ApprovedList.add(map["homename"]);
          notifyListeners();
        }
      }
    });
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////
// Checking if all CARE HOME registrations are finished
bool finished_allReg = true;

void check_allcarehome_regFinished(BuildContext context,String userId)
{
  db.collection("CARE_HOME").where("userID",isEqualTo: userId).where("phase", isNotEqualTo: "3").get().then((value)
  {
    if(value.docs.isNotEmpty)
      finished_allReg = false;
    else
      finished_allReg = true;

  if(finished_allReg == true)
  {
    clearCareHomedata();
    callNext(context, SubAdminRegPage1(ID: "", from: "New", userID: userId,));
  }
  else
  {
    Unfinished_CareHome_alert(context);
  }
  });
}


  List <String>Home_pics_new =
  [
    "assets/residences/Grandnest.jpeg",
    "assets/residences/Birchmount.jpeg",
    "assets/residences/Hillsideview.png",
    "assets/residences/Concordhall.jpg",
    "assets/residences/Livinghope.jpg",
    "assets/residences/Tanarata.jpg",
  ];


}