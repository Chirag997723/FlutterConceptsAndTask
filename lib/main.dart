import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_practice_app/bloc/api/posts_bloc.dart';
import 'package:flutter_practice_app/bloc/counter/counter_bloc.dart';
import 'package:flutter_practice_app/bloc/login/login_bloc.dart';
import 'package:flutter_practice_app/bloc/switch/switch_bloc.dart';
import 'package:flutter_practice_app/bloc/theme/theme_bloc.dart';
import 'package:flutter_practice_app/bloc/theme/theme_state.dart';
import 'package:flutter_practice_app/bloc/txt_color/txt_color_bloc.dart';
import 'package:flutter_practice_app/bloc/users/users_bloc.dart';

import 'package:flutter_practice_app/old_file/editor/truecaller_overlay.dart';
import 'package:flutter_practice_app/old_file/firebase/for_sms/message.dart';
import 'package:flutter_practice_app/old_file/firebase_options.dart';
import 'package:flutter_practice_app/old_file/loginSignupPre/loginSignupPre.dart';
import 'package:flutter_practice_app/main_activity.dart';
import 'package:flutter_practice_app/old_file/provider/theme_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: MyApp()));
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TrueCallerOverlay(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.green, // Transparent status bar
      statusBarIconBrightness:
          Brightness.dark, // Adjust for light or dark icons
    ));

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterBloc(),),
        BlocProvider(create: (_) => SwitchBloc(),),
        BlocProvider(create: (_) => ThemeBloc(),),
        BlocProvider(create: (_) => TxtColorBloc(),),
        BlocProvider(create: (_) => PostsBloc(),),
        BlocProvider(create: (_) => UsersBloc(),),
        BlocProvider(create: (_) => LoginBloc(),),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return GetMaterialApp(
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              // themeMode: Provider.of<ThemeProvider>(context).themeMode,
              themeMode: state.themeMode,
              debugShowCheckedModeBanner: false,
              home: MainActivity(),
            );
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool userLogin = false;

  @override
  void initState() {
    super.initState();
    // getValue();
    Future.delayed(
      const Duration(seconds: 5),
      () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainActivity(),
          )),
    );
  }

  void getValue() async {
    final pre = await SharedPreferences.getInstance();
    userLogin = pre.getBool('userLogin') ?? false;
    if (userLogin) {
      Future.delayed(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainActivity(),
            )),
      );
    } else {
      Future.delayed(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginSignupPre(),
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.pink],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 130,
              width: 130,
              child: Image.asset('assets/images/app_icon.png'),
            ),
            Text('Demo Concept',
                style: TextStyle(color: Colors.white, fontSize: 20))
          ],
        ),
      ),
    );
  }
}

//Firebase Notification
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await setupFlutterNotifications();
  showFlutterNotification(message);

  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await FirebaseMessaging.instance.subscribeToTopic('general');
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ),
    );
  }
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class Application extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<Application> {
  String? _fcmToken;
  @override
  void initState() {
    super.initState();
    _getToken();
    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(
        context,
        '/message',
        arguments: MessageArguments(message, true),
      );
    });
  }

  void _getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    setState(() {
      _fcmToken = token;
    });
    print("FCM Token: $_fcmToken");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Messaging'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MetaCard(
                'FCM Token',
                SelectableText(
                  _fcmToken!,
                  style: const TextStyle(fontSize: 12),
                )),
          ],
        ),
      ),
    );
  }
}

class MetaCard extends StatelessWidget {
  final String _title;
  final Widget _children;

  MetaCard(this._title, this._children);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Text(_title, style: const TextStyle(fontSize: 18)),
              ),
              _children,
            ],
          ),
        ),
      ),
    );
  }
}
