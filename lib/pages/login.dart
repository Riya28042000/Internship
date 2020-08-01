import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:regis_login/components/button.dart';
import 'package:regis_login/components/text_form_field.dart';
import 'package:regis_login/darkmode.dart/dark.dart';
import 'package:regis_login/navigationbar/navigation.dart';
import 'package:regis_login/pages/choice.dart';
import 'package:regis_login/pages/dashboard.dart';
import 'package:regis_login/pages/forgot.dart';
import 'package:regis_login/pages/register.dart';
import 'package:regis_login/services/auth.dart';
import 'package:regis_login/services/database.dart';
import 'package:regis_login/services/preferences.dart';
import 'package:regis_login/services/users.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();
GlobalKey<FormState> validatekey = GlobalKey<FormState>();

class _LoginState extends State<Login> {
  AuthMethods authService = new AuthMethods();
  Database databaseMethods = Database();
  QuerySnapshot usersnapshot;
  bool isLoading = false;
  String val;
  bool validateAndSave() {
    final FormState form = validatekey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void signin(String email, String pass) async {
    if (validatekey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signInwithEmailAndPassword(email, pass)
          .then((value) async {
        databaseMethods.getUserByEmail(email).then((uservalue) {
          usersnapshot = uservalue;
          UserInfo user = UserInfo(
              name: usersnapshot.documents[0].data["name"], email: email);
          if (value != null) {
            setState(() {
              isLoading = true;
            });

            HelperFunctions.saveUserLoggedInSharedPreference(true);
            HelperFunctions.saveUserNameSharedPreference(user.name);
            print(user.name);
            print(user.email);
            HelperFunctions.saveUserEmailSharedPreference(email);
            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                       Navigation()),
                                                ModalRoute.withName('/'),
                                              );
          }
        });
      }).catchError((onError) {
        print(onError);
        switch (onError.toString()) {
          case 'PlatformException(ERROR_USER_NOT_FOUND, There is no user record corresponding to this identifier. The user may have been deleted., null)':
            val = "User Not Found!";
            break;
          case 'PlatformException(ERROR_NETWORK_REQUEST_FAILED, A network error (such as timeout, interrupted connection or unreachable host) has occurred., null)':
            val = "Check your connection!";
            break;
          default:
            val = "Check your details!";
            break;
        }
        Alert(
          context: context,
          type: AlertType.error,
          title: "ERROR",
          style: AlertStyle(
            backgroundColor: Theme.of(context).cardColor,
            animationType: AnimationType.fromTop,
            isCloseButton: false,
            isOverlayTapDismiss: false,
            descStyle: TextStyle( fontSize: 18,color: Theme.of(context).textSelectionColor),
            animationDuration: Duration(milliseconds: 400),
            alertBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  // color: Colors.grey,
                  ),
            ),
            titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textSelectionColor),
          ),
          desc: val,
          buttons: [
            DialogButton(
                color: Color(0xff3671a4),
                child: Text(
                  "OK",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () => Navigator.of(context).pop())
          ],
        ).show();
        print('error');
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
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

    return isLoading? Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).backgroundColor)): Scaffold(
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
                        'Welcome',
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
                                        'Welcome Back',
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
                                        'Hello there, sign in to continue',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(height: 40),
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
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, top: 5, right: 30),
                                        child: TexFormField(
                                          text: email,
                                          hinttext:
                                              "Enter your Email",
                                          inputType: TextInputType.text,
                                          obscure: false,
                                        )),
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
                                    //SizedBox(height: _animation.value),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, top: 5, right: 30),
                                        child: TexFormField(
                                          hinttext: "Enter your password",
                                          text: pass,
                                          inputType: TextInputType.text,
                                          obscure: true,
                                        )),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),

                                    SizedBox(height: 5),
                                    Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Forgot()),
                                            );
                                          },
                                          child: Text(
                                            'Forgot Password?',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .backgroundColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          )),
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
                                              print(email);
                                              validatekey.currentState.save();
                                              if (email.text.isEmpty) {
                                                _displaySnackBar(context,
                                                    "Please enter your Email");
                                              } else if (!RegExp(
                                                      r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                  .hasMatch(email.text))
                                                _displaySnackBar(context,
                                                    "Please Fill valid Email");
                                              else if (pass.text.isEmpty)
                                                _displaySnackBar(context,
                                                    "Please enter your Password");
                                              else {
                                                signin(email.text, pass.text);
                                              }
                                            },
                                            buttoncol: Theme.of(context)
                                                .backgroundColor,
                                            sidecol: Theme.of(context)
                                                .backgroundColor,
                                            textcol: Colors.white,
                                            radius: 10,
                                            abc: Text(
                                              'Sign In',
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
                                            'Don\'t have an account?',
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
                                                        Register()),
                                                ModalRoute.withName('/'),
                                              );
                                            },
                                            child: Text(
                                              ' Sign Up',
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
                                    SizedBox(height: 10)
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
