import 'package:get/get.dart';
import 'package:isales_getx_app/app/modules/home/home_binding.dart';
import 'package:isales_getx_app/app/modules/home/home_page.dart';
import 'package:isales_getx_app/app/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
