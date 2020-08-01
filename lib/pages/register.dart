import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:regis_login/components/button.dart';
import 'package:regis_login/components/text_form_field.dart';
import 'package:regis_login/darkmode.dart/dark.dart';
import 'package:regis_login/pages/choice.dart';
import 'package:regis_login/pages/login.dart';
import 'package:regis_login/pages/otp.dart';
import 'package:regis_login/services/auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

GlobalKey<FormState> validatekey = GlobalKey<FormState>();
final _scaffoldKey = GlobalKey<ScaffoldState>();
class _RegisterState extends State<Register> {
  AuthMethods authMethods= AuthMethods();
  String val;
   final databaseReference = Firestore.instance;
  TextEditingController name = TextEditingController();
  
   bool validateAndSave() {
    final FormState form = validatekey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
bool isLoading= false;
  void signUp(String email, String pass) async{
    setState(() {
      isLoading=true;
    });

   await authMethods.signUpwithEmailAndPassword(email, pass).then((value){
      
     if(value!=null){
    databaseReference.collection("register")
        .add({
          'name': name.text,
          'email': email,
           'phone': phone.text
        }).then((onValue){
                   setState(() {
      isLoading=false;
    });
             Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        OTP(phone: phone,)),
                                                ModalRoute.withName('/'),
                                              );
        });
     }
     //ending if
     
    }).catchError((onError){
          print(onError);
          switch(onError.toString()){
   case 'PlatformException(ERROR_NETWORK_REQUEST_FAILED, A network error (such as timeout, interrupted connection or unreachable host) has occurred., null)':
       val= "Check your connection!";
       break;
    case 'PlatformException(ERROR_EMAIL_ALREADY_IN_USE, The email address is already in use by another account., null)':  
       val="User already registered!";
       break;
    default: val= "Something went wrong!";
          }

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
            desc: val,
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
setState(() {
      isLoading=false;
    });
    });

  


  }


  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool checkboxvalue = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
      _displaySnackBar(BuildContext context, String a) {
      final snackBar = SnackBar(
        content: Text(a,
            style: TextStyle(
                color: themeProvider.darkTheme ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        backgroundColor: themeProvider.darkTheme ? Colors.white : Colors.black,
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
    return isLoading? Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).backgroundColor)):Scaffold(
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
        MaterialPageRoute(builder: (context) => Choice()),
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
                            child: Form(
                              key: validatekey,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    //     Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 50, left: 30),
                                      child: Text(
                                        'Welcome',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textSelectionColor,
                                            fontSize: 27,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30, top: 5),
                                      child: Text(
                                        'Hello there, sign up to continue',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(height: 40),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Text(
                                        'Name',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, top: 5, right: 30),
                                        child: TexFormField(
                                          hinttext: "Enter your Business Name",
                                          text: name,
                                          inputType: TextInputType.text,
                                          obscure: false,
                                        )),
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
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, top: 5, right: 30),
                                        child: TexFormField(
                                          hinttext: "Enter your Business Email",
                                          text: email,
                                          inputType: TextInputType.emailAddress,
                                          obscure: false,
                                        )),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    SizedBox(height: 25),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Text(
                                        'Mobile Number',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, top: 5, right: 30),
                                        child: TexFormField(
                                          hinttext: "+91 - XXXXXXXXXX",
                                          text: phone,
                                          inputType: TextInputType.phone,
                                          obscure: false,
                                        )),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    SizedBox(height: 25),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Text(
                                        'Password',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, top: 5, right: 30),
                                        child: TexFormField(
                                          hinttext: "Enter your Pasword",
                                          text: pass,
                                          inputType: TextInputType.text,
                                          obscure: true,
                                        )),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(left: 30),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  checkboxvalue =
                                                      !checkboxvalue;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Theme.of(context)
                                                      .backgroundColor,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: checkboxvalue
                                                      ? Icon(
                                                          Icons.check,
                                                          size: 12.0,
                                                          color: Colors.white,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .check_box_outline_blank,
                                                          size: 10.0,
                                                          color: Colors.white,
                                                        ),
                                                ),
                                              ),
                                            )),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: 8, top: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'By creating an account you agree to our',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                'terms and conditions.',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .backgroundColor),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
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
                             if(name.text.isEmpty) 
                              {
                                 {  _displaySnackBar(context, "Please enter your Name");
                              
                                }
                              }

                            else if (email.text.isEmpty) {
                              _displaySnackBar(context, "Please enter your Email");
                            } else if (!RegExp(
                  r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(email.text))
                              _displaySnackBar(context, "Please Fill valid Email");
                            else if (pass.text.isEmpty)
                              _displaySnackBar(
                                  context, "Please enter your Password");
                            else
                              if(phone.text.isEmpty) 
                              {
                                 {  _displaySnackBar(context, "Please enter your Phone Number");
                              
                                }
                              }
                              else
if(pass.text.length<8)
                        _displaySnackBar(context, "Password must be atleast 8 characters long");
                              else if(phone.text.length!=10){
                          _displaySnackBar(context, "Please enter valid Phone Number");
                              }
                              else if(checkboxvalue==false){
                                 _displaySnackBar(context, "Please Agree to the terms and conditions.");
                              }
                              
                        else{
                          signUp(email.text,pass.text);
                        }
                                            },
                                            buttoncol: Theme.of(context)
                                                .backgroundColor,
                                            sidecol: Theme.of(context)
                                                .backgroundColor,
                                            textcol: Colors.white,
                                            radius: 10,
                                            abc: Text(
                                              'Sign Up',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Already have an account?',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        Login()),
                                                ModalRoute.withName('/'),
                                              );
                                            },
                                            child: Text(
                                              ' Sign In',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .backgroundColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20)
                                  ]),
                            )),
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
