
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/core/class/statusrequest.dart';
import 'package:monami/core/constant/routes.dart';
import 'package:monami/core/function/handlingDatacontroller.dart';
import 'package:monami/core/services/services.dart';
import 'package:monami/students/home/data/datasource/remote/homedata.dart';
import 'package:monami/teachers/auth/data/model/teachers_model.dart';

abstract class HomeController extends GetxController {
  initialData();
  getData();
  goToPageProfileProf(profModel profmodel);
  gettoItems(List category, int selectedCat, String categoryid);
}

class HomeControllerImp extends HomeController {
  // ! ShardePrefrance
  MyServices myServices = Get.find();

  // ?Model
  late profModel profmodel;

  List<profModel> listdata = [];

  String? username;

  String? id;

  TextEditingController? search;
  bool isSearch = false;
  //!! Crud PHP
  HomeData homeData = HomeData(Get.find());
  checkSearch(val) {
    if (val == "") {
      statusRequest = StatusRequest.loading;
      isSearch = false;
    }
    update();
  }

  onSearchitems() {
    isSearch = true;
    searchData();
    update();
  }

  List data = [];

  //? List
  List adsviewstudntes = [];
  List langen = [];
  List langfr = [];
  List prof = [];

  late StatusRequest statusRequest;

  @override
  void onInit() {
    search = TextEditingController();
    FirebaseMessaging.instance.subscribeToTopic("users");
    // getData();
    initialData();
    super.onInit();
  }

  getData() async {
    data.clear();
    langen.clear();
    langfr.clear(); 
    adsviewstudntes.clear();
    statusRequest = StatusRequest.loading;
    var response = await homeData.getData();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {

        langen.addAll(response['langen']['data']);
       
        langfr.addAll(response['langfr']['data']);
         adsviewstudntes.addAll(response['adsviewstudntes']['data']);
      }
      // FirebaseMessaging.instance.subscribeToTopic("users");
      // FirebaseMessaging.instance.subscribeToTopic("users$usersid");
    } else {
      statusRequest = StatusRequest.failute;
    }
    update();
  }



  searchData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await homeData.searchData(search!.text);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      listdata.clear();
      List responsedata = response["data"];
      listdata.addAll(responsedata.map((e) => profModel.fromJson(e)));
    } else {
      statusRequest = StatusRequest.offlinefailute;
    }
    update();
  }

  initialData() {
    username = myServices.sharedPreferences.getString("username");
    id = myServices.sharedPreferences.getString("id");
  }

  @override
  gettoItems(category, selectedCat, categoryid) {
    statusRequest = StatusRequest.loading;
    Get.toNamed(AppRoutes.items, arguments: {
      "category": category,
      "selectedCat": selectedCat,
      "catid": categoryid,
    });
  }

  goToPageProfileProf(profmodel) {
    statusRequest = StatusRequest.loading;
    Get.toNamed("PageProfileProf", arguments: {"profModel": profmodel});
  }
}
