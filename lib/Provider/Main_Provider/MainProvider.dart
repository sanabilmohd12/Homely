import 'dart:collection';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homely/Constants/Call_Functions.dart';
import 'package:homely/Constants/Colors.dart';
import 'package:homely/Constants/MyWidgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Model_Class/model_class.dart';
import 'SubAdmin_Provider.dart';

class MainProvider extends ChangeNotifier
{


  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController Firstnamecontroller = TextEditingController();
  TextEditingController Lastnamecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController eventTopicController = TextEditingController();
  //TextEditingController eventdaysController = TextEditingController();
  TextEditingController eventfromdateController = TextEditingController();
  TextEditingController eventTodateController = TextEditingController();
  TextEditingController venueController = TextEditingController();
  TextEditingController speakerDesignationcontroller = TextEditingController();
  TextEditingController speakernamecontroller = TextEditingController();
  TextEditingController BM_namecontroller = TextEditingController();
  TextEditingController BM_titlecontroller = TextEditingController();
  //TextEditingController Mmbrdescriptioncontroller = TextEditingController();
  TextEditingController BM_phonecontroller = TextEditingController();
  TextEditingController BM_emailcontroller = TextEditingController();
  TextEditingController BM_descriptioncontroller = TextEditingController();
  TextEditingController BM_FBcontroller = TextEditingController();
  TextEditingController BM_LinkedIncontroller = TextEditingController();
  TextEditingController newsheadlinecontroller = TextEditingController();
  TextEditingController newsdescriptioncontroller = TextEditingController();
  TextEditingController newsdatecontroller = TextEditingController();
  TextEditingController sponsorlinkcontroller = TextEditingController();
  TextEditingController eventday_controller = TextEditingController() ;
  TextEditingController dayTopiccontroller = TextEditingController() ;
  TextEditingController dayDescriptioncontroller = TextEditingController();



  int dayCount = 0;
  late Map<String, List<TextEditingController>> namedControllers;


  List<UserDetails> Adminlist = [];
  List<UserDetails> UserList = [];
  List<NewsDetails> Newslist = [];
  List<NewsDetails> User_Newslist = [];
  List<BoardMemberDetails> BM_list = [];
  List<Sponsors> Sponsor_list = [];
  List<EventDaysdetails> EventDaysdetails_list_MP = [];
  List<EventDaysdetails> user_EventDaysdetails_list_MP = [];
  List<EventDetails> Event_list = [];
  List<EventDetails> user_Event_list = [];
  List<EventSpeakers> Speaker_list = [];

  Map<dynamic, dynamic> user_newsmap = {};
  Map<dynamic, dynamic> user_BMmap = {};
  Map<dynamic, dynamic> user_eventmap = {};
  String news_image = "";

  //File? fileimg;
  File? news_fileimg;
  String news_Image_url = "";

  File? BM_fileimg;
  String BM_Image_url = "";

  File? Sponsor_fileimg;
  String Sponsor_Image_url = "";

  File? Speaker_fileimg;
  String Speaker_Image_url = "";

  firebase_storage.Reference ref = FirebaseStorage.instance.ref("ItemImages");

  MainProvider()
  {
    getNewsDetails();
    notifyListeners();
  }

  void launchUrl(String url) async {

    await canLaunchUrl(Uri.parse(url)) ?
        launchUrl(Uri.parse(url) as String):
        print("CANt OPEn facEbooK");
  }


