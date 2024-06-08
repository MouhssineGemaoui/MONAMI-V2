import 'package:get/get.dart';
import 'package:monami/core/class/statusrequest.dart';
import 'package:monami/core/constant/routes.dart';
import 'package:monami/core/function/handlingDatacontroller.dart';
import 'package:monami/core/services/services.dart';
import 'package:monami/teachers/home/data/datasource/remote/show_more_students_french_data.dart';
import 'package:monami/students/auth/data/model/usersModel.dart';


abstract class viewpluslangfrusres extends GetxController {
  getdata();
goToPageProductDetails(usersModel usersmodel);}

class viewpluslangfrusresImp extends viewpluslangfrusres {

  MyServices myservices = Get.find();

  @override
    void onInit() {
    getdata();
    super.onInit();
  }
  
  ShowMoreStudentsFrenchData showMoreStudentsFrenchData = ShowMoreStudentsFrenchData(Get.find());
  List data = [];
 late StatusRequest statusRequest;


getdata() async {
    data.clear( );
    statusRequest = StatusRequest.loading;
    update();
    var response = await showMoreStudentsFrenchData.getData(myservices.sharedPreferences.getString("id")!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      data.addAll(response['data']);
    } else {
      statusRequest = StatusRequest.failute;
    }
    update();
  }
  goToPageProductDetails(usersmodel) {
    statusRequest = StatusRequest.loading;
    Get.toNamed(AppRoutes.PageProfileProf,
        arguments: {"usersModel": usersmodel});
  }
}