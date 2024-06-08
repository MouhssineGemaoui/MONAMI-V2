import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/core/class/statusrequest.dart';
import 'package:monami/core/function/handlingDatacontroller.dart';
import 'package:monami/core/services/services.dart';
import 'package:monami/teachers/home/data/datasource/remote/active.dart';
import 'package:monami/teachers/auth/data/model/teachers_model.dart';
class activecontroller extends GetxController {

activeData activedata = activeData(Get.find());
MyServices myServices = Get.find();

List data = [];
late profModel profmodel;
late StatusRequest statusRequest;


bool  active = false;

Changeactive(val){
 active = active == false ? true : false;
   update();
}

  @override
  void onInit() {
    update();
    super.onInit();
  }

itsactive() async {
// data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await activedata.active(
        myServices.sharedPreferences.getString("id")!,);
    print("=============================== Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.rawSnackbar(
            title: "اشعار",
            messageText: const Text("It worked successfully"),
            icon: Icon(Icons.favorite_border_outlined),
            backgroundColor: Colors.orange
            );
        // data.addAll(response['data']);
      } else { 
        statusRequest = StatusRequest.failute;
      }
      update();
      // End
    }

  }
  
    
itsinactive() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await activedata.inactive(
        myServices.sharedPreferences.getString("id")!,);
    print("=============================== Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.rawSnackbar(
            title: "اشعار",
            messageText: const Text("Extinguished successfully"),
            icon: Icon(Icons.favorite_border_outlined),
            backgroundColor: Colors.orange
            );
      } else { 
        statusRequest = StatusRequest.failute;
      }
      update();
      // End
    }
  }
}