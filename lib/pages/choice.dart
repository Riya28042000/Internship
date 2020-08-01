import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:regis_login/components/button.dart';
import 'package:regis_login/darkmode.dart/dark.dart';
import 'package:regis_login/navigationbar/navigation.dart';
import 'package:regis_login/pages/dashboard.dart';
import 'package:regis_login/pages/login.dart';
import 'package:regis_login/pages/register.dart';
import 'package:regis_login/services/auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Choice extends StatefulWidget {
  @override
  _ChoiceState createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  bool isLoading=false;
    AuthMethods authMethods= AuthMethods();
 void google() async{
     setState(() {
      isLoading=true;
    });

await authMethods.signInWithGoogle().whenComplete(() {  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Navigation()),
  );  
   setState(() {
      isLoading=true;
    });
  }
  
  );}
  
  @override
  Widget build(BuildContext context) {
      final themeProvider = Provider.of<DarkThemeProvider>(context);
    return isLoading? Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).backgroundColor)):Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom:90,left:50,right:50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
             mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Spacer(),
                Text(
                'Welcome',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                    
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                SizedBox(height:15),
                Text(
                  'Manage your Business',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height:6),
                Text(
                  'seamlessly & intuitively',
                  style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  child: Button(
                    ontap: (){
                      google();
                    },
                    abc: Stack(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: <Widget>[
                     Align(
                       alignment: Alignment.centerLeft,
                       child: Icon(Icons.g_translate,color: Theme.of(context).backgroundColor,)),
                     Align(
                       alignment: Alignment.center,
                       child: Text("Sign In With Google",style: TextStyle(color:Theme.of(context).backgroundColor,fontWeight: FontWeight.bold),))
                   ],
               ),
               radius: 10,
               sidecol:Colors.white ,
               textcol: Theme.of(context).backgroundColor,
               buttoncol: Colors.white,
                  ),
                ),
                SizedBox(height:15),
                Container(
                  height: 50,
                  child: Button(
                    ontap: (){
                    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Register()),
        (Route<dynamic> route) => false);
                    },
                    sidecol: Colors.white,
                    abc:  Text(
                      'Create an Account',
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    ),
                    textcol: Colors.white,
                    buttoncol: Theme.of(context).backgroundColor,
radius: 10,
                  ),

                ),
                SizedBox(height:20),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Already have an account?',style: TextStyle(color:Colors.white,fontSize: 15),),
                      GestureDetector(
                        onTap: (){
                     Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false);
                        },
                        child: Text(' Sign in',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
