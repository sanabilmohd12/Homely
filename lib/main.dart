import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'Provider/Login_Provider/LoginProvider.dart';
import 'Provider/Main_Provider/MainProvider.dart';
import 'Provider/Main_Provider/SubAdmin_Provider.dart';
import 'Provider/Main_Provider/MyProvider.dart';
import 'Screens/Admin/MainAdminHomePage.dart';
import 'Screens/Splash_Screen.dart';
import 'Screens/User/Login.dart';
import 'Screens/User/UserRegistration.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>MyProvider()),
        ChangeNotifierProvider(create: (context)=>MainProvider()),
        ChangeNotifierProvider(create: (context)=>LoginProvider()),
        ChangeNotifierProvider(create: (context)=>SubAdmin_Provider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Homely... Where Everyone Feels At Home.',
        theme: ThemeData(
          // This is the theme of your application.

          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff04745B)),
          useMaterial3: true,
        ),
        home: Splash_Screen(),
        // home: MainAdminHomePage(),
        //home:UserRegistration(ID: "", from: "New"),
        // home: MainAdminHomePage(),
      ),
    );
  }
}