  Future getImagecamera(String from)
  async {
    final imagePicker = ImagePicker();
    final pickedImage =
    await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      // print("dfghjk"+pickedImage.path);
      cropImage(pickedImage.path, from);
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
      cropImage(pickedImg.path, from);
      //print(image.toString()+"jdhhd");
    } else {
      print('No image selected.');
    }
  }

  File? fileimg;
  String Image_url='';

  // void setImage(File image)
  // {
  //   fileimg = image;
  //   notifyListeners();
  // }

  Future<void> cropImage(String path, String from) async {
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
      from == "News" ? news_fileimg = File(croppedFile.path) :
      from == "BM" ? BM_fileimg = File(croppedFile.path) :
      from == "Sponsor" ? Sponsor_fileimg = File(croppedFile.path) :
      from == "Speaker" ? Speaker_fileimg = File(croppedFile.path) :
      fileimg = File(croppedFile.path);

      notifyListeners();
    }
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

  void show_addsnackbar(BuildContext context, Color clr)
  {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text("Added Successfully",softWrap: true,
              style: GoogleFonts.karma(
                  textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)))),
          backgroundColor: clr,
          elevation: 5,
          behavior: SnackBarBehavior.floating,
          width: 300,)
    );
  }

  void show_updatesnackbar(BuildContext context, Color clr)
  {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(
          child: Text("Updated Successfully",softWrap: true,
              style: GoogleFonts.karma(
                  textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)))),
      backgroundColor: clr,
      elevation: 5,
      behavior: SnackBarBehavior.floating,
      width: 300,)
    );
  }


  DateTime nowDate = DateTime.now();
  DateTime firstDate = DateTime.now();
  DateTime scheduledDate = DateTime.now();
  DateTime pickedFromDate = DateTime.now();
  DateTime pickedToDate = DateTime.now();
  var outputDateFormat = DateFormat('dd/MM/yyyy');


  Future<void> selectDate(BuildContext context,TextEditingController controller)
  async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != firstDate) {
      firstDate = pickedDate;
      controller.text = outputDateFormat.format(firstDate);

    }
  }

  DateTime selectStartDate = DateTime.now();
  DateTime selectEndDate = DateTime.now();

  String eventStartDate = "";
  String eventEndDate = "";

  String ? difference;

  Future<void> selectEventDate(BuildContext context,TextEditingController controller)
  async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        //initialDate: DateTime.now(),
        initialDate: firstDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != firstDate) {
      firstDate = pickedDate;
      controller.text = outputDateFormat.format(firstDate);

    }
  }

  void selectEventStartDate(BuildContext context, TextEditingController controller)
  async{
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: pickedFromDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != selectStartDate) {
      selectStartDate = pickedDate;
      pickedFromDate = pickedDate;
      print(selectStartDate.toString()+"ncfjjf");
      eventStartDate = "${selectStartDate.day}/${selectStartDate.month}/${selectStartDate.year}";
      controller.text = eventStartDate;
      print(eventStartDate.toString()+"otgiotg");
      notifyListeners();
    }
  }

  DateTime dateStart =DateTime.now();
  DateTime dateEnd=DateTime.now();


  void selectEventEndDate(BuildContext context, TextEditingController controller)
  async{
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: pickedToDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != selectEndDate) {
      selectEndDate = pickedDate;
      pickedToDate = pickedDate;
      print(selectEndDate.toString()+"ncfjjf");
      eventEndDate = "${selectEndDate.day}/${selectEndDate.month}/${selectEndDate.year}";
      controller.text = eventEndDate;
      print(eventEndDate.toString()+"otgiotg");
      dateStart = selectStartDate.subtract(Duration(hours: selectStartDate.hour, minutes: selectStartDate.minute, seconds: selectStartDate.second));
      dateEnd = selectEndDate.add(const Duration(hours: 24));

      difference= dateEnd.difference(dateStart).inDays.toString();
      dayCount = dateEnd.difference(dateStart).inDays;

      //create_eventdaysContollers(dayCount);

      print(difference.toString()+"oiuyw233");
      print("number of days = $dayCount");
      notifyListeners();
    }
  }

  // void create_eventdaysContollers(int daycount)
  // {
  //   for (int i = 0; i < daycount; i++)
  //   {
  //     topicControllers['eventTopic_day${i + 1}'] = TextEditingController();
  //     descriptionControllers['eventdescription_day${i + 1}'] = TextEditingController();
  //   }
  // }

  ////////////////////////////////////USER REGISTRATION//////////////////////////////////////////

  void user_registration(BuildContext context, String userId, String from)
  {
    String ID = DateTime.now().millisecondsSinceEpoch.toString();

    HashMap<String, Object> userdetailmap = HashMap();
    userdetailmap["First Name"] = Firstnamecontroller.text;
    userdetailmap["Last Name"] = Lastnamecontroller.text;
    userdetailmap["Phone"] = phonecontroller.text;
    userdetailmap["Email"] = emailcontroller.text;


    userdetailmap["id"] = ID;

    HashMap<String, Object> usermap = HashMap();
    usermap["id"] = ID;
    usermap["First Name"] = Firstnamecontroller.text;
    usermap["Phone"] = "+91"+phonecontroller.text;
    usermap["Type"] = "user";

    if(from == "New")
    {
      userdetailmap["SignupTime"] = DateTime.now();
      db.collection("USERDETAILS").doc(ID).set(userdetailmap);
      db.collection("USER").doc(ID).set(usermap);
      //const snackbar = SnackBar();
      //show_addsnackbar(context, maingreen);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text("Added Successfully",softWrap: true,
                style: GoogleFonts.karma(
                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: maingreen)))),
            backgroundColor: Colors.white,
            elevation: 5,
            behavior: SnackBarBehavior.floating,
            width: 300,)
      );
      notifyListeners();

    }
    else
    {
      db.collection("USERDETAILS").doc(userId).set(userdetailmap,SetOptions(merge: true));
      db.collection("USER").doc(userId).update(usermap);
      show_updatesnackbar(context,adminblue);
      notifyListeners();
    }
    getUser();
    notifyListeners();
    finish(context);
  }

  void getUser()
  {
    db.collection("USER").where("Type",isNotEqualTo:"main_admin").get().then((value)
    {
      if(value.docs.isNotEmpty)
      {
        UserList.clear();
        for(var element in value.docs) {
          db.collection("USERDETAILS").doc(element.id).get().then((value)
          {
            if (value.exists)
            {
              UserList.add(
                  UserDetails(
                    value.id,
                    value.get("First Name"),
                    value.get("Last Name"),
                    value.get("Phone"),
                    value.get("Email"),
                    DateFormat("dd/MM/yyyy hh:mm a").format(
                        value.get("SignupTime").toDate()).toString(),
                  ));
              notifyListeners();
            }
          });
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  void updateUserDetails(String id)
  {

    db.collection("USERDETAILS").doc(id).get().then((value)
    {

      if(value.exists)
      {
        Map<dynamic, dynamic> usermap = value.data() as Map;
        Firstnamecontroller.text = usermap['First Name'].toString();
        Lastnamecontroller.text = usermap['Last Name'].toString();
        phonecontroller.text = usermap['Phone'].toString();
        emailcontroller.text = usermap['Email'].toString();
        // newsdescriptioncontroller.text = newsmap['newsdescription'].toString();
        // newsdatecontroller.text = DateFormat("dd/MM/yyyy").format(newsmap["date"].toDate()).toString();
        // news_Image_url = newsmap["photo"].toString();

        notifyListeners();
      }
    });
    notifyListeners();
  }

  void clearRegistration()
  {
    Firstnamecontroller.clear();
    Lastnamecontroller.clear();
    phonecontroller.clear();
    emailcontroller.clear();
    UserList.clear();
  }

/////////////////////////////MAIN ADMIN///////////////////////////////////////////////////

void addMainAdmins(BuildContext context, String adminId, String from)
{
  String ID = DateTime.now().millisecondsSinceEpoch.toString();

  HashMap<String, Object> userdetailmap = HashMap();
  userdetailmap["First Name"] = Firstnamecontroller.text;
  userdetailmap["Last Name"] = Lastnamecontroller.text;
  userdetailmap["Phone"] = phonecontroller.text;
  userdetailmap["Email"] = emailcontroller.text;


  userdetailmap["id"] = ID;

  HashMap<String, Object> usermap = HashMap();
  usermap["id"] = ID;
  usermap["First Name"] = Firstnamecontroller.text;
  usermap["Phone"] = "+91"+phonecontroller.text;
  usermap["Type"] = "main_admin";

  if(from == "New")
  {
    userdetailmap["SignupTime"] = DateTime.now();
    db.collection("USERDETAILS").doc(ID).set(userdetailmap);
    db.collection("USER").doc(ID).set(usermap);
    //const snackbar = SnackBar();
    //show_addsnackbar(context, maingreen);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text("Added Successfully",softWrap: true,
              style: GoogleFonts.karma(
                  textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: maingreen)))),
          backgroundColor: Colors.white,
          elevation: 5,
          behavior: SnackBarBehavior.floating,
          width: 300,)
    );
    notifyListeners();

  }
  else
  {
    db.collection("USERDETAILS").doc(adminId).set(userdetailmap,SetOptions(merge: true));
    db.collection("USER").doc(adminId).update(usermap);
    show_updatesnackbar(context,adminblue);
    notifyListeners();
  }
  getUser();
  notifyListeners();
  finish(context);
}

