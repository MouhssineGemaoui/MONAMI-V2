import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/students/favorites/controller/favoret_controller.dart';
import 'package:monami/students/home/controller/show_more_prof_english_controller.dart';
import 'package:monami/core/class/handlingDataview.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:monami/teachers/auth/data/model/teachers_model.dart';
import 'package:monami/students/home/views/widget/show_more_prof_english.dart';


class PageShowMoreProfEnglish extends StatelessWidget {
  const PageShowMoreProfEnglish({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PageShowMoreProfEnglishControllerImp());
       Favoritecontroller controllerfav = Get.put(Favoritecontroller());
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        title: Text(
          "10".tr,
          style: TextStyle(
            color: AppColor.buttommonami,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
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
      backgroundColor: Color.fromARGB(244, 254, 250, 250),
      body: Container(
        color: Color.fromARGB(244, 255, 255, 255),
        child: ListView(
          children: [
            GetBuilder<PageShowMoreProfEnglishControllerImp>(
                builder: (controller) => handlingDataView(
                      statusRequest: controller.statusRequest,
                      widget: ListView.builder(
                          itemCount: controller.data.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            controllerfav.isFavorite[controller.data[index]['prof_id']] = controller.data[index]['favorie'] ;
                            return Container(
                              child: Show_More_Prof_English(
                                profmodel:
                                    profModel.fromJson(controller.data[index]),
                              ),
                            );
                          }),
               ))
          ],
        ),
      ),
    );
  }
}