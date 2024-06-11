import 'package:get/get.dart';
import 'package:monami/students/abonnement/data/datasource/local/abonnement_data.dart';
import 'package:monami/core/function/handlingDatacontroller.dart';
import 'package:monami/core/services/services.dart';

import '../../../core/class/statusrequest.dart';

abstract class AbonnementController extends GetxController {
  getData();

  selectLang(String lang);

  unselectLang(String lang);

  selectProf(int profId);

  unselectProf(int profId);

  selectMois(int mois);

  selectDuree(int duree);

  confirm();
}

class AbonnementControllerImp extends AbonnementController {
  AbonnementData abonnementData = AbonnementData(Get.find());
  MyServices myServices = Get.find();
  Map listLang = {"us": "Anglais", "fr": "Français"};
  List selectedLang = ["us", "fr"];

  List listProfs = [];
  List selectedProf = [1, 2, 3];

  List listMois = [1];
  int selectedMois = 1;
  Map listDureePrix = {12: 6.9, 16: 8.9, 24: 16.9};
  int selectedDuree = 16;

  late bool isPaying;

  late StatusRequest statusRequest;

  @override
  void onInit() {
    super.onInit();
  }

  getData() async {
    isPaying = false;
    listProfs.clear();
    statusRequest = StatusRequest.loading;
    var response = await abonnementData.getData();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        listProfs.addAll(response['data']);
      }
    } else {
      statusRequest = StatusRequest.failute;
    }
    update();
  }

  @override
  selectLang(String lang) {
    selectedLang.add(lang);
    update();
  }

  @override
  selectProf(int profId) {
    selectedProf.add(profId);
    update();
  }

  @override
  unselectLang(String lang) {
    selectedLang.remove(lang);
    update();
  }

  @override
  unselectProf(int profId) {
    selectedProf.remove(profId);
    update();
  }

  @override
  selectMois(int mois) {
    selectedMois = mois;
    update();
  }

  @override
  selectDuree(int duree) {
    selectedDuree = duree;
    update();
  }

  @override
  confirm() async {
    setPaying(true);
    try {
      await myServices.stripe.makePayment(
        this.listDureePrix[this.selectedDuree],
        myServices.sharedPreferences.getString("users_name")!,
        myServices.sharedPreferences.getString("users_email")!,
      );
      //Save users subscription to your cloud
      setPaying(false);
      Get.back();
    } catch (e) {
      setPaying(false);
    }
  }

  void setPaying(bool flag) {
    isPaying = flag;
    update();
  }
}