void getMainAdminDetails()
{
  db.collection("USER").where("Type",isEqualTo:"main_admin").get().then((value)
  {
    if(value.docs.isNotEmpty)
    {
      Adminlist.clear();
      for(var element in value.docs) {
        db.collection("USERDETAILS").doc(element.id).get().then((value) {
          if (value.exists) {
            Adminlist.add(
                UserDetails(
                  value.id,
                  value.get("First Name"),
                  value.get("Last Name"),
                  value.get("Phone"),
                  value.get("Email"),
                  DateFormat("dd/MM/yyyy hh:mm a").format(
                      value.get("SignupTime").toDate()).toString(),
                ));
            notifyListeners();
          }
        });
      }
      notifyListeners();
    }
  });
}

  void updateAdminDetails(String id)
  {

    db.collection("USERDETAILS").doc(id).get().then((value)
    {

      if(value.exists)
      {
        Map<dynamic, dynamic> usermap = value.data() as Map;
        Firstnamecontroller.text = usermap['First Name'].toString();
        Lastnamecontroller.text = usermap['Last Name'].toString();
        phonecontroller.text = usermap['Phone'].toString();
        emailcontroller.text = usermap['Email'].toString();
        // newsdescriptioncontroller.text = newsmap['newsdescription'].toString();
        // newsdatecontroller.text = DateFormat("dd/MM/yyyy").format(newsmap["date"].toDate()).toString();
        // news_Image_url = newsmap["photo"].toString();

        notifyListeners();
      }
    });
    notifyListeners();
  }

///////////////////////////// NEWS ////////////////////////////////////////////////////////

  bool newsloader = false;
  String news_date = "";

