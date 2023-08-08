import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transactions/api/api_bindings.dart';
import 'package:transactions/routes/routes.dart';
import 'package:transactions/views/home/home_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Transactions',
      getPages: Routes.instance.routes(),
      initialRoute: HomeBindings.homeRoute,
      initialBinding: InitialBinding(),
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: const Color(0xffF7F7F7),
      ),
    );
  }
}
