import 'package:get/get.dart';
import 'package:monami/core/class/statusrequest.dart';
import 'package:monami/core/constant/routes.dart';
import 'package:monami/core/function/handlingDatacontroller.dart';
import 'package:monami/core/services/services.dart';
import 'package:monami/students/home/data/datasource/remote/show_more_prof_french_data.dart';
import 'package:monami/teachers/auth/data/model/teachers_model.dart';


abstract class PageShowMoreProffrenchController extends GetxController {
  // initialData();
  getdata();
goToPageProductDetails(profModel profmodel);}

class PageShowMoreProffrenchControllerImp extends PageShowMoreProffrenchController {

  MyServices myservices = Get.find();

  @override
    void onInit() {
    // initialData();
    getdata();
    super.onInit();
  }
  
  VpLangFr vpLangfr = VpLangFr(Get.find());

  List data = [];
 late StatusRequest statusRequest;


getdata() async {
    data.clear( );
    statusRequest = StatusRequest.loading;
    update();
    var response = await vpLangfr.getData();
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