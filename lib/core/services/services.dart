
import 'package:get/get.dart';
import 'package:monami/students/abonnement/class/stripe_gateway.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;
    late StripeGateway stripe;

  Future<MyServices> init() async {
    //  await Firebase.initializeApp();
    sharedPreferences = await SharedPreferences.getInstance();
      stripe=StripeGateway.initialize();
    return this;
  }
}

InitialiServices() async {
  await Get.putAsync(() => MyServices().init());
}
