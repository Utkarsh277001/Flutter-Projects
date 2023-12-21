import 'package:ai_rdio/Exercise/cardio.dart';
import 'package:ai_rdio/screen/RegLoginUi.dart';
import 'package:ai_rdio/screen/Regis.dart';
import 'package:ai_rdio/screen/splash2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'Exercise/meditation.dart';
import 'Exercise/pilates.dart';
import 'Exercise/pull-up.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
void main() async {
  runApp(const MyApp());
  configLoading();
  await dotenv.load(fileName: ".env");
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  //..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      builder: EasyLoading.init(),
      routes: {
        'splash': (context) => SplashScreen(),
        // 'home': (context) => Home_page(),
        'login': (context) => RegLoginUi(),
        'Signup': (context) => regis(),
        // '/GymPageDate': (context) => GymPageDate(),
        '/CardioExercisePage': (context) => CardioExercisePage(),
        '/BicepsExercisePage': (context) => BicepsExercisePage(),
        '/MeditationExercisePage': (context) => MeditationExercisePage(),
        '/PullExercisePage': (context) => PullExercisePage(),
      },
    );
  }
}
