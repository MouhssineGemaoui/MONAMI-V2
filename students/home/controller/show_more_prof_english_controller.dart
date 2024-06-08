import 'package:get/get.dart';
import 'package:monami/core/class/statusrequest.dart';
import 'package:monami/core/constant/routes.dart';
import 'package:monami/core/function/handlingDatacontroller.dart';
import 'package:monami/core/services/services.dart';
import 'package:monami/students/home/data/datasource/remote/show_more_prof_english_data.dart';
import 'package:monami/teachers/auth/data/model/teachers_model.dart';


abstract class PageShowMoreProfEnglishController extends GetxController {
  // initialData();
  getdata();
goToPageProductDetails(profModel profmodel);}

class PageShowMoreProfEnglishControllerImp extends PageShowMoreProfEnglishController {

  MyServices myservices = Get.find();

  @override
    void onInit() {
    // initialData();
    getdata();
    super.onInit();
  }
  
  VpLangEn vpLangen = VpLangEn(Get.find());

  List data = [];
 late StatusRequest statusRequest;


getdata() async {
    data.clear( );
    statusRequest = StatusRequest.loading;
    update();
    var response = await vpLangen.getData();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      data.addAll(response['data']);
    } else {
      statusRequest = StatusRequest.failute;
    }
    update();
  }
  goToPageProductDetails(profmodel) {
    statusRequest = StatusRequest.loading;
    Get.toNamed(AppRoutes.PageProfileProf,
        arguments: {"profModel": profmodel});
  }
}