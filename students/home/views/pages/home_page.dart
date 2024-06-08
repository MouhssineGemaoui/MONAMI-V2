import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/students/bkvideo.dart';
import 'package:monami/students/home/controller/home_page_controller.dart';
import 'package:monami/core/class/handlingDataview.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:monami/core/constant/routes.dart';
import 'package:monami/students/home/views/widget/ads_view_studntes.dart';
import 'package:monami/students/home/views/widget/list_prof_speaking_english.dart';
import 'package:monami/students/home/views/widget/list_prof_speaking_french.dart';
import 'package:monami/students/home/views/widget/statistics_students.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   HomeControllerImp controller = Get.put(HomeControllerImp());
  @override
  void initState() {
         controller.getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    HomeControllerImp controller = Get.put(HomeControllerImp());
    return Scaffold(
      body: Stack(
        children: [
           BackgroundVideoWidget(),
          Container(
              child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(
                Duration(seconds: 1),
              );
              controller.getData();
              setState(() {});
            },
            child: ListView(children: [
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                        Container(
                    
                    height: 150,
                    child: Container(
                      height: 150,
                      child: GetBuilder<HomeControllerImp>(
                          builder: ((controller) => handlingDataView(
                                statusRequest: controller.statusRequest,
                                widget: AdsViewStodents(),
                              ))),
                    ),
                  ),
                  // MainScren(),
                  SizedBox(
                    height: 15,
                  ),
                  MonAcc(),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "10".tr,
                          style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 14,
                              color: AppColor.black
                              ,
                              fontWeight: FontWeight.w700),
                        ),
                        InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.PageShowMoreProfEnglish);
                            },
                            child: Container(
                              child: Row(children: [
                                Text(
                                  "11".tr,
                                  style: TextStyle(
                                     fontSize: 10,
                                    color: AppColor.buttommonami),
                                ),
                                Icon(
                                  Icons.login_outlined,
                                  color: AppColor.buttommonami,
                                  size: 10,
                                )
                              ]),
                            ))
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    height: 90,
                    child: Container(
                      height: 100,
                      child: GetBuilder<HomeControllerImp>(
                          builder: ((controller) => handlingDataView(
                                statusRequest: controller.statusRequest,
                                widget: ListProfSpeakingEnglish(),
                            ))
                        ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "9".tr,
                          style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 14,
                              color: AppColor.black,
                              fontWeight: FontWeight.w700),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.PageShowMoreProfFrench);
                          },
                          child: Container(
                            child: Row(children: [
                              Text(
                               "11".tr,
                                style: TextStyle(color: AppColor.buttommonami
                                ,
                                 fontSize: 10,),
                              ),
                              Icon(
                                Icons.login_outlined,
                                color: AppColor.buttommonami,
                                size: 10,
                              )
                            ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container( padding: EdgeInsets.only(left: 15,right:15), // margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 100,
                    child: Container(
                      height: 100,
                      child: GetBuilder<HomeControllerImp>(
                          builder: ((controller) => handlingDataView(
                                statusRequest: controller.statusRequest,
                                widget: ListProfSpeakingFrench(),
                              ))),
                    ),
                  )
                ],
              ),
            ]),
          )),
        ],
      ),
    );
  }
}
