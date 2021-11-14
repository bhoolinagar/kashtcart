import 'package:country_code_picker/country_localizations.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kisan/Driver/Auth/assistants/langauge_change_provider.dart';
import 'package:kisan/Driver/Auth/authenicatte.dart';
import 'package:kisan/Driver/Auth/landing.dart';
import 'package:kisan/Driver/Auth/location.dart';
import 'package:kisan/Driver/Auth/locator.dart';
import 'package:kisan/Driver/screens/d_search.dart';
import 'package:kisan/generated/l10n.dart';
import 'package:kisan/owner/connectivities.dart';
import 'package:kisan/owner/loading.dart';
import 'package:kisan/owner/wrapper.dart';
import 'package:kisan/spalsh_screen.dart';
import 'package:provider/provider.dart';

import 'Driver/Auth/assistants/Sign_goole.dart';
import 'Driver/Auth/user.dart';
import 'Driver/screens/LandingUtils.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "high_imptance_channel",
    "High Importance Notifications", //title
    "This channel is used for important notifications.",
    importance: Importance.high,
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessageHAndler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setServices();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessageHAndler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
        providers: [
          Provider(create: (_) => LoginService()),
          StreamProvider<User_d>.value(
            value: AuthService().user,
            // initialData: null,
          ),
          // StreamProvider<F_User>.value(value: F_AuthService().f_user, initialData: null,),

          ChangeNotifierProvider(
            create: (_) => ConnectivityProvider(),
            child: IsInternet(),
          ),
          // StreamProvider<Vehicle>.value(value: add_paage_1().),
          ChangeNotifierProvider(create: (_) => FirebaseOperations()),
          ChangeNotifierProvider(create: (_) => LandingUtils()),
          ChangeNotifierProvider(
            create: (context) => LocationProvider(),
            child: GoogleMapPage(),
          ),
          //  FutureProvider(create: (context) {
          //   ImageConfiguration configuration =
          //      createLocalImageConfiguration(context);
          //   return BitmapDescriptor.fromAssetImage(
          //     configuration, 'assets/TC.png');
          //    }),
          ChangeNotifierProvider<LangaugesChangeProvider>(
            create: (context) => LangaugesChangeProvider(),
          )
        ],
        child: Builder(
          builder: (context) => MaterialApp(
              locale:
                  Provider.of<LangaugesChangeProvider>(context, listen: true)
                      .currentLocale,
              supportedLocales: S.delegate.supportedLocales,

              //[Locale("en", "US"), Locale("hi", "IN")],
              localizationsDelegates: [
                CountryLocalizations.delegate,
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              //   localeResolutionCallback: (locale, supportedLocales) {
              //    for(var supportedLocale in supportedLocales){
              //  if (supportedLocales.languageCode == locale.languageCode &&
              //    supportedLocales.countryCode == locale.countryCode) {
              //  return supportedLocale;
              // }}
              // return supportedLocales.first;
              //},
              debugShowCheckedModeBanner: false,
              title: 'kashtcart',
              theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back t  o zero; the application
                // is not restarted.
                primarySwatch: Colors.blue,
                // This makes the visual density adapt to the platform that you run
                // the app on. For desktop platforms, the controls will be smaller and
                // closer together (more dense) than on mobile platforms.
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: Splash_screen()
              //Wrapper(),
              ),
        ));
  }
}

class IsInternet extends StatefulWidget {
  @override
  _rWrapper createState() => _rWrapper();
}

class _rWrapper extends State<IsInternet> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageUI(),
    );
  }

  Widget PageUI() {
    // TODO: implement build
    return Consumer<ConnectivityProvider>(builder: (context, model, child) {
      if (model.isOnline != null) {
        return model.isOnline ? Wrapper() : NoInternet();
      }
      return Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1),
              blurRadius: 1,
              offset: Offset(-1, 8),
            )
          ],
        ),

        //color: Colors.green,
        child: Center(
            child: Text(
          S.of(context).loading,
          style: TextStyle(fontSize: 15, color: Colors.black45),
        )),
      );
    });
  }
}
