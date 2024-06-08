import 'package:get/get.dart';
import 'package:monami/teachers/auth/data/model/teachers_model.dart';

abstract class ProductDetailsController extends GetxController {}

class ProductDetailsControllerImp extends ProductDetailsController {
  late profModel profmodel;

  intialData() {
    profmodel = Get.arguments['profModel'];
    print(profmodel);
  }

  @override
  void onInit() {
    intialData();
    super.onInit();
  }
}