Future<void> AddNews(BuildContext context, String newsId, String from)
async {
  String ID = DateTime.now().millisecondsSinceEpoch.toString();

  HashMap<String, Object> newsmap = HashMap();
  newsmap["headline"] = newsheadlinecontroller.text;
  String currentDate = DateFormat("yMd").format(nowDate).toString();
  //
  // print(currentDate);
  newsmap["date"] = firstDate;
  newsmap["newsdescription"] = newsdescriptioncontroller.text;

  if (news_fileimg != null) {
    String photoId = DateTime.now().millisecondsSinceEpoch.toString();
    ref = FirebaseStorage.instance.ref().child(photoId);
    await ref.putFile(news_fileimg!).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        newsmap["photo"] = value;
        // productmap["id photo"] = photoId;
        // editMap['IMAGE_URL'] = value;
        notifyListeners();
      });
      notifyListeners();
    });
    notifyListeners();
  }
  else
  {
    from=="New"?newsmap['photo'] = "":newsmap['photo'] = news_Image_url;
    notifyListeners();
    // editMap['IMAGE_URL'] = imageUrl;
  }
  //db.collection("Product").doc(id).set(productmap);
  notifyListeners();



  if(from == "New")
  {
    db.collection("NEWS").doc(ID).set(newsmap);
    notifyListeners();
    getNewsDetails();
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text("Added Successfully",softWrap: true,
              style: GoogleFonts.karma(
                  textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)))),
          backgroundColor: adminblue,
          elevation: 5,
          behavior: SnackBarBehavior.floating,
          width: 300,)
    );
    //const snackbar = SnackBar();
    //show_addsnackbar(context, adminblue);
  }
  else
  {
    print("edit news");
    db.collection("NEWS").doc(newsId).update(newsmap);
    getNewsDetails();
    notifyListeners();
    show_updatesnackbar(context,adminblue);
    notifyListeners();
  }
  finish(context);


}

  void getNewsDetails()
  {
    db.collection("NEWS").get().then((value)
    {
      //print("abs");
      if(value.docs.isNotEmpty)

      {
        Newslist.clear();
      for(var element in value.docs)
      {
        Newslist.add(
            NewsDetails(
                element.id,
                element.get("photo") ?? null,
                element.get("headline"),

                DateFormat("dd/MM/yyyy").format(element.get("date").toDate()).toString(),
                // element.get("date"),
                element.get("newsdescription")));
        notifyListeners();


      }

      }
    });
    notifyListeners();
  }

  void user_newsclear()
  {
    user_newsmap.clear();
    newsloader = true;
    notifyListeners();
  }

  void updateNewsDetails(String id)
  {

    user_newsmap.clear();
    db.collection("NEWS").doc(id).get().then((value)
    {

      if(value.exists)
      {
        //User_Newslist.clear();
        user_newsmap.clear();
        user_newsmap = value.data() as Map;
        news_image = user_newsmap["photo"].toString();
        news_date = DateFormat("dd/MM/yyyy").format(user_newsmap["date"].toDate()).toString();
        notifyListeners();

        Map<dynamic, dynamic> newsmap = value.data() as Map;
        newsheadlinecontroller.text = newsmap['headline'].toString();
        newsdescriptioncontroller.text = newsmap['newsdescription'].toString();
        newsdatecontroller.text = DateFormat("dd/MM/yyyy").format(newsmap["date"].toDate()).toString();
        news_Image_url = newsmap["photo"].toString();

        notifyListeners();
      }
    });
    notifyListeners();
    newsloader = false;
  }

  void DeleteNewsalert(BuildContext context, String txt, String id)     //DELETE ALERT BOX
  {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("ALERT"),
        content: Text(txt),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              //DeleteStudent(context, id);
              //function;
              deleteNews(context, id);
              Navigator.of(context).pop();

            },
            child: Container(
              color: Colors.green,
              padding: const EdgeInsets.all(14),
              child: const Text("YES"),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.all(14),
              child: const Text("NO"),
            ),
          ),
        ],
      ),
    );
    //getNewsDetails();
    notifyListeners();
  }

  deleteNews(BuildContext context, String newsid)
  {
    db.collection("NEWS").doc(newsid).delete();
    notifyListeners();
    show_deletesnackbar(context,adminblue);
    getNewsDetails();

  }

  void clearNewsdata()
  {
    newsheadlinecontroller.clear();
    news_fileimg = null;
    newsdatecontroller.clear();
    newsdescriptioncontroller.clear();
    Image_url = "";
    news_Image_url = "";
    notifyListeners();
  }

