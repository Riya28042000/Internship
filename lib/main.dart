import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:regis_login/darkmode.dart/dark.dart';
import 'package:regis_login/darkmode.dart/style.dart';
import 'package:regis_login/navigationbar/navigation.dart';
import 'package:regis_login/pages/choice.dart';
import 'package:regis_login/pages/dashboard.dart';
import 'package:regis_login/services/preferences.dart';
import 'package:regis_login/widgets/scrollglow.dart';

void main() {
// To display application in potrait mode only
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) { runApp(MyApp());
    // runApp(MaterialApp(
    //   //Root widget of our App
      
    //   home: BottomNavBar(),
    //   debugShowCheckedModeBanner: false,
    // ));
  });
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
         bool userIsLoggedIn;
  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn  = value;
        print(value);
      });
    });
  //   HelperFunctions.saveAdminLoggedInSharedPreference(false);
  }
  @override
  void initState() {
    super.initState();
    getLoggedInState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.bdcoe.getTheme();
  }
 
  @override
  Widget build(BuildContext context) {


    return MultiProvider(
           providers: [
        ChangeNotifierProvider(
          create: (_)=> themeChangeProvider, )
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
        
          return MaterialApp(
            builder: (context, child) {
        //Remove Scroll Glow from our App
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      title: 'Login_Registration',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            
            home:  userIsLoggedIn != null
                      ? userIsLoggedIn
                          ? Navigation()
                          : Choice()
                      : Choice()
          );
            },
          ),
        
      );
    
  }
}