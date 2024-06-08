import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:monami/core/class/statusrequest.dart';
import 'package:monami/core/function/handlingDatacontroller.dart';
import 'package:monami/core/services/services.dart';
import 'package:monami/teachers/home/data/datasource/remote/homedata.dart';
import 'package:monami/students/auth/data/model/usersModel.dart';

abstract class HomeProfController extends GetxController {
  initialData();
  getData();
  goToPageProductDetails(usersModel usersmodel);
  // gettoItems(List category, int selectedCat, String categoryid );
}

class HomeProfControllerImp extends HomeProfController {
  // ! ShardePrefrance
  MyServices myServices = Get.find();

  // ?Model
  usersModel? usersmodel;

  String? username;
  int? id;

  //!! Crud PHP
  HomePageTearchersData HomePageTearchersdata = HomePageTearchersData(Get.find());

  
  List data = [];
  //? List
  List langen = [];

  late StatusRequest statusRequest;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    langen.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await HomePageTearchersdata.getData();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      String profid = myServices.sharedPreferences.getString("id")!;
      // category.addAll(response['category']);
      langen.addAll(response['langen']['data']);
      
      FirebaseMessaging.instance.subscribeToTopic("prof");
      FirebaseMessaging.instance.subscribeToTopic("prof$profid");
    } else {
      statusRequest = StatusRequest.failute;
    }
    update();
  }

  initialData() {
    username = myServices.sharedPreferences.getString("username");
    id = int.parse(myServices.sharedPreferences.getString("id")!);
  }

  goToPageProductDetails(usersmodel) {
    Get.toNamed("usersprofileDetails", arguments: {"usersModel": usersmodel});
  }
}