////////////////////////////// BOARD MEMBERS ////////////////////////////

  Future<void> Add_BoardMember(BuildContext cntx, String mmbrId, String from)
  async {
    String ID = DateTime.now().millisecondsSinceEpoch.toString();
    //BM_fileimg = fileimg;

    HashMap<String, Object> BM_map = HashMap();
    BM_map['name'] = BM_namecontroller.text;
    BM_map['title'] = BM_titlecontroller.text;
    BM_map['description'] = BM_descriptioncontroller.text;
    BM_map['phone'] = BM_phonecontroller.text;
    BM_map['email'] = BM_emailcontroller.text;
    BM_map['facebook'] = BM_FBcontroller.text;
    BM_map['linkedin'] = BM_LinkedIncontroller.text;

    if (BM_fileimg != null) {
      print('BM_fileimg is not null');
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(BM_fileimg!).whenComplete(() async {
        print('hiiiiii');
        await ref.getDownloadURL().then((value) {
          print('hoooooooo');
          BM_map["BMphoto"] = value;
          // productmap["id photo"] = photoId;
          // editMap['IMAGE_URL'] = value;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    }
    else
    {
      print('BM_fileimg is null');
      from=="New"?BM_map['BMphoto'] = "":BM_map['BMphoto'] = BM_Image_url;
      notifyListeners();
      // editMap['IMAGE_URL'] = imageUrl;
    }
    notifyListeners();

    //SAVING BOARD MEMBER DETAILS
    if(from == "New")
    {
      db.collection("BOARD MEMBERS").doc(ID).set(BM_map);
      notifyListeners();
      get_BMDetails();
      notifyListeners();
      ScaffoldMessenger.of(cntx).showSnackBar(
          SnackBar(
            content: Center(child: Text("Added Successfully",softWrap: true,
                style: GoogleFonts.karma(
                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)))),
            backgroundColor: adminblue,
            elevation: 5,
            behavior: SnackBarBehavior.floating,
            width: 300,)
      );
      //const snackbar = SnackBar();
      //show_addsnackbar(context, adminblue);
    }
    else
    {
      print("edit Board member");
      db.collection("BOARD MEMBERS").doc(mmbrId).update(BM_map);
      get_BMDetails();
      notifyListeners();
      show_updatesnackbar(cntx,adminblue);
      notifyListeners();
    }
    finish(cntx);


  }

  void get_BMDetails()
  {
    db.collection("BOARD MEMBERS").get().then((value)
    {
      //print("abs");
      if(value.docs.isNotEmpty)

      {
        BM_list.clear();
        for(var element in value.docs)
        {
          BM_list.add(
              BoardMemberDetails(
                  element.id,
                  element.get("BMphoto") ?? null,
                  element.get("name"),
                  element.get("title"),
                  element.get("description"),
                  element.get("phone"),
                  element.get("email"),
                  element.get("facebook"),
                  element.get("linkedin"),

                  ));
          notifyListeners();
        }
      }
    }
    );
    notifyListeners();
  }

  void update_BMDetails(String id)
  {
    db.collection("BOARD MEMBERS").doc(id).get().then((value)
    {
      if(value.exists)
      {
        user_BMmap.clear();
        user_BMmap = value.data() as Map;
        notifyListeners();

        Map<dynamic, dynamic> BM_map = value.data() as Map;
        BM_namecontroller.text = BM_map['name'].toString();
        BM_titlecontroller.text = BM_map['title'].toString();
        BM_descriptioncontroller.text = BM_map['description'].toString();
        BM_phonecontroller.text = BM_map['phone'].toString();
        BM_emailcontroller.text = BM_map['email'].toString();
        BM_FBcontroller.text = BM_map['facebook'].toString();
        BM_LinkedIncontroller.text = BM_map['linkedin'].toString();
        BM_Image_url = BM_map["BMphoto"].toString();

        notifyListeners();
      }
    });
    notifyListeners();
  }

  void Delete_BMalert(BuildContext cntxt, String txt, String id)     //DELETE ALERT BOX
  {
    showDialog(
      context: cntxt,
      builder: (alert_context) => AlertDialog(
        title: const Text("ALERT"),
        content: Text(txt),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              delete_BM(cntxt, id);
              Navigator.of(alert_context).pop();

            },
            child: Container(
              color: Colors.green,
              padding: const EdgeInsets.all(14),
              child: const Text("YES"),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(alert_context).pop();
            },
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.all(14),
              child: const Text("NO"),
            ),
          ),
        ],
      ),
    );
    //getNewsDetails();
    notifyListeners();
  }

  delete_BM(BuildContext ctx, String BMid)
  {
    db.collection("BOARD MEMBERS").doc(BMid).delete();
    notifyListeners();
    show_deletesnackbar(ctx,adminblue);
    get_BMDetails();

  }

  void clear_BMdata()
  {
    BM_namecontroller.clear();
    BM_titlecontroller.clear();
    BM_descriptioncontroller.clear();
    BM_phonecontroller.clear();
    BM_emailcontroller.clear();
    BM_FBcontroller.clear();
    BM_LinkedIncontroller.clear();
    BM_Image_url = "";
    BM_fileimg = null;
  }

  ////////////////////////////////////  EVENTS  ////////////////////////////////////



  void add_eventdaydetails(String from, var index)
  {
    if(from == "new") {
      EventDaysdetails_list_MP.add(EventDaysdetails(
          eventday_controller.text, dayTopiccontroller.text,
          dayDescriptioncontroller.text));
    }
    else
      {
        EventDaysdetails_list_MP[index] = EventDaysdetails(eventday_controller.text, dayTopiccontroller.text, dayDescriptioncontroller.text);
      }
    notifyListeners();
  }

  void clear_eventdaydetails()
  {
    eventday_controller.clear();
    dayTopiccontroller.clear();
    dayDescriptioncontroller.clear();
    notifyListeners();
  }

  Future<void> add_Events(BuildContext context, String eventId, String from)
  async {
    String ID = DateTime.now().millisecondsSinceEpoch.toString();

    HashMap<String, Object> event_map = HashMap();
    HashMap<String, Object> eventday_map = HashMap();
    HashMap<String, Object> speaker_map = HashMap();
    event_map["event_topic"] = eventTopicController.text;
    event_map["venue"] = venueController.text;
    //String currentDate = DateFormat("yMd").format(nowDate).toString();
    //
    // print(currentDate);
    event_map["fromdate"] = pickedFromDate;
    event_map["todate"] = pickedToDate;
    //event_map["EventDaysdetails_list"] = EventDaysdetails_list_MP;
    int i =1;
    for(var e in  EventDaysdetails_list_MP)
      {
        HashMap<String, Object> days_map = HashMap();
        days_map["date"] = e.date;
        days_map["dayTopic"] = e.dayTopic;
        days_map["dayDescription"] = e.dayDescription;
        eventday_map[i.toString()]=days_map;
        i++;
      }
    event_map["EventDaysdetails_list"] = eventday_map;

    int j =1;
    for(var s in Speakers)
      {
        speaker_map[j.toString()] = s.id;
        j++;
      }
    event_map["speaker_id"] = speaker_map;


    if(from == "New")
    {
      db.collection("EVENTS").doc(ID).set(event_map);
      notifyListeners();
      getEventDetails();
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text("Added Successfully",softWrap: true,
                style: GoogleFonts.karma(
                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)))),
            backgroundColor: adminblue,
            elevation: 5,
            behavior: SnackBarBehavior.floating,
            width: 300,)
      );
      //const snackbar = SnackBar();
      //show_addsnackbar(context, adminblue);
    }
    else
    {
      db.collection("EVENTS").doc(eventId).update(event_map);
      getEventDetails();
      notifyListeners();
      show_updatesnackbar(context,adminblue);
      notifyListeners();
    }
    finish(context);


  }

  void getEventDetails()
  {
    //print("iiiiiiiiiiiiiiiiiiiiiiiiiii");
    clearEventdata();
    notifyListeners();
    db.collection("EVENTS").get().then((value)
    {
      //print("iiiiiiiiiiiiiiiiiiiiiiiiiii");
      if(value.docs.isNotEmpty)
      {
        //print("event EXIST");
        Event_list.clear();
        EventDaysdetails_list_MP.clear();
        Speakers.clear();
        selectedItems.clear();
        //List<EventDaysdetails> EventDaysdetails_list = [];

        for(var element in value.docs)
        {
          Map<dynamic, dynamic> geteventmap = element.data();
          geteventmap["EventDaysdetails_list"].forEach((key,value){
            EventDaysdetails_list_MP.add(
                EventDaysdetails(value["date"].toString(),value["dayTopic"].toString(),value["dayDescription"].toString()));
          });

          Map<dynamic, dynamic> getspeakermap = element.data();
          getspeakermap["speaker_id"].forEach((key, value){
            //Speakers.add(EventSpeakers(id, speaker_photo, name, designation))
            selectedItems.add(value.toString());
            event_Speakers(value);
          });
          Event_list.add(
              EventDetails(
                  element.id,
                  element.get("event_topic"),
                  element.get("venue"),
                  DateFormat("dd/MM/yyyy").format(element.get("fromdate").toDate()).toString(),
                  DateFormat("dd/MM/yyyy").format(element.get("todate").toDate()).toString(),
                  EventDaysdetails_list_MP,
                  Speakers
                  // element.get("date"),

              )
              );
          notifyListeners();
        }
      }
    });
    notifyListeners();
  }

  void event_Speakers(String id)
  {
    db.collection("SPEAKERS").doc(id).get().then((value)
    {
      if(value.exists)
      {
        Map<dynamic, dynamic> speaker_map = value.data() as Map;
        Speakers.add(
            EventSpeakers(
                speaker_map['id'].toString(),
                speaker_map["speaker_photo"].toString(),
                speaker_map['name'].toString(),
                speaker_map['designation'].toString()));
        notifyListeners();
      }
    });
    notifyListeners();
  }

  void updateEvent(String id)
  {
    EventDaysdetails_list_MP.clear();
    Speakers.clear();
    db.collection("EVENTS").doc(id).get().then((value)
    {
      if(value.exists)
      {
        user_eventmap.clear();
        user_eventmap = value.data() as Map;
        //user_eventmap["fromdate"] = DateFormat("MMMMd").format(user_eventmap["fromdate"].toDate()).toString();
        //user_eventmap["todate"] = DateFormat("MMMMd").format(user_eventmap["todate"].toDate()).toString();

        Map<dynamic, dynamic> eventmap = value.data() as Map;
        eventTopicController.text = eventmap['event_topic'].toString();
        venueController.text = eventmap['venue'].toString();
        eventfromdateController.text = DateFormat("dd/MM/yyyy").format(eventmap["fromdate"].toDate()).toString();
        eventTodateController.text = DateFormat("dd/MM/yyyy").format(eventmap["todate"].toDate()).toString();
        //print(DateFormat("yMMMd").format(eventmap["fromdate"].toDate()).toString()+"......................");
        eventmap["EventDaysdetails_list"].forEach((key,value){
          EventDaysdetails_list_MP.add(
              EventDaysdetails(value["date"].toString(),value["dayTopic"].toString(),value["dayDescription"].toString()));
        });
        eventmap["speaker_id"].forEach((key, value){
          //Speakers.add(EventSpeakers(id, speaker_photo, name, designation))
          selectedItems.add(value.toString());
          event_Speakers(value);
        });

        notifyListeners();
      }
    });
    notifyListeners();
  }

  void update_dayalert(EventDaysdetails eventdays)
  {

    // for(var e in eventdays)
    //   {
        eventday_controller.text = eventdays.date;
        dayTopiccontroller.text = eventdays.dayTopic;
        dayDescriptioncontroller.text = eventdays.dayDescription;
      // }

    notifyListeners();
  }

  void DeleteEventalert(BuildContext context, String txt, String id)     //DELETE ALERT BOX
  {
    print("ooooooooooooooooooooooo");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("ALERT"),
        content: Text(txt),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              //DeleteStudent(context, id);
              //function;
              deleteEvent(context, id);
              Navigator.of(context).pop();

            },
            child: Container(
              color: Colors.green,
              padding: const EdgeInsets.all(14),
              child: const Text("YES"),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.all(14),
              child: const Text("NO"),
            ),
          ),
        ],
      ),
    );
    //getNewsDetails();
    notifyListeners();
  }

  deleteEvent(BuildContext context, String eventid)
  {
    print("aaaaaaaaaaaaaaaaaaaaa");
    db.collection("EVENTS").doc(eventid).delete();
    notifyListeners();
    show_deletesnackbar(context,adminblue);

    getEventDetails();

  }

  void clearEventdata()
  {
    eventTopicController.clear();

    venueController.clear();
    eventfromdateController.clear();
    eventTodateController.clear();
    EventDaysdetails_list_MP.clear();
    selectedItems.clear();
    Speakers.clear();

    notifyListeners();
  }

  final Map<EventSpeakers, bool> checkboxState = {};

  void updateCheckboxState(EventSpeakers item, bool isChecked)
  {
    checkboxState[item] = isChecked;
    notifyListeners();
  }

  List<dynamic> selectedItems = []; // Maintain the selected items here
  //List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
  List<EventSpeakers> Speakers = [];

  void onItemSelect(EventSpeakers selectedItem)
  {
      if (selectedItems.contains(selectedItem.name))
      {
        selectedItems.remove(selectedItem.name);
        Speakers.remove(selectedItem);
      }
      else
      {
        selectedItems.add(selectedItem.name);
        Speakers.add(selectedItem);
      }
      notifyListeners();
  }

  ///////////////////////////////////////////// SPEAKERS/////////////////////////////////////

  Future<void> Add_Speaker(BuildContext cntx, String speakerId, String from)
  async {
    String ID = DateTime.now().millisecondsSinceEpoch.toString();


    HashMap<String, Object> speaker_map = HashMap();
    speaker_map['name'] = speakernamecontroller.text;
    speaker_map['designation'] = speakerDesignationcontroller.text;

    if (Speaker_fileimg != null) {
      print('Speaker_fileimg is not null');
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(Speaker_fileimg!).whenComplete(() async {

        await ref.getDownloadURL().then((value) {

          speaker_map["speaker_photo"] = value;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    }
    else
    {
      print('Sponsor_fileimg is null');
      print(Speaker_Image_url);
      from=="New"?speaker_map['speaker_photo'] = "":speaker_map['speaker_photo'] = Speaker_Image_url;
      notifyListeners();

    }
    notifyListeners();

    //SAVING SPONSOR DETAILS
    if(from == "New")
    {
      db.collection("SPEAKERS").doc(ID).set(speaker_map);
      notifyListeners();
      get_SpeakerDetails();
      clear_Speakerdata();
      notifyListeners();
      ScaffoldMessenger.of(cntx).showSnackBar(
          SnackBar(
            content: Center(child: Text("Added Successfully",softWrap: true,
                style: GoogleFonts.karma(
                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)))),
            backgroundColor: adminblue,
            elevation: 5,
            behavior: SnackBarBehavior.floating,
            width: 300,)
      );
      //const snackbar = SnackBar();
      //show_addsnackbar(context, adminblue);
    }
    else
    {
      print("edit sPEakeR");
      db.collection("SPEAKERS").doc(speakerId).update(speaker_map);
      get_SpeakerDetails();
      clear_Speakerdata();
      notifyListeners();
      show_updatesnackbar(cntx,adminblue);
      notifyListeners();
    }
    //finish(cntx);


  }

  void get_SpeakerDetails()
  {
    db.collection("SPEAKERS").get().then((value)
    {
      //print("abs");
      if(value.docs.isNotEmpty)

      {
        Speaker_list.clear();

        for(var element in value.docs)
        {
          Speaker_list.add(
              EventSpeakers(
                element.id,
                element.get("speaker_photo") ?? null,
                element.get("name"),
                element.get("designation"),
              ));
          //Speaker_names.add(element.get("name"));
          notifyListeners();
        }

      }
    }
    );
    notifyListeners();
  }

  void update_SpeakerDetails(String id)
  {
    db.collection("SPEAKERS").doc(id).get().then((value)
    {
      if(value.exists)
      {
        Map<dynamic, dynamic> speaker_map = value.data() as Map;
        speakernamecontroller.text = speaker_map['name'].toString();
        speakerDesignationcontroller.text = speaker_map['designation'].toString();
        Speaker_Image_url = speaker_map["speaker_photo"].toString();
        notifyListeners();
      }
    });
    notifyListeners();
  }

  void Delete_Speakeralert(BuildContext cntxt, String txt, String id)     //DELETE ALERT BOX
  {
    showDialog(
      context: cntxt,
      builder: (alert_context) => AlertDialog(
        title: const Text("ALERT"),
        content: Text(txt),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              delete_Speaker(cntxt, id);
              Navigator.of(alert_context).pop();

            },
            child: Container(
              color: Colors.green,
              padding: const EdgeInsets.all(14),
              child: const Text("YES"),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(alert_context).pop();
            },
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.all(14),
              child: const Text("NO"),
            ),
          ),
        ],
      ),
    );
    //getNewsDetails();
    notifyListeners();
  }

  delete_Speaker(BuildContext ctx, String Speakerid)
  {
    db.collection("SPEAKERS").doc(Speakerid).delete();
    notifyListeners();
    show_deletesnackbar(ctx,adminblue);
    get_SpeakerDetails();
    clear_Speakerdata();
    notifyListeners();
  }

  void clear_Speakerdata()
  {
    speakernamecontroller.clear();
    speakerDesignationcontroller.clear();
    Speaker_Image_url = "";
    Speaker_fileimg = null;
    Speaker_list.clear();
  }

