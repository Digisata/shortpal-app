import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shortpal/constant_data.dart';
import 'package:shortpal/route_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(
    const MyApp(),
  );

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouteHelper routeHelper = RouteHelper();

    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          title: ConstantData.projectTitle,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          initialRoute: ConstantData.homeRoute,
          transitionDuration: const Duration(milliseconds: 200),
          defaultTransition: Transition.rightToLeftWithFade,
          getPages: routeHelper.getRoute(),
        );
      },
    );
  }
}
