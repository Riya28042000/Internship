import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:regis_login/components/box.dart';
import 'package:regis_login/components/button.dart';
import 'package:regis_login/darkmode.dart/dark.dart';
import 'package:regis_login/pages/dashboard.dart';
import 'package:regis_login/pages/login.dart';
import 'package:regis_login/pages/register.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OTP extends StatefulWidget {
TextEditingController phone;
OTP({this.phone});
  @override
  _OTPState createState() => _OTPState(phonestate: this.phone);
}
final _scaffoldKey = GlobalKey<ScaffoldState>();
class _OTPState extends State<OTP> {
  
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String smsCode;
  TextEditingController phonestate;
  TextEditingController firstcontroller=TextEditingController();
  TextEditingController secondcontroller=TextEditingController();
  TextEditingController thirdcontroller=TextEditingController();
  TextEditingController fourthcontroller=TextEditingController();
  TextEditingController fifthcontroller=TextEditingController();
  TextEditingController sixthcontroller=TextEditingController();


  _OTPState({this.phonestate});
  bool val = false;
  bool isLoading=false;
  bool isCodeSent = false;
  String _verificationId;
  void check() {}
    @override
  void initState() {
    super.initState();
    _onVerifyCode();
  }
   void _onVerifyCode() async {
    setState(() {
      isCodeSent = true;
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((AuthResult value) {
        if (value.user != null) {
          // Handle loogged in state
          setState(() {
            isLoading=true;
          });
          print(value.user.phoneNumber);
      
             Alert(
            context: context,
            
            type: AlertType.success,
            title: "SUCCESS",
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
            desc: 'Phone Verification Successfull!',
            buttons: [
              DialogButton(
                color: Color(0xff3671a4),
                child: Text(
                  "OK",
                  style: TextStyle(fontSize: 20,color: Colors.white),
                ),
                onPressed: () =>     Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Login(
                  
                ),
              ),
              (Route<dynamic> route) => false)
              )
            ],
          ).show();
              setState(() {
                isLoading=false;
              });
        } else {
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
            desc: 'Error Validating OTP',
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
        }
      }).catchError((error) {
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
            desc: 'Try again in some time!',
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
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
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
            desc: authException.message,
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
        isCodeSent = false;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    // TODO: Change country code

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91${widget.phone.text}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _onFormSubmitted() async {
    AuthCredential _authCredential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode:firstcontroller.text+secondcontroller.text+thirdcontroller.text+fourthcontroller.text+fifthcontroller.text+sixthcontroller.text);

    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((AuthResult value) {
      if (value.user != null) {
        // Handle loogged in state
        setState(() {
          isLoading=true;
        });
        print(value.user.phoneNumber);
      Alert(
            context: context,
            
            type: AlertType.success,
            title: "SUCCESS",
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
            desc: 'Phone Verification Successfull!',
            buttons: [
              DialogButton(
                color: Color(0xff3671a4),
                child: Text(
                  "OK",
                  style: TextStyle(fontSize: 20,color: Colors.white),
                ),
                onPressed: () =>     Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Login(
                  
                ),
              ),
              (Route<dynamic> route) => false)
              )
            ],
          ).show();
            setState(() {
              isLoading=false;
            });
      } else {
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
            desc: 'Error Validating OTP',
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
      }
    }).catchError((error) {
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
            desc: 'Something Went Wrong!',
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
        MaterialPageRoute(builder: (context) => Register()),
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
                                      'OTP Verification',
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
                                      'Have you received a four digit',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 30, top: 3),
                                    child: Text(
                                      'Verification Code?',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Box(controller: firstcontroller,),
                                      Box(controller: secondcontroller,),
                                      Box(controller: thirdcontroller,),
                                      Box(controller: fourthcontroller,),
                                       Box(controller: fifthcontroller,),
                                        Box(controller: sixthcontroller,),
                                    
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
                                            smsCode= firstcontroller.text+secondcontroller.text+thirdcontroller.text+fourthcontroller.text+fifthcontroller.text+sixthcontroller.text;
                                                                  if (smsCode.length == 6) {
                        _onFormSubmitted();
                      } else {
                       _displaySnackBar(context, "Invalid OTP");
                      }
                                            
                                            
                                          },
                                          buttoncol:
                                              Theme.of(context).backgroundColor,
                                          sidecol:
                                              Theme.of(context).backgroundColor,
                                          textcol: Colors.white,
                                          radius: 10,
                                          abc: Text(
                                            'Verify',
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

