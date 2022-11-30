import 'package:campus_life/components/loading.dart';
import 'package:campus_life/controllers/auth.dart';
import 'package:campus_life/pages/account.dart';
import 'package:campus_life/pages/home.dart';
import 'package:campus_life/screens/edit_profile.dart';
import 'package:campus_life/screens/welcome.dart';
import 'package:campus_life/screens/complete_profile.dart';
import 'package:campus_life/screens/login.dart';
import 'package:campus_life/screens/register.dart';
import 'package:campus_life/screens/simkuliah_form.dart';
import 'package:campus_life/screens/task_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initSettings = InitializationSettings(android: initSettingsAndroid);

  await Firebase.initializeApp().then((_) async {
    tz.initializeTimeZones();
    var detroit = tz.getLocation('Asia/Jakarta');
    tz.setLocalLocation(detroit);
    await flutterLocalNotificationsPlugin.initialize(initSettings);
    Get.put(AuthController());
  });

  runApp(const CampusLife());
}

class CampusLife extends StatelessWidget {
  const CampusLife({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoadingPage(),
      theme: ThemeData(
        primaryColor: const Color(0xFF68E1FD),
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          headline1: GoogleFonts.museoModerno(
            fontSize: 40.0,
            color: const Color(0xFF3F8798),
            fontWeight: FontWeight.w600,
          ),
          headline2: GoogleFonts.museoModerno(
            fontSize: 24.0,
            color: const Color(0xFF68E1FD),
            fontWeight: FontWeight.w600,
          ),
          headline3: GoogleFonts.poppins(
            fontSize: 18.0,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          headline4: GoogleFonts.nunito(
            fontSize: 18.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: GoogleFonts.poppins(
            fontSize: 14.0,
            color: Colors.black26,
          ),
          bodyText2: GoogleFonts.poppins(
            fontSize: 14.0,
            color: Colors.black,
          ),
          labelMedium: GoogleFonts.poppins(
            fontSize: 14.0,
            color: Colors.black54,
          ),
          button: GoogleFonts.poppins(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      initialRoute: '/',
      defaultTransition: Transition.cupertino,
      getPages: [
        GetPage(name: '/', page: () => const CampusLife()),
        GetPage(
          name: '/loading',
          page: () => const LoadingPage(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 200),
        ),
        GetPage(
          name: '/welcome',
          page: () => const Welcome(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 200),
        ),
        GetPage(
          name: '/login',
          page: () => const Login(),
        ),
        GetPage(
          name: '/register',
          page: () => const Register(),
        ),
        GetPage(
          name: '/complete-profile',
          page: () => const CompleteProfile(),
        ),
        GetPage(
          name: '/home',
          page: () => const Home(),
          transition: Transition.noTransition,
          transitionDuration: const Duration(milliseconds: 200),
        ),
        GetPage(
          name: '/account',
          page: () => const Account(),
        ),
        GetPage(
          name: '/edit-profile',
          page: () => const EditProfile(),
        ),
        GetPage(
          name: '/task-form',
          page: () => const TaskForm(),
        ),
        GetPage(
          name: '/simkuliah-form',
          page: () => const SimkuliahForm(),
        ),
      ],
    );
  }
}
