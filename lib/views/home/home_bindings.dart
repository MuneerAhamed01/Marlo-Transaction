import 'package:get/get.dart';
import 'package:transactions/views/home/home_controller.dart';

class HomeBindings extends Bindings {
  static String homeRoute = '/';
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
