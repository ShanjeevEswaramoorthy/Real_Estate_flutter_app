import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/utils/constant.dart';

import 'go_router/go_router_config.dart';

Future<void> main() async {
  /// [WidgetsFlutterBinding.ensureInitialized()] it will when you doing async operation before [runApp]
  //  othewise it will throw a error
  /// you need to Initialized the flutter widget binging
  // while you are intracting with the like(firebase,sharedpreference,methodchannel)
  ///
  /// if you are not doing any async operation before [runApp] then no need to [WidgetsFlutterBinding.ensureInitialized()]
  /// because [WidgetsFlutterBinding.ensureInitialized()] it will automatically Initialized when the [runApp] is called
  WidgetsFlutterBinding.ensureInitialized();

  /// It loads your Firebase configuration (from google-services.json in Android or GoogleService-Info.plist in iOS)
  /// it will initialize the firebase before you are intracting with the like..(auth,firestore)
  await Firebase.initializeApp();

  /// Step 1: for mobile persistenceEnabled true/false by default it will caches the data in mobile
  /// but in web you need to enbale this manually to cache the data and provide offline support
  ///
  /// Step 2: [Ensuring data survives app restarts] → Cached data is stored permanently until the app clears it.
  /// if [persistenceEnabled = fasle] Cached data is not stored permanently on mobile device
  /// Firestore still caches recent queries to improve performance.
  /// cached data is lost when the app is restarted, Offline support only works while the app is running.
  /// Once the app is closed, the cache is cleared.
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = View.of(context).physicalSize.width;

    /// if you are not using goRouter [MaterialApp is enough]
    /// but if you need goRouter [MaterialApp.router]
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Real Estate App',
      theme: ThemeData(
          primaryColor: COLOR_WHITE,
          textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT,
          fontFamily: 'Montserrat'),
      routerConfig: goRouter,
    );
  }
}
