import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/core/class/statusrequest.dart';
import 'package:monami/core/function/handlingDatacontroller.dart';
import 'package:monami/core/services/services.dart';
import 'package:monami/teachers/profile/data/datasource/remote/customer_services_teachres_data.dart';
import 'package:monami/students/auth/data/model/usersmodel.dart';


abstract class ServiceClients extends GetxController {
  send();
}

class ServiceClientsImp extends ServiceClients {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  MyServices myservices = Get.find();

  late TextEditingController body;

  late StatusRequest statusRequest;

  usersModel? usersmodel;
  ServiceProfData serviceprofData = ServiceProfData(Get.find());

  List data = [];

  @override
  send() async {
    statusRequest = StatusRequest.loading;
    update();
    if (formstate.currentState!.validate()) {
      var response = await serviceprofData.postdata(
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