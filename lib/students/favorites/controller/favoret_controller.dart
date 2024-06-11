import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/core/class/statusrequest.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:monami/core/function/handlingDatacontroller.dart';
import 'package:monami/core/services/services.dart';
import 'package:monami/students/favorites/data/datasource/remote/favorite_data.dart';
import 'package:path/path.dart';

class Favoritecontroller extends GetxController {

FavoriteData favoriteData = FavoriteData(Get.find());
MyServices myServices = Get.find();

List data = [];

late StatusRequest statusRequest;

Map isFavorite = {};

  @override
  void onInit() {
    update();
    super.onInit();
  }

  setFavorite( id , val ){
    isFavorite[id] = val ;
    update();
  }

  addFavorite( profid) async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await favoriteData.addFavorite(
        myServices.sharedPreferences.getString("id")!, profid!);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.snackbar(   
            "128".tr 
           ,"130".tr ,
          
          colorText:  AppColor.white,
       
           snackPosition: SnackPosition.TOP,
            icon: Icon(Icons.favorite, color: AppColor.white, ),
            backgroundColor: Color.fromARGB(255, 80, 156, 156)
            );
        // data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failute;
      }
      update();
      // End
    }
  }

  removeFavorite( profid) async {
    data.clear();
    statusRequest = StatusRequest.loading;
    var response = await favoriteData.removeFavorite(
        myServices.sharedPreferences.getString("id")!, profid)!;
    print("=============================== Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.snackbar(   
            "128".tr 
           ,"132".tr ,
          
          colorText:  AppColor.white,
       
           snackPosition: SnackPosition.TOP,
            icon: Icon(Icons.favorite, color: AppColor.white, ),
            backgroundColor: Color.fromARGB(255, 214, 39, 39)
            );
        // data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failute;
      }
      update();
      // End
    }
  }


}
