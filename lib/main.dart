import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isales_getx_app/app/modules/home/home_binding.dart';
import 'package:isales_getx_app/app/modules/home/home_page.dart';
import 'package:isales_getx_app/app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'iSales App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      initialBinding: HomeBinding(),
      getPages: AppPages.pages,
    );
  }
}
