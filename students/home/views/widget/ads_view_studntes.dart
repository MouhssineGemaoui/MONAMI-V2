import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:monami/students/favorites/controller/favoret_controller.dart';
import 'package:monami/students/home/controller/home_page_controller.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:monami/core/function/chat.dart';
import 'package:monami/students/home/data/model/ads_model.dart';
import 'package:monami/students/messages/data/model/ChatRoomModel.dart';
import 'package:monami/teachers/auth/data/model/teachers_model.dart';
import 'package:monami/app_link.dart';
import 'package:monami/students/messages/views/widget/chats.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class AdsViewStodents extends GetView<HomeControllerImp> {
  const AdsViewStodents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
          itemCount: controller.adsviewstudntes.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return AdsView(
                adsmodel: AdsModel.fromJson(controller.adsviewstudntes[i]),);
          }),
    );
  }
}

class AdsView extends GetView<HomeControllerImp> {
  final AdsModel adsmodel;
  const AdsView({super.key, required this.adsmodel});

  @override
  Widget build(BuildContext context) {
    Get.put(Favoritecontroller());
    return Container(
     
child:  Container(
  margin: EdgeInsets.symmetric(horizontal: 10),
               width:MediaQuery.sizeOf(context).width / 1.1,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                          AppLink.imageads + "/" + adsmodel.adsImage!,
                             ), fit: BoxFit.cover,
        ),
                        borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                      border: Border.all(
                          width: 1, color: AppColor.primaryColormonami),
                    ),
    ),

         
    );
  }
}
