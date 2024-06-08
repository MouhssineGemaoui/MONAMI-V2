import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/students/abonnement/controller/abonnement_controller.dart';
import 'package:monami/students/abonnement/widget/select_group_duree_abonnement.dart';
import 'package:monami/students/abonnement/widget/select_group_langue_abonnement.dart';
import 'package:monami/students/abonnement/widget/select_group_mois_abonnement.dart';
import 'package:monami/students/abonnement/widget/select_group_prof_abonnement.dart';
import 'package:monami/core/class/handlingDataview.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:monami/core/services/services.dart';

class AbonnementPage extends StatefulWidget {
  const AbonnementPage({super.key});

  @override
  State<AbonnementPage> createState() => _AbonnementPageState();
}

class _AbonnementPageState extends State<AbonnementPage> {
  AbonnementControllerImp controller = Get.put(AbonnementControllerImp());
  MyServices myServices = Get.find();

  @override
  void initState() {
    controller.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        title: Text(
          "Subscribe",
          style: TextStyle(
            color: AppColor.buttommonami,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
          ),
          color: AppColor.buttommonami,
        ),
      ),
      body: Container(
        color: AppColor.white,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //Langues
        child: ListView(
          children: [
            GetBuilder<AbonnementControllerImp>(builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "> Choisissez la langue  que vous voulez pratiquer",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    "Remarque: vous pouvez choisir les deux langues ",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                      height: 50,
                      child: Container(
                          height: 40,
                          child: Center(
                              child: SelectGroupLangueAbonnement(
                            isSelectable: false,
                          ))))
                ],
              );
            }),
            SizedBox(
              height: 8,
            ),
            //Parlants
            GetBuilder<AbonnementControllerImp>(builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "> Choisissez les parlants que vous préférez",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    "Remarque: vous pouvez choisir les 3 parlants ",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      height: 80,
                      child: Container(
                          height: 90,
                          child: GetBuilder<AbonnementControllerImp>(
                              builder: ((controller) => handlingDataView(
                                    statusRequest: controller.statusRequest,
                                    widget: SelectGroupProfAbonnement(
                                      isSelectable: false,
                                    ),
                                  ))))),
                ],
              );
            }),

            //Mois
            SizedBox(
              height: 8,
            ),
            GetBuilder<AbonnementControllerImp>(builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "> choisissez la durée qui vous convient",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      height: 30,
                      child: Container(
                        height: 40,
                        child: SelectGroupMoisAbonnement(),
                      ))
                ],
              );
            }),
            //Durée
            SizedBox(
              height: 8,
            ),
            GetBuilder<AbonnementControllerImp>(builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "> choisissez la durée de de votre souscription",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      height: 120,
                      child: Container(
                        height: 130,
                        child: SelectGroupDureeAbonnement(isSelectable: !controller.isPaying,),
                      ))
                ],
              );
            }),
            //Résumé
            SizedBox(
              height: 8,
            ),
            GetBuilder<AbonnementControllerImp>(builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "> Résumé",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    "vous allez pratiquer la langue ${controller.selectedLang.map((e) => controller.listLang[e])}" +
                        "\navec les parlants  ${controller.selectedDuree} Minutes par  jour," +
                        "\ntous les jours / pendant  ${controller.selectedMois} Mois  ",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        "MONTANT TOTAL",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      Expanded(
                          child: Text(
                        "${controller.listDureePrix[controller.selectedDuree]}\$",
                        textAlign: TextAlign.end,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.w700),
                      )),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Center(
                    child: SizedBox(
                      height: 30,
                      width: 187,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.buttommonami,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: controller.isPaying
                            ? null
                            : () async {
                                await controller.confirm();
                              },
                        child: Text(
                          "CONFIRMER",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  )
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