////////////////////////////// SPONSORS ////////////////////////////

  Future<void> Add_Sponsor(BuildContext cntx, String sponsorId, String from)
  async {
    String ID = DateTime.now().millisecondsSinceEpoch.toString();


    HashMap<String, Object> sponsor_map = HashMap();
    sponsor_map['site_link'] = sponsorlinkcontroller.text;

    if (Sponsor_fileimg != null) {
      print('Sponsor_fileimg is not null');
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(Sponsor_fileimg!).whenComplete(() async {

        await ref.getDownloadURL().then((value) {

          sponsor_map["sponsor_photo"] = value;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    }
    else
    {
      print('Sponsor_fileimg is null');
      from=="New"?sponsor_map['sponsor_photo'] = "":sponsor_map['sponsor_photo'] = Sponsor_Image_url;
      notifyListeners();

    }
    notifyListeners();

    //SAVING SPONSOR DETAILS
    if(from == "New")
    {
      db.collection("SPONSORS").doc(ID).set(sponsor_map);
      notifyListeners();
      get_SponsorDetails();
      notifyListeners();
      ScaffoldMessenger.of(cntx).showSnackBar(
          SnackBar(
            content: Center(child: Text("Added Successfully",softWrap: true,
                style: GoogleFonts.karma(
                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)))),
            backgroundColor: adminblue,
            elevation: 5,
            behavior: SnackBarBehavior.floating,
            width: 300,)
      );
      //const snackbar = SnackBar();
      //show_addsnackbar(context, adminblue);
    }
    else
    {
      print("edit SPONSOR");
      db.collection("SPONSORS").doc(sponsorId).update(sponsor_map);
      get_SponsorDetails();
      notifyListeners();
      show_updatesnackbar(cntx,adminblue);
      notifyListeners();
    }
    finish(cntx);


  }

  void get_SponsorDetails()
  {
    db.collection("SPONSORS").get().then((value)
    {
      //print("abs");
      if(value.docs.isNotEmpty)

      {
        Sponsor_list.clear();
        for(var element in value.docs)
        {
          Sponsor_list.add(
              Sponsors(
                element.id,
                element.get("sponsor_photo") ?? null,
                element.get("site_link"),
              ));
          notifyListeners();
        }
      }
    }
    );
    notifyListeners();
  }

  void update_SponsorDetails(String id)
  {
    db.collection("SPONSORS").doc(id).get().then((value)
    {
      if(value.exists)
      {
        Map<dynamic, dynamic> sponsor_map = value.data() as Map;
        sponsorlinkcontroller.text = sponsor_map['site_link'].toString();
        Sponsor_Image_url = sponsor_map["sponsor_photo"].toString();
        notifyListeners();
      }
    });
    notifyListeners();
  }

  void Delete_Sponsoralert(BuildContext cntxt, String txt, String id)     //DELETE ALERT BOX
  {
    showDialog(
      context: cntxt,
      builder: (alert_context) => AlertDialog(
        title: const Text("ALERT"),
        content: Text(txt),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              delete_Sponsor(cntxt, id);
              Navigator.of(alert_context).pop();

            },
            child: Container(
              color: Colors.green,
              padding: const EdgeInsets.all(14),
              child: const Text("YES"),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(alert_context).pop();
            },
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.all(14),
              child: const Text("NO"),
            ),
          ),
        ],
      ),
    );
    //getNewsDetails();
    notifyListeners();
  }

  delete_Sponsor(BuildContext ctx, String Sponsorid)
  {
    db.collection("SPONSORS").doc(Sponsorid).delete();
    notifyListeners();
    show_deletesnackbar(ctx,adminblue);
    get_SponsorDetails();

  }

  void clear_Sponsordata()
  {
    sponsorlinkcontroller.clear();
    Sponsor_Image_url = "";
    Sponsor_fileimg = null;
  }

