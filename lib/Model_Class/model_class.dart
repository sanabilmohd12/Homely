import 'package:flutter/cupertino.dart';

class UserDetails
{
  String id;
  String firstname;
  String lastname;
  String phone;
  String Email;
  String signup_time;
  UserDetails(this.id, this.firstname, this.lastname, this.phone, this.Email, this.signup_time);
}

class AdminDetails
{
  String id;
  String firstname;
  String lastname;
  String phone;
  String Email;
  AdminDetails(this.id, this.firstname, this.lastname, this.phone, this.Email);
}

class NewsDetails
{
  String id;
  String photo;
  String headline;
  String date;
  String newsdescription;
  NewsDetails(this.id, this.photo, this.headline, this.date, this.newsdescription);
}

class BoardMemberDetails
{
  String id;
  String BMphoto;
  String name;
  String title;
  String description;
  String phone;
  String email;
  String facebook;
  String linkedin;
  BoardMemberDetails(this.id, this.BMphoto, this.name, this.title, this.description, this.phone, this.email, this.facebook, this.linkedin);
}

class EventDetails
{
  String event_id;
  String event_topic;
  String venue;
  String from_date;
  String to_date;
  List<EventDaysdetails> EventDaysdetails_list;
  List<EventSpeakers> speaker_list;
  EventDetails(this.event_id, this.event_topic, this.venue, this.from_date, this.to_date, this.EventDaysdetails_list, this.speaker_list);
}

class EventDaysdetails
{
  String date;
  String dayTopic;
  String dayDescription;
  //TextEditingController dayTopic = TextEditingController() ;
  //TextEditingController dayDescription = TextEditingController();
  EventDaysdetails(this.date, this.dayTopic, this.dayDescription);
}

class EventSpeakers
{
  String id;
  String speaker_photo;
  String name;
  String designation;
  EventSpeakers(this.id, this.speaker_photo, this.name, this.designation);
}

class Sponsors
{
  String id;
  String sponsor_photo;
  String site_link;
  Sponsors(this.id, this.sponsor_photo, this.site_link);
}

///////////////////////////SUB ADMIN//////////////////////////////////////////////

class Facility
{
  bool isChecked;
  String facilities;
  Facility(this.isChecked, this.facilities);
}

class CareHome
{
  String id;
  String userid;
  String carehomename;
  String address;
  String pincode;
  String district;
  String state;
  String contact_person;
  String email;
  String phone;
  String available_bed;
  String licensed_bed;
  String care_level;
  String facilities;
  String description;
  String comments;
  List<String> homeImage_list;
  String youtube;
  String facebook;
  String instagram;
  String twitter;
  String web;
  List<Facility> facility_list;
  String pay_option;
  String pay_info;
  String approval_status;
  String phase;
  CareHome(this.id, this.userid, this.carehomename, this.address, this.pincode, this.district, this.state,
      this.contact_person, this.email, this.phone,
      this.available_bed, this.licensed_bed, this.care_level,
      this.facilities, this.description, this.comments, this.homeImage_list, this.youtube, this.facebook, this.instagram, this.twitter,
      this.web, this.facility_list, this.pay_option, this.pay_info, this.approval_status,
      this.phase);
}

