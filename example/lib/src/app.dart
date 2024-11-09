import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:events/events.dart' as p;
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: p.RouteNames.splash,
    getPages: p.RoutePages.pages,
    title: 'Events',
    locale: Locale('en','US'),
    translationsKeys: p.LocalizationService.keys,
  );
}
