import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isales_getx_app/app/modules/home/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Hola Juan'),
          centerTitle: true,
        ),
        body: Center(
          child: Text('Home Page'),
        ),
      ),
    );
  }
}
