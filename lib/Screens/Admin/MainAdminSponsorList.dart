import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constants/Call_Functions.dart';
import '../../Constants/Colors.dart';
import '../../Constants/MyWidgets.dart';
import '../../Constants/sponsor_details.dart';
import '../../Provider/Main_Provider/MainProvider.dart';
import 'MAaddSponsor.dart';

class MainAdminSponsorList extends StatelessWidget {
  const MainAdminSponsorList({super.key});

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

        floatingActionButton: FloatingActionButton(
          elevation: 10,
          backgroundColor: adminblue,
          onPressed: (){
            provider.clear_Sponsordata();
            callNext(context, MAaddSponsor(ID: "",from: "New",));

            //provider.cleardata();
            //Navigator.push(context, MaterialPageRoute(builder: (context) => AddDetails(ID: "", todo: 'New',)));
          },
          //tooltip: 'Increment Press',
          child: const Icon(Icons.add,color: Colors.white,size: 30,),
        ),

        body: Padding(
            padding: EdgeInsets.all(25),
          child: SizedBox(
            width: width,
            child: Consumer<MainProvider>(
              builder: (context, value, child) {
                return GridView.builder(physics:NeverScrollableScrollPhysics(),

                  shrinkWrap: true,
                  itemCount: value.Sponsor_list.length,

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 170
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        callNext(context, MAaddSponsor(ID: value.Sponsor_list[index].id, from: "Edit",));
                      },
                      child: Container(

                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: value.Sponsor_list[index].sponsor_photo != "" ?
                                NetworkImage(value.Sponsor_list[index].sponsor_photo) :
                                AssetImage("assets/icons/userblack.png") as ImageProvider ,
                                fit: BoxFit.fill
                            )
                        ),
                        alignment: Alignment.bottomRight,
                        child: Container(
                          color: mainAdminfldclr,
                          height: 40,
                          width: 40,
                          child: IconButton(
                              onPressed: ()
                              {
                                provider.Delete_Sponsoralert(context,"Do you want to delete this sponsor?",value.Sponsor_list[index].id);
                              },
                              icon: Icon(Icons.delete,color: Colors.red,))
                          //Icon(Icons.delete,color: Colors.red,),
                        ),
                      ),
                    );
                  },
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
