import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:provider/provider.dart';
import 'package:regis_login/darkmode.dart/dark.dart';
import 'package:regis_login/pages/choice.dart';
import 'package:regis_login/services/auth.dart';
import 'package:regis_login/services/preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Name{
  String field;
  Name({this.field});
  }
 List name=[
Name(
  field: "App Design"
),
Name(
  field: "Social Media"
),
Name(
  field: "Web Design"
),
 ];
class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  AuthMethods authMethods= AuthMethods();
void signout()async{
    await authMethods.signOutGoogle();
     HelperFunctions.saveUserLoggedInSharedPreference(false);
  Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Choice()),
        (Route<dynamic> route) => false);
}

  Widget item(Color color, final String name) {
    return Material(
      type: MaterialType.circle,
      clipBehavior: Clip.antiAlias,
      color: color,
      child: InkWell(
        onTap: () {
          print(name);
        },
        customBorder: CircleBorder(),
        child: SizedBox(
          width: 20.0,
          height: 20.0,
        ),
      ),
    );
  }
  Future <bool> _SaveAndBack(){
           return         Alert(
            context: context,
            
            type: AlertType.warning,
            title: "ALERT",
            style:AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      
      backgroundColor: Theme.of(context).cardColor,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(color:Theme.of(context).textSelectionColor, fontSize: 18),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
         // color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        fontWeight: FontWeight.bold,
       color: Theme.of(context).textSelectionColor
      ),
    ),
            desc: "Do you want to exit?",
            
            buttons: [
              DialogButton(
                color: Color(0xff3671a4),
                child: Text(
                  "NO",
                  style: TextStyle(fontSize: 20,color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context,false)
              ),
              DialogButton(
                color: Color(0xff3671a4),
                child: Text(
                  "YES",
                  style: TextStyle(fontSize: 20,color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context,true)
              )
            ],
          ).show();
          
  }
  @override
  Widget build(BuildContext context) {
      
      final themeProvider = Provider.of<DarkThemeProvider>(context);
    return WillPopScope(
      onWillPop: _SaveAndBack,
          child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
                child: Padding(
            padding: const EdgeInsets.only(top:50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: <Widget>[
  
  Padding(padding: EdgeInsets.only(left: 30),
  child: Text('Good Morning,',style: TextStyle(color:Colors.grey,fontSize:25),),
  ),
  Row(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(right: 30),
        child: IconButton(icon: Icon(Icons.brightness_3), onPressed: (){
          themeProvider.darkTheme = !themeProvider.darkTheme;
          },
          color: Theme.of(context).textSelectionColor,
          )
        ),
             Padding(padding: EdgeInsets.only(right: 30),
        child: IconButton(icon: Icon(Icons.exit_to_app), onPressed: ()async{
   signout();
          },
          color: Theme.of(context).textSelectionColor,
          )
        ),
      ],
  )
],),
SizedBox(height:3),
 Padding(padding: EdgeInsets.only(left: 30),
  child: Text('Varun',style: TextStyle(color:Theme.of(context).textSelectionColor,fontSize:25,fontWeight: FontWeight.bold),),
  ),
SizedBox(height:15),
Padding(padding: EdgeInsets.only(right: 30,left:30),
child: TextField(
      cursorColor: Colors.black,
      
  decoration: InputDecoration(
  hintText: "Search",
            prefixIcon:Icon(Icons.search,color: Theme.of(context).backgroundColor,),
            suffixIcon: Icon(Icons.keyboard_voice,color: Theme.of(context).backgroundColor,),
            fillColor: Color(0xfff1f1f1),
            filled: true,
              hintStyle: TextStyle(
                           color: Colors.grey,
                           fontWeight: FontWeight.bold),
                              focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                             color: Color(0xfff1f1f1),
                             style: BorderStyle.solid,
                             width: 2),
                            borderRadius: BorderRadius.circular(15.0),
                          ),   
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                            color: Color(0xfff1f1f1),
                             style: BorderStyle.solid,
                             width: 2),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
          ),
),
),
SizedBox(height: 15),
Padding(padding: EdgeInsets.only(left: 30),
  child: Text('Projects',style: TextStyle(color:Theme.of(context).textSelectionColor,fontSize:25,fontWeight: FontWeight.bold),),
  ),
  SizedBox(height:15),
  Padding(padding: EdgeInsets.only(left:30),
  child:    AspectRatio(
                                              child: ListView.builder(
                            itemCount: name.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => AspectRatio(
                                                        child: Card(
                                      elevation: 5,
                                      color: Theme.of(context).backgroundColor,
                                      margin: EdgeInsets.all(8.0),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Theme.of(context).backgroundColor, width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                         Padding(
                                           padding: const EdgeInsets.only(top:20),
                                           child: CircularPercentIndicator(
                    radius: 100.0,
                    lineWidth: 10.0,
                //    arcBackgroundColor: Colors.black,
                    percent: 0.75,
                    center: new Text("75%",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
                    progressColor: Colors.white,
                  ),
                  
                                         ),
                                         SizedBox(height: 20,),
                                         Text(name[index].field,style: TextStyle(color:Colors.white,fontSize: 20),),
                                         SizedBox(height:20),
                                         Padding(
                                           padding: const EdgeInsets.only(left:30,bottom: 30),
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: <Widget>[
                                               Row(
                                                 mainAxisAlignment: MainAxisAlignment.center,
                                                 
                                                 children: <Widget>[

                                                 Align(
              widthFactor: 0.5,
              child: item(Color(0xfff1f1f1), "Item One"),
            ),
            Align(
              widthFactor: 0.5,
              child: item(Colors.grey, "Item Two"),
            ),
            Align(
              widthFactor: 0.5,
              child: item(Color(0xfff1f1f1), "Item Three"),
            ),
                                               ],),
                                               Padding(
                                                 padding: const EdgeInsets.only(right:20),
                                                 child: Container(
                                                   width: 20,
                                                   height: 20,
           // margin: EdgeInsets.all(100.0),
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle
            ),
            child: Center(child: Text("4+",style: TextStyle(color:Colors.white),)),
            ),
                                               )
                                             ],
                                           ),
                                         )
                                           
                                        ],
                                      )), aspectRatio: 35/50,
                            ),
                          ), aspectRatio: 37/30,
                        ),
  ),
  SizedBox(height:15),
  Padding(
      padding: const EdgeInsets.only(left:30,right:30),
      child: Row(
        //   mainAxisAlignment:MainAxisAlignment.spaceEvenly,
         //  crossAxisAlignment: CrossAxisAlignment.stretch,
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
           
      Container(
       height: 60,
       width: MediaQuery.of(context).size.width/3,
          child: Center(
      child:Text("Request Service",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)
          ),
          //   width:MediaQuery.of(context).size.width/2,
        decoration: BoxDecoration(
           color: Theme.of(context).backgroundColor,
        border: Border.all(
          color: Theme.of(context).backgroundColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20))
  ),
  ),
  SizedBox(width:12),
       Container(
       height: 60,
          width: MediaQuery.of(context).size.width/3,
        child: Center(
      child:Text("Support",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)
          ),
        decoration: BoxDecoration(
           color: Theme.of(context).backgroundColor,
        border: Border.all(
          color: Theme.of(context).backgroundColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20))
  ),
      )
          ],
        ),
  ),
      SizedBox(height:15),
  Padding(
      padding: const EdgeInsets.only(left:30,right:30),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
        
        
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
           
      Container(
       height: 60,
       width: MediaQuery.of(context).size.width/3,
        child: Center(
      child:Text("Appointment",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)
          ),
         //    width:MediaQuery.of(context).size.width/2,
        decoration: BoxDecoration(
           color: Theme.of(context).backgroundColor,
        border: Border.all(
          color: Theme.of(context).backgroundColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20))
  ),
  ),
  SizedBox(width:12),
       Container(
           child: Center(
      child:Text("News",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)
          ),
       height: 60,
      width: MediaQuery.of(context).size.width/3,
        //   width: 200,
        decoration: BoxDecoration(
           color: Theme.of(context).backgroundColor,
        border: Border.all(
          color: Theme.of(context).backgroundColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20))
  ),
      )
          ],
        ),
  ),
  SizedBox(height:20),
  Padding(
      padding: const EdgeInsets.only(left:30,right:30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('Today',style:TextStyle(fontSize: 30, color:Theme.of(context).textSelectionColor,fontWeight:FontWeight.bold)),
        Text('Week',style:TextStyle(fontSize: 30, color:Theme.of(context).textSelectionColor)),
        Text('Month',style:TextStyle(fontSize: 30, color:Theme.of(context).textSelectionColor))
   
        ],
      ),
  ),
  Padding(
      padding: const EdgeInsets.only(left:55),
      child: Container(
        height:5.0,
        width:40,
        color:Theme.of(context).backgroundColor
      ),
  ),
  SizedBox(height:20),
   Padding(
       padding: const EdgeInsets.only(left:30,right: 30),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.start,
         children: <Widget>[
            Container(
              height:25,
              width: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context)
                    .backgroundColor,
              ),
              child: Center(            
                child: Center(
                  child:Icon(
                        Icons.check,
                        size: 12.0,
                        color: Colors.white,
                      ),
                )
         
              )
            ),
            Padding(
              padding: const EdgeInsets.only(left:20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                 
               Text('Republic Day Creative',style: TextStyle(color:Theme.of(context).textSelectionColor,fontSize:17,fontWeight: FontWeight.bold),),
                Text('Social Media Creative',style: TextStyle(color:Colors.grey,fontSize:15),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:35,right: 2),
              child: Text('10.20 am',style: TextStyle(color:Colors.grey,fontSize:16),),
            )
         ],
       ),

   ),
   SizedBox(height:7),
      Padding(
       padding: const EdgeInsets.only(left:30,right: 30),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.start,
         children: <Widget>[
            Container(
              height:25,
              width: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context)
                    .backgroundColor,
              ),
              child: Center(            
                child: Center(
                  child:Icon(
                        Icons.check,
                        size: 12.0,
                        color: Colors.white,
                      ),
                )
         
              )
            ),
            Padding(
              padding: const EdgeInsets.only(left:20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                 
               Text('Sales Post for Campaign',style: TextStyle(color:Theme.of(context).textSelectionColor,fontSize:17,fontWeight: FontWeight.bold),),
                Text('Social Media Creative',style: TextStyle(color:Colors.grey,fontSize:15),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15,right: 2),
              child: Text('03.40 pm',style: TextStyle(color:Colors.grey,fontSize:16),),
            )
         ],
       ),

   ),
   SizedBox(height:50)
              ],
            ),
          ),
        ),

      ),
    );
  }
}