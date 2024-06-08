import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/core/class/statusrequest.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:monami/core/constant/routes.dart';
import 'package:monami/core/function/handlingDatacontroller.dart';
import 'package:monami/core/services/services.dart';
import 'package:monami/students/favorites/data/datasource/remote/favorite_data.dart';
import 'package:monami/students/favorites/data/datasource/remote/get_favorite_page_data.dart';
import 'package:monami/students/favorites/data/model/favorite_model.dart';

class MyFavoritecontroller extends GetxController {
  @override
  void onInit() {
    getData();
    update();
    super.onInit();
  }

  MyFavoriteData myfavoriteData = MyFavoriteData(Get.find());
  FavoriteData favoriteData = FavoriteData(Get.find());
  MyServices myServices = Get.find();

  List<myfavoriteModel> data = [];

  bool isactive = true;

  late StatusRequest statusRequest;

  getData() async {
     data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await myfavoriteData.getData(
      myServices.sharedPreferences.getString("id")!,
    );
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List responsedata = response['data'];
        data.addAll(responsedata.map((e) => myfavoriteModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.nodata;
      }
    }
    update();
  }

  deletFromFavorite( favorieid) {
    // ignore: unused_local_variable
    var response = favoriteData.Deletfromfavorite(favorieid);
    data.removeWhere((element) => element.favorieId == favorieid); 
    Get.snackbar(   
            "128".tr 
           ,"132".tr ,
          
          colorText:  AppColor.white,
       
           snackPosition: SnackPosition.TOP,
            icon: Icon(Icons.favorite, color: AppColor.white, ),
            backgroundColor: Color.fromARGB(255, 216, 57, 17)
            );
    update();
  }

  gotoprofile2_0(myfavoritemodel) {
    statusRequest = StatusRequest.loading;
    Get.toNamed(AppRoutes.ProducteDetailsFav,
        arguments: {"myfavoriteModel": myfavoritemodel});
  }
}
