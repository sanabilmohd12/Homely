import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:multiselect/multiselect.dart';

import '../../Constants/Call_Functions.dart';
import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import '../../Model_Class/model_class.dart';
import '../../Provider/Main_Provider/MainProvider.dart';

class MAaddEvents extends StatelessWidget {

  String ID, from;
  int daycount = 0;
  bool addDay = false;
  String evnt_date = "";

  var outputDateFormat = DateFormat('dd/MM/yyyy');


  MAaddEvents({super.key, required this.ID, required this.from});

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of(context, listen: false);

    var width = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
        child: Scaffold(
          appBar: Appbar_MainAdmin("Events", context),
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
                    Page_content("Event Topic", 14, FontWeight.w600, black),
                    Consumer<MainProvider>(
                        builder: (context, value, child) {
                          return Txtformfield("", value.eventTopicController);
                        }
                    ),
                    Page_content("Venue", 14, FontWeight.w600, black),
                    Consumer<MainProvider>(
                        builder: (context, value, child) {
                          return Txtformfield("", value.venueController);
                        }
                    ),

                    Page_content("Event Dates", 14, FontWeight.w600, black),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Consumer<MainProvider>(
                                  builder: (contextdate, value, child) {
                                    return TextFormField(
                                      onTap: () {
                                        value.selectEventStartDate(context,
                                            value.eventfromdateController);
                                        // SfDateRangePicker(
                                        //   //onSelectionChanged: _onSelectionChanged,
                                        //   selectionMode: DateRangePickerSelectionMode.range,
                                        // );
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "*Required field";
                                        }
                                        return null;
                                      },
                                      controller: value.eventfromdateController,
                                      keyboardType: TextInputType.none,
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(
                                            Icons.calendar_month_outlined),
                                        isDense: true,
                                        hintText: "Select start date",
                                        hintStyle: GoogleFonts.karma(textStyle:
                                        const TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: black,)),
                                        contentPadding: const EdgeInsets
                                            .symmetric(
                                            vertical: 10, horizontal: 15),
                                        filled: true,
                                        fillColor: textformcolor,
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: txtfrmbordercolor)),
                                        disabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: txtfrmbordercolor)),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: txtfrmbordercolor)),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red)),
                                        focusedErrorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red)),
                                      ),
                                    );
                                  }
                              ),
                            )
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Consumer<MainProvider>(
                                  builder: (contextdate, value, child) {
                                    return TextFormField(
                                      onTap: () {
                                        value.selectEventEndDate(context,
                                            value.eventTodateController);

                                        // print("daycount = ${value.dayCount}");
                                        // for (int i = 0; i < dayCount; i++) {
                                        //   topicControllers['eventTopic_day${i + 1}'] = TextEditingController();
                                        //   descriptionControllers['eventdescription_day${i + 1}'] = TextEditingController();
                                        // }

                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "*Required field";
                                        }
                                        return null;
                                      },
                                      controller: value.eventTodateController,
                                      keyboardType: TextInputType.none,
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(
                                            Icons.calendar_month_outlined),
                                        isDense: true,
                                        hintText: "Select end date",
                                        hintStyle: GoogleFonts.karma(textStyle:
                                        const TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: black,)),
                                        contentPadding: const EdgeInsets
                                            .symmetric(
                                            vertical: 10, horizontal: 15),
                                        filled: true,
                                        fillColor: textformcolor,
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: txtfrmbordercolor)),
                                        disabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: txtfrmbordercolor)),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: txtfrmbordercolor)),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red)),
                                        focusedErrorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red)),
                                      ),
                                    );
                                  }
                              ),
                            )
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        width: width,
                        alignment: Alignment.centerRight,
                        child: Consumer<MainProvider>(
                            builder: (ctx, value, child) {
                              return MaterialButton(
                                  onPressed: () {
                                    addDay = true;
                                    provider.clear_eventdaydetails();
                                    showEventdetails_alert(
                                        context, "new", "");
                                  },
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: adminblue,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: addDay == false ?
                                    Page_content("Enter Event Details", 16,
                                        FontWeight.bold, Colors.white) :
                                    Page_content("Add Next Day Details", 16,
                                        FontWeight.bold, Colors.white),
                                  )


                              );
                            }
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Consumer<MainProvider>(
                          builder: (ctx, value, child) {
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: value.EventDaysdetails_list_MP
                                    .length,
                                itemBuilder: (BuildContext ctx, int index) {
                                  //evnt_date = value.EventDaysdetails_list_MP[index].date.toString();
                                  //evnt_date = outputDateFormat.format(value.EventDaysdetails_list_MP[index].date);
                                  return Card(
                                    child: Container(
                                      //color: textformcolor,
                                      decoration: BoxDecoration(
                                          color: textformcolor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Page_content(value
                                                  .EventDaysdetails_list_MP[index]
                                                  .date, 15, FontWeight.bold,
                                                  maingreen),
                                              Page_content(value
                                                  .EventDaysdetails_list_MP[index]
                                                  .dayTopic, 15,
                                                  FontWeight.bold, maingreen),
                                              Divider(
                                                color: maingreen.withOpacity(
                                                    .25),),
                                              Page_content(value
                                                  .EventDaysdetails_list_MP[index]
                                                  .dayDescription, 15,
                                                  FontWeight.w500, black),
                                              //SizedBox(height: 10,)
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .end,
                                                children: [
                                                  IconButton(
                                                      alignment: Alignment
                                                          .bottomRight,
                                                      onPressed: () {
                                                        provider
                                                            .update_dayalert(
                                                            value
                                                                .EventDaysdetails_list_MP[index]);
                                                        showEventdetails_alert(
                                                            ctx, "edit", value
                                                            .EventDaysdetails_list_MP[index]);
                                                      },
                                                      icon: Icon(
                                                        Icons.edit_square,
                                                        size: 20,),
                                                      padding: EdgeInsets.zero),
                                                  IconButton(
                                                      alignment: Alignment
                                                          .bottomLeft,
                                                      onPressed: () {
                                                        value
                                                            .EventDaysdetails_list_MP
                                                            .removeAt(index);
                                                        provider
                                                            .notifyListeners();
                                                      },
                                                      icon: Icon(Icons.delete,
                                                        color: Colors.red,
                                                        size: 20,),
                                                      padding: EdgeInsets.zero),
                                                ],
                                              ),

                                            ]
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            );
                          }
                      ),
                    ),
                    SizedBox(height: 20,),

                    // Consumer<MainProvider>(
                    //     builder: (context, value, child) {
                    //       return Text(
                    //         'Selected Items: ${value.selectedItems.join(', ')}',
                    //         style: TextStyle(fontSize: 16),
                    //       );
                    //     }
                    // ),
                    // SizedBox(height: 20),

                    Consumer<MainProvider>(
                        builder: (context, PROVIDER_value, child) {
                        //   return DropDownMultiSelect(
                        //     decoration: InputDecoration(
                        //       isDense: true,
                        //       hintText: 'Select Speaker',
                        //       hintStyle: GoogleFonts.karma(textStyle:
                        //       const TextStyle(fontSize: 15,
                        //         fontWeight: FontWeight.w500,
                        //         color: black,)),
                        //       contentPadding: const EdgeInsets.symmetric(
                        //           vertical: 10, horizontal: 15),
                        //       filled: true,
                        //       fillColor: textformcolor,
                        //       enabledBorder: const OutlineInputBorder(
                        //           borderSide: BorderSide(
                        //               color: txtfrmbordercolor)),
                        //       disabledBorder: const OutlineInputBorder(
                        //           borderSide: BorderSide(
                        //               color: txtfrmbordercolor)),
                        //       focusedBorder: const OutlineInputBorder(
                        //           borderSide: BorderSide(
                        //               color: txtfrmbordercolor)),
                        //       errorBorder: const OutlineInputBorder(
                        //           borderSide: BorderSide(color: Colors.red)),
                        //       focusedErrorBorder: const OutlineInputBorder(
                        //           borderSide: BorderSide(color: Colors.red)),
                        //     ),
                        //     options: PROVIDER_value.Speaker_list,
                        //
                        //     // options: PROVIDER_value.Speaker_list.map((
                        //     //        EventSpeakers speaker) {speaker.name;}).toList(),
                        //     //options: ,
                        //     //       EventSpeakers speaker),
                        //     selectedValues: PROVIDER_value.selectedItems,
                        //     onChanged: (List<dynamic> val)
                        //     {
                        //       PROVIDER_value.selectedItems = val;
                        //       print(val);
                        //     },
                        //
                        //
                        //     // onChanged: (List<String> value) {
                        //     //   //   value = selectedCheckBoxValue;
                        //     //   print("${selectedCheckBoxValue}");
                        //     //
                        //     // },
                        //     whenEmpty: 'Select Speaker',
                        //   );
                        // }
                        // ),
                          ///////////////////////////////////////////////////////////
                          return DropdownButtonFormField<String>(
                            isExpanded: true,
                            //hint: Text('Select Speaker'),
                            value: null,
                            // Initially no value is selected
                            onChanged: (String? val) {
                              if (val != null) {
                                EventSpeakers selectedValue = PROVIDER_value.Speaker_list.firstWhere((item) => item.name == val);
                                print('Selected: ${selectedValue.designation}');
                                provider.onItemSelect(selectedValue);
                                // Perform actions with selectedItem
                                bool isChecked = provider.checkboxState[selectedValue] ?? false;
                                provider.updateCheckboxState(selectedValue, !isChecked);
                              }
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Select Speaker',
                              hintStyle: GoogleFonts.karma(textStyle:
                              const TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: black,)),
                              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              filled: true,
                              fillColor: textformcolor,
                              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: txtfrmbordercolor)),
                              disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: txtfrmbordercolor)),
                              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: txtfrmbordercolor)),
                              errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                            ),
                            borderRadius: BorderRadius.circular(10),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "*Required field";
                              }
                              return null;
                            },
                            items: PROVIDER_value.Speaker_list.map((EventSpeakers speaker) {

                              return DropdownMenuItem<String>(
                                //value: speaker.name,
                                value: "Select Speakers",
                                child: Row(
                                  children: <Widget>[

                                    Checkbox(
                                      value: provider.checkboxState[speaker] ?? false,
                                      onChanged: (bool? val) {

                                        provider.onItemSelect(speaker);
                                        provider.updateCheckboxState(speaker, val!);
                                        provider.notifyListeners();


                                      },
                                    ),
                                    SizedBox(width: 10),
                                    Page_content(speaker.name, 15, FontWeight.w600, Colors.black)

                                  ],
                                ),
                              );
                            }).toList(),


                          );
                          //////////////////////////////////////////////////////
                          // return DropdownButtonFormField<EventSpeakers>(
                          //   hint: Text('Select an item'),
                          //   value: null,
                          //   onChanged: (EventSpeakers? newValue) {
                          //     if (newValue != null) {
                          //       bool isChecked = provider.checkboxState[newValue] ?? false;
                          //       provider.updateCheckboxState(newValue, !isChecked);
                          //     }
                          //   },
                          //   items: PROVIDER_value.Speaker_list.map((EventSpeakers item) {
                          //     return DropdownMenuItem<EventSpeakers>(
                          //       value: item,
                          //       child: Row(
                          //         children: <Widget>[
                          //           Checkbox(
                          //             value: PROVIDER_value.checkboxState[item] ?? false,
                          //             onChanged: (bool? value) {
                          //               if (value != null) {
                          //                 PROVIDER_value.updateCheckboxState(item, value);
                          //                 provider.onItemSelect(item);
                          //               }
                          //             },
                          //           ),
                          //           Text(item.name),
                          //         ],
                          //       ),
                          //     );
                          //   }).toList(),
                          // );
                        }
                    ),

                    sizebox(),
                    SizedBox(
                        child: Consumer<MainProvider>(
                            builder: (context, value, child) {
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: value.selectedItems.length,
                                itemBuilder: (BuildContext ctx, int index) {
                                  return ListTile(
                                    title: Page_content(
                                        value.Speakers[index].name, 16,
                                        FontWeight.bold, Colors.black),
                                    subtitle: Page_content(
                                        value.Speakers[index].designation, 15,
                                        FontWeight.w600, Colors.black),
                                    leading: Container(
                                        height: 120,
                                        width: 100,
                                        child: value.Speakers[index]
                                            .speaker_photo != "" ?
                                        Image.network(
                                          value.Speakers[index].speaker_photo!,
                                          fit: BoxFit.fill,) :
                                        Image.asset(
                                          "assets/icons/userblack.png",
                                          fit: BoxFit.fill,)
                                      //Image.file(value.Speaker_list[index].speaker_photo!,fit: BoxFit.fill,) :,
                                    ),
                                  );
                                },
                              );
                            }
                        )
                    ),


                    Container(
                      width: width,
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        onPressed: ()
                        {
                          if (_formKey.currentState!.validate())
                          {
                            addDay = false;
                            provider.add_Events(context, ID, from);
                          }
                        },
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: adminblue,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Page_content(
                              "Save", 18, FontWeight.bold, Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }


  void showEventdetails_alert(BuildContext context, String from, var index) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            //title:  Page_content("Enter Event Details", 18, FontWeight.bold, adminblue),
            //titlePadding: EdgeInsets.only(left: 20),
            alignment: Alignment.center,
            content: SingleChildScrollView(
              child: Container(
                //width: 500,
                height: 370,
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.vertical(
                        bottom: Radius.circular(10), top: Radius.circular(10))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Page_content(
                          "Enter Event Details", 18, FontWeight.bold,
                          adminblue),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Consumer<MainProvider>(
                          builder: (context11, value, child) {
                            return TextFormField(
                              onTap: () {
                                value.selectEventDate(
                                    context, value.eventday_controller);
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "*Required field";
                                }
                                return null;
                              },
                              controller: value.eventday_controller,
                              keyboardType: TextInputType.none,
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.calendar_month_outlined),
                                isDense: true,
                                hintText: "Select date",
                                hintStyle: GoogleFonts.karma(textStyle:
                                const TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: black,)),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                filled: true,
                                fillColor: textformcolor,
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: txtfrmbordercolor)),
                                disabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: txtfrmbordercolor)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: txtfrmbordercolor)),
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                              ),
                            );
                          }
                      ),
                    ),
                    Consumer<MainProvider>(
                        builder: (context11, value, child) {
                          return Txtformfield_eventdaytopic(
                              "Enter Day Topic", value.dayTopiccontroller);
                        }
                    ),
                    Consumer<MainProvider>(
                        builder: (context12, value, child) {
                          return TxtformfieldeventDescription(
                              "Enter Description",
                              value.dayDescriptioncontroller);
                        }
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      alignment: Alignment.centerRight,
                      child: Consumer<MainProvider>(
                          builder: (context13, value, child) {
                          return MaterialButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                value.add_eventdaydetails(from, index);
                                value.notifyListeners();
                                value.clear_eventdaydetails();
                                back(context);
                              }
                            },
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: adminblue,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Page_content(
                                  "Save", 18, FontWeight.bold, Colors.white),
                            ),
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
            ),
            contentPadding: EdgeInsets.zero,

          ),
    );
  }

}