///////////////////////////////////////////////////////////////////////////////////////////
//APPROVING RESIDENCES BY MAIN ADMIN

void approve_residences(BuildContext context, String homeId, String from)
{
  SubAdmin_Provider sub_provider = Provider.of(context, listen: false);
  HashMap<String, Object> map = HashMap();
  from == "ACCEPTED" ?
  map["approval_status"] = "ACCEPTED":
  map["approval_status"] = "REJECTED";
  db.collection("CARE_HOME").doc(homeId).set(map, SetOptions(merge: true));
  notifyListeners();
  from == "ACCEPTED" ?
  sub_provider.request_status = "ACCEPTED":
  sub_provider.request_status = "REJECTED";
  sub_provider.get_CareHome_Details();
  notifyListeners();

  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(sub_provider.request_status,softWrap: true,
            style: GoogleFonts.karma(
                textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)))),
        backgroundColor: maingreen,
        elevation: 5,
        behavior: SnackBarBehavior.floating,
        width: 300,)
  );
  notifyListeners();
}

  void razorpayGateway(){


    Razorpay razorpay = Razorpay();
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': 1000*100,
      'name': "Homely",
      'description': "Pay the Regitration Fee",
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': '9988776655',
        // 'email': 'test@razorpay.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    razorpay.on(
        Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
        handleExternalWalletSelected);
    razorpay.open(options);

  }
  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */

  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */

    log(response.data.toString()+"sucessss");

  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {

  }




}