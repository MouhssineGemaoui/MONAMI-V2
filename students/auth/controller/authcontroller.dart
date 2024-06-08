import 'package:get/get.dart';

class AuthController extends GetxController{
  RxString id = ''.obs;
  RxString username = ''.obs;

  void updateUser(String userId, String userName) {
    id.value = userId;
    username.value = userName;
  }
}