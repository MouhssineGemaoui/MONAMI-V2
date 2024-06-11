
import 'package:get/get.dart';
import 'package:monami/core/class/statusrequest.dart';
import 'package:monami/core/constant/routes.dart';

import 'package:monami/core/function/handlingDatacontroller.dart';
import 'package:monami/core/services/services.dart';
import 'package:monami/teachers/profile/data/datasource/remote/get_page_profile_teachers_data.dart';

import 'package:monami/teachers/auth/data/model/teachers_model.dart';

abstract class PageProfileTeachersController extends GetxController {
  gotoeditedataprof(profModel profmodel) ;
  getedata();
}

class PageProfileTeachersControllerImp extends PageProfileTeachersController {
  MyServices myServices = Get.find();

  // String? username;
  // String? id;
  List data = [];
late profModel? profmodel;

  @override
  void onInit() {

    getedata();
    super.onInit();
  }

  profviewData profviewdata = profviewData(Get.find());

  late StatusRequest statusRequest;

  @override

  getedata() async {
    data.clear();
      statusRequest = StatusRequest.loading;
    var response =
        await profviewdata.getData(myServices.sharedPreferences.getString("id")!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        // data.addAll(response['data']);
        List responsedata = response['data'];
        data.addAll(responsedata.map((e) => profModel.fromJson(e)));
      } else {}
         update();
    }
}

  @override
  gotoeditedataprof(profModel profmodel) {
  Get.toNamed(AppRoutes.EditPageProfileTeachers,
  arguments: {"profModel": profmodel
 }
 ); 
}

}
