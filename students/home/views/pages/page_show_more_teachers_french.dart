import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/students/favorites/controller/favoret_controller.dart';
import 'package:monami/students/home/controller/show_more_prof_french_controller.dart';
import 'package:monami/core/class/handlingDataview.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:monami/teachers/auth/data/model/teachers_model.dart';
import 'package:monami/Skelton_Loading/NewCard.dart';
import 'package:monami/Skelton_Loading/constants.dart';
import 'package:monami/students/home/views/widget/show_more_prof_french.dart';



class PageShowMoreProfFrench extends StatefulWidget {
  const PageShowMoreProfFrench({Key? key}) : super(key: key);

  @override
  State<PageShowMoreProfFrench> createState() => _PageShowMoreProfFrenchState();
}

class _PageShowMoreProfFrenchState extends State<PageShowMoreProfFrench> {
  late bool _isLoading;

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   Get.put(PageShowMoreProffrenchControllerImp());
       Favoritecontroller controllerfav = Get.put(Favoritecontroller());
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        title: Text(
          "9".tr,
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
            GetBuilder<PageShowMoreProffrenchControllerImp>(
                builder: (controller) => handlingDataView(
                      statusRequest: controller.statusRequest,
                      widget: ListView.builder(
                          itemCount: controller.data.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            controllerfav.isFavorite[controller.data[index]['prof_id']] = controller.data[index]['favorie'] ;
                            return
                              Container(
          color: AppColor.white,
                 child: _isLoading
              ? ListView.separated(
                  itemCount: 5,
                  itemBuilder: (context, index) =>  NewsCardSkelton(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: defaultPadding),
                ):
                               Show_More_Prof_French(
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