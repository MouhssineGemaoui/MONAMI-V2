
import 'package:get/get.dart';
import 'package:monami/core/class/statusrequest.dart';
import 'package:monami/core/constant/routes.dart';

import 'package:monami/core/function/handlingDatacontroller.dart';
import 'package:monami/core/services/services.dart';
import 'package:monami/students/profile/data/datasource/remote/get_profile_students_data.dart';

import 'package:monami/students/auth/data/model/usersModel.dart';

abstract class GetProfilePageStudentsController extends GetxController {
  EditProfilePageStudents(usersModel usersmodel) ;
  initialData();
  getedata();
}

class GetProfilePageStudentsControllerImp extends GetProfilePageStudentsController {
  MyServices myServices = Get.find();

  String? username;
  String? id;
  List data = [];

   late usersModel usersmodel;

  @override
  void onInit() {
    initialData();
    getedata();
    super.onInit();
  }

  GetProfileStudentsData getprofilestudentsdata = GetProfileStudentsData(Get.find());

  late StatusRequest statusRequest;

  @override
  initialData() {}
  getedata() async {
    data.clear();
      statusRequest = StatusRequest.loading;
    var response =
        await getprofilestudentsdata.getData(myServices.sharedPreferences.getString("id")!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        // data.addAll(response['data']);
        List responsedata = response['data'];
        data.addAll(responsedata.map((e) => usersModel.fromJson(e)));
      } else {}
         update();
    }
  } 

  @override
  EditProfilePageStudents(usersModel usersmodel) {
  Get.toNamed(AppRoutes.EditProfilePageStudents,
  arguments: {"usersModel": usersmodel
 }
 ); 
}

}
