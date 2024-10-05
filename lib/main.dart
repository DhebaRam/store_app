import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storeapp/splash_screen.dart';
import 'package:storeapp/utils/base_color.dart';
import 'package:storeapp/utils/base_main_builder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init('GetStorage');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
      // await GetStorage.init('GetStorage');
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitUp,
      ]);
    });

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (FocusManager.instance.primaryFocus!.hasFocus) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: GetMaterialApp(
          title: 'Store App',
          debugShowCheckedModeBanner: false,
          // translations: BaseLocalization(),
          locale: const Locale('en'),
          fallbackLocale: const Locale('en'),
          // onGenerateRoute: getPageRoute,
          // initialRoute: RouteName.splashScreen,
          builder: (BuildContext context, Widget? child) {
            return BaseMainBuilder(context: context, child: child);
          },
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: BaseColors.secondaryColor),
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.white,
          ),
          home: const SplashScreen(),
        ));
  }
}

