import 'package:get/get.dart';
import 'package:monami/students/favorites/data/model/favorite_model.dart';

abstract class ProductDetailsFavController extends GetxController {}

class ProductDetailsFavControllerImp extends ProductDetailsFavController {
  late myfavoriteModel myfavoritemodel;

  intialData() {
    myfavoritemodel = Get.arguments['myfavoriteModel'];
  }



  @override
  void onInit() {
    intialData();
    super.onInit();
  }
}