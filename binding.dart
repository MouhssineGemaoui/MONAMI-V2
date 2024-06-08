import 'package:get/get.dart';
import 'package:monami/students/auth/controller/signup_controller.dart';

class Mybinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut(() => SignUpcontrollerImp(),fenix: true );
  }
}