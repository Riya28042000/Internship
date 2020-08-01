import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:regis_login/components/button.dart';
import 'package:regis_login/components/text_form_field.dart';
import 'package:regis_login/darkmode.dart/dark.dart';
import 'package:regis_login/pages/login.dart';
import 'package:regis_login/services/auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Forgot extends StatefulWidget {
  @override
  _ForgotState createState() => _ForgotState();
}
GlobalKey<FormState> validatekey = GlobalKey<FormState>();
final _scaffoldKey = GlobalKey<ScaffoldState>();
bool isLoading=false;
  AuthMethods authMethods= AuthMethods();
  TextEditingController email= TextEditingController();
 
 
class _ForgotState extends State<Forgot> {
  void forgot(String email)async{
   setState(() {
      isLoading=true;
    });
   if (validatekey.currentState.validate()) {
   validatekey.currentState.reset();
      await authMethods.resetPass(email).then((onValue){
         setState(() {
      isLoading=false;
    });
        Alert(
            context: context,
            
            type: AlertType.success,
            title: "PASSWORD RESET",
            style:AlertStyle(
              backgroundColor: Theme.of(context).cardColor,
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontSize: 18,color: Theme.of(context).textSelectionColor),
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
            desc: "Check your Email to reset Password!",
            buttons: [
              DialogButton(
                color: Color(0xff3671a4),
                child: Text(
                  "OK",
                  style: TextStyle(fontSize: 20,color: Colors.white),
                ),
                onPressed: () => Navigator.of(context).pop()
              )
            ],
          ).show();
       print('email sent');
      }).catchError((onError){
        switch(onError.toString()){
   case 'PlatformException(ERROR_USER_NOT_FOUND, There is no user record corresponding to this identifier. The user may have been deleted., null)':{
      Alert(
            context: context,
            
            type: AlertType.error,
            title: "ERROR",
            style:AlertStyle(
      animationType: AnimationType.fromTop,
      backgroundColor: Theme.of(context).cardColor,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(color: Theme.of(context).textSelectionColor, fontSize: 18),
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
            desc: "Please Register Yourself!",
            buttons: [
              DialogButton(
                color: Color(0xff3671a4),
                child: Text(
                  "OK",
                  style: TextStyle(fontSize: 20,color: Colors.white),
                ),
                onPressed: () =>  Navigator.of(context).pop(),)
            ],
          ).show();
        setState(() {
          isLoading=false;
        });
   }
   break;
   case 'PlatformException(ERROR_NETWORK_REQUEST_FAILED, A network error (such as timeout, interrupted connection or unreachable host) has occurred., null)':{
           Alert(
            context: context,
            
            type: AlertType.error,
            title: "ERROR",
            style:AlertStyle(
      animationType: AnimationType.fromTop,
      backgroundColor: Theme.of(context).cardColor,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontSize: 18,color: Theme.of(context).textSelectionColor),
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
            desc: "Check your connection!",
            buttons: [
              DialogButton(
                color: Color(0xff3671a4),
                child: Text(
                  "OK",
                  style: TextStyle(fontSize: 20,color: Colors.white),
                ),
                onPressed: () =>  Navigator.of(context).pop()
              )
            ],
          ).show();
        setState(() {
          isLoading=false;
        });
   }
        break;
        default:{
                Alert(
            context: context,
            
            type: AlertType.error,
            title: "ERROR",
            style:AlertStyle(
      animationType: AnimationType.fromTop,
      backgroundColor: Theme.of(context).cardColor,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontSize: 18,color: Theme.of(context).textSelectionColor),
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
            desc: "Someting went wrong!",
            buttons: [
              DialogButton(
                color: Color(0xff3671a4),
                child: Text(
                  "OK",
                  style: TextStyle(fontSize: 20,color: Colors.white),
                ),
                onPressed: () =>  Navigator.of(context).pop()
              )
            ],
          ).show();
        setState(() {
          isLoading=false;
        });
        }
        
        }
                print(onError);
     
      });
   }
   
}
@override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
      _displaySnackBar(BuildContext context, String a) {
      final snackBar = SnackBar(
        content: Text(a,style: TextStyle(color:themeProvider.darkTheme
                                    ? Colors.black
                                    : Colors.white,fontWeight: FontWeight.bold) ,textAlign: TextAlign.center),
        backgroundColor: themeProvider.darkTheme
                                    ? Colors.white
                                    : Colors.black,
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
    return isLoading? Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).backgroundColor,)):Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          //    padding: const EdgeInsets.only(top:70),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                     Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false);
                          },
                        )),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 27),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            // height: 300,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  //     Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50, left: 30),
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionColor,
                                          fontSize: 27,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 30, top: 5),
                                    child: Text(
                                      'Enter your email to change your Password',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    ),
                                  ),
                                 SizedBox(height: 25),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Text(
                                        'Email',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    //SizedBox(height: _animation.value),
                                    Form(
                                      key: validatekey,
                                                                          child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, top: 5, right: 30),
                                          child: TexFormField(
                                            hinttext: "Enter your email",
                                            text: email,
                                            inputType: TextInputType.emailAddress,
                                            obscure: false,
                                          )),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                 
                                 
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, left: 30, right: 30),
                                    child: Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Button(
                                          ontap: () {
                                                   print(email);
                        validatekey.currentState.save();
                        if (email.text.isEmpty) {
                          _displaySnackBar(context, "Please enter your Email");
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(email.text))
                          _displaySnackBar(context, "Please Fill valid Email");
                       
                        else {
                           forgot(email.text);
                        }
                                          
                                          },
                                          buttoncol:
                                              Theme.of(context).backgroundColor,
                                          sidecol:
                                              Theme.of(context).backgroundColor,
                                          textcol: Colors.white,
                                          radius: 10,
                                          abc: Text(
                                            'Change Password',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        )),
                                  ),
                                ])),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}