import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/teachers/home/controller/active_tearchers.dart';
import 'package:monami/teachers/home/controller/home_page_tearchers_controller.dart';
import 'package:monami/core/class/handlingDataview.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:monami/core/constant/routes.dart';
import 'package:monami/teachers/home/views/widget/List_students_home.dart';
import 'package:monami/teachers/home/views/widget/bottom_active.dart';
import 'package:monami/teachers/home/views/widget/statistics_teachers.dart';

class HomePageTearchers extends StatefulWidget {
  const HomePageTearchers({super.key});

  @override
  State<HomePageTearchers> createState() => _HomePageTearchersState();
}

class _HomePageTearchersState extends State<HomePageTearchers> {
  @override
  Widget build(BuildContext context) {
    HomeProfControllerImp controller = Get.put(HomeProfControllerImp());
    Get.put(activecontroller());
    return Scaffold(
      body: Stack(
        children: [
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
                  Center(child: BottomActive()),
                  SizedBox(
                    height: 15,
                  ),
                  monAccontProf(),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "vous avez gagnez jus-qui a maintenant de :",
                      style: TextStyle(
                        color: AppColor.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'students',
                          style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 18,
                              color: AppColor.buttommonami,
                              fontWeight: FontWeight.w700),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.PageShowMoreUsers);
                          },
                          child: Container(
                            child: Row(children: [
                              Text(
                                "View plus",
                                style: TextStyle(color: AppColor.grey),
                              ),
                              Icon(
                                Icons.login_outlined,
                                color: AppColor.grey,
                              )
                            ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    height: 500,
                    child: GetBuilder<HomeProfControllerImp>(
                        builder: ((controller) => handlingDataView(
                              statusRequest: controller.statusRequest,
                              widget: ListStodentsHome(),
                            ))),
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
