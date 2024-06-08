import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/core/class/statusrequest.dart';
import 'package:monami/core/function/handlingDatacontroller.dart';
import 'package:monami/core/services/services.dart';
import 'package:monami/students/profile/data/datasource/remote/customer_services_data.dart';
import 'package:monami/students/auth/data/model/usersmodel.dart';


abstract class CustomerServicesStudentsController extends GetxController {
  send();
}

class CustomerServicesStudentsControllerImp extends CustomerServicesStudentsController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  MyServices myservices = Get.find();

  late TextEditingController body;

  late StatusRequest statusRequest;

  usersModel? usersmodel;
  CustomerServicesStudentsData CustomerServicesStudentsdata = CustomerServicesStudentsData(Get.find());

  List data = [];

  @override
  send() async {
    statusRequest = StatusRequest.loading;
    update();
    if (formstate.currentState!.validate()) {
      var response = await CustomerServicesStudentsdata.postdata(
        body.text,
        myservices.sharedPreferences.getString("id")!,
      );
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
        } else {
          statusRequest = StatusRequest.failute;
        }
      }
      update();
    }
  }

  @override
  void onInit() {
    body = TextEditingController();
    super.onInit();
  }
}