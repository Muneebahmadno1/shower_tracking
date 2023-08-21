import 'package:country_picker/country_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/controllers/auth_controller.dart';
import 'package:too_cool/controllers/badges_controller.dart';
import 'package:too_cool/controllers/base_controller.dart';
import 'package:too_cool/controllers/challenge_controller.dart';
import 'package:too_cool/controllers/leaderboard_controller.dart';
import 'package:too_cool/screens/calendar/habits_manager.dart';
import 'package:too_cool/screens/intro/splash_screen.dart';
import 'package:too_cool/utilities/global_variables.dart';

import 'controllers/home_controller.dart';
import 'controllers/setting_controller.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("_firebaseMessagingBackgroundHandler");
  // await Firebase.initializeApp();
  FirebaseMessaging.onMessageOpenedApp.listen((_handleMessage));
  print("message");
  print(message);
  // navigationUrl = message.data['link'].toString();
}

void _handleMessage(RemoteMessage message) {
  print("_handleMessage");
  print(message.data['link']);
  print("message");
  print(message);
  // navigationUrl = message.data['link'].toString();
  // Get.offAll(const NotificationScreen());
}

void onSelectNotification(String? payload) {
  print("onSelectNotification");
  print("Navigation_url");
  // print(navigationUrl);
  print("payload");
  print(payload);
  // Get.offAll(const NotificationScreen());
  print(payload);
}

Future<void> setupInteractedMessage() async {
  // Get any messages which caused the application to open from
  // a terminated state.
  print('setupInteractedMessage');
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  // If the message also contains a data property with a "type" of "chat",
  // navigate to a chat screen
  if (initialMessage != null) {
    _handleMessage(initialMessage);
  }

  // Also handle any interaction when the app is in the background via a
  // Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
}

Future<void> _selectNotification(RemoteMessage message) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      const AndroidNotificationDetails(
          'high_importance_channel', 'High Importance Notifications',
          importance: Importance.high,
          priority: Priority.high,
          icon: "@mipmap/ic_launcher");
  NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  print("_selectNotification");
  print(message.data);
  // navigationUrl = message.data['link'].toString();
  print('Testing something.');
  print('Testing something.');
  await FlutterLocalNotificationsPlugin().show(123, message.notification!.title,
      message.notification!.body, platformChannelSpecifics,
      payload: 'data');
  // navigationUrl = message.data['link'].toString();
  String initialRoute = '1';
  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    initialRoute = '2';
  }

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');
  const IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings();
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  FlutterLocalNotificationsPlugin().initialize(initializationSettings,
      onSelectNotification: onSelectNotification);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupInteractedMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((_handleMessage));
  FirebaseMessaging.onMessage.listen((_selectNotification));

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title // description
      importance: Importance.high,
      playSound: true);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.instance.requestPermission(
      sound: true, badge: true, alert: true, provisional: true);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => HabitsManager(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    _firebaseNotificationPermission();
    super.initState();
  }

  _firebaseNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        initialBinding: InitialBinding(),
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(
            seedColor: HexColor('#83BCFF'),
          ),
          // useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          CountryLocalizations.delegate,
        ],
        home: const SplashScreen(),
      );
    });
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(BaseController());
    Get.put(AuthController());
    Get.put(HomeController());
    Get.put(SettingController());
    Get.put(ChallengeController());
    Get.put(BadgesController());
    Get.put(LeadersboardController());
  }
}
