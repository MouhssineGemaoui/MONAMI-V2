import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monami/core/function/chat.dart';
import 'package:monami/students/favorites/controller/favoret_controller.dart';
import 'package:monami/students/home/controller/show_more_prof_english_controller.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:monami/students/messages/data/model/ChatRoomModel.dart';
import 'package:monami/students/messages/views/widget/chats.dart';
import 'package:monami/teachers/auth/data/model/teachers_model.dart';
import 'package:monami/app_link.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class Show_More_Prof_French
    extends GetView<PageShowMoreProfEnglishControllerImp> {
  final profModel profmodel;
  const Show_More_Prof_French({
    super.key,
    required this.profmodel,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(PageShowMoreProfEnglishControllerImp());
    // ignore: unused_local_variable
    Favoritecontroller controllerfav = Get.put(Favoritecontroller());
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          title: "Profile",
          titleStyle: GoogleFonts.inter(
            fontSize: 17,
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
            color: AppColor.black,
          ),
          content: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              height: 170,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60.0),
                      bottomLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      '${AppLink.imagesprof}/${profmodel.profImage}',
                                    ),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    width: 1,
                                    color: AppColor.primaryColormonami),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text('${profmodel.profName}',
                                      style: GoogleFonts.inter(
                                        fontSize: 17,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.black,
                                      )),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  child: Text('${profmodel.profCuntry}',
                                      style: GoogleFonts.arbutusSlab(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            Color.fromARGB(255, 147, 146, 146),
                                      )),
                                ),
                                Container(
                                  child: Text('${profmodel.profAge}Ans',
                                      style: GoogleFonts.arbutusSlab(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            Color.fromARGB(255, 147, 146, 146),
                                      )),
                                ),
                                Row(
                                  children: [
                                    ...List.generate(
                                        5,
                                        (index) => Icon(
                                              Icons.star_rate_rounded,
                                              color: AppColor.gold,
                                              size: 15,
                                            ))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: GetBuilder<Favoritecontroller>(
                              builder: (controllerfav) => IconButton(
                                  onPressed: () {
                                    if (controllerfav
                                            .isFavorite[profmodel.profId] ==
                                        "1") {
                                      controllerfav.setFavorite(
                                          profmodel.profId, "0");
                                      controllerfav
                                          .removeFavorite(profmodel.profId!);
                                    } else {
                                      controllerfav.setFavorite(
                                          profmodel.profId, "1");
                                      controllerfav
                                          .addFavorite(profmodel.profId!);
                                    }
                                  },
                                  icon: Icon(
                                    controllerfav
                                                .isFavorite[profmodel.profId] ==
                                            "1"
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: AppColor.favorite,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text('${profmodel.profDesc}',
                        style: GoogleFonts.arbutusSlab(
                          fontSize: 10,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          color: AppColor.black,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(0),
                          height: 32,
                          width: 110,
                          child: ZegoSendCallInvitationButton(
                            margin: EdgeInsets.all(1),
                            resourceID: "zegouikit_call",
                            isVideoCall: false,
                            textStyle: TextStyle(
                                color: AppColor.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                            borderRadius: 10,
                            iconTextSpacing: 1,
                            unclickableBackgroundColor: AppColor.appelvideo,
                            clickableBackgroundColor: AppColor.appelvideo,
                            verticalLayout: false,
                            invitees: [
                              ZegoUIKitUser(
                                id: profmodel.profId.toString(),
                                name: profmodel.profName.toString(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 25),
                        InkWell(
                          onTap: () async {
                            ChatRoomModel? chat = await ChatFunction()
                                .getChatroomModel(profmodel);
                            if (chat != null) {
                              var instance =
                                  await SharedPreferences.getInstance();
                              var id = instance.getString("id");
                              print(int.parse(id.toString()));
                              Get.to(() => ChatPage(
                                    name: profmodel.profName,
                                    currentUserId: int.parse(id.toString()),
                                    chatroom: chat,
                                    profmodel: profmodel,
                                  ));
                            }
                          },
                          child: Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                color: AppColor.buttommonami,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10)),
                              ),
                              child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Messages",
                                        style: TextStyle(
                                            color: AppColor.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Icon(
                                        Icons.chat_rounded,
                                        color: AppColor.white,
                                      )
                                    ],
                                  ))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          // color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  '${AppLink.imagesprof}/${profmodel.profImage}',
                                ),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0),
                            ),
                            border:
                                Border.all(color: AppColor.green, width: 1)),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  '${profmodel.profName}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Cairo",
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.black),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              // CircleAvatar(
                              //   radius: 7,
                              //   backgroundImage:
                              //       AssetImage("images/brazil.png"),
                              // ),
                            ],
                          ),
                          Text(
                            '${profmodel.contryName}',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color:
                                    const Color.fromARGB(255, 125, 123, 123)),
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GetBuilder<Favoritecontroller>(
                          builder: (controller) => Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        if (controller
                                                .isFavorite[profmodel.profId] ==
                                            "1") {
                                          controller.setFavorite(
                                              profmodel.profId!, "0");
                                          controller.removeFavorite(
                                              profmodel.profId.toString());
                                        } else {
                                          controller.setFavorite(
                                              profmodel.profId!, "1");
                                          controller.addFavorite(
                                              profmodel.profId.toString());
                                        }
                                      },
                                      icon: Icon(
                                        controller.isFavorite[
                                                    profmodel.profId!] ==
                                                "1"
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        color: AppColor.favorite,
                                      )),
                                ],
                              )),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 3, top: 8),
              child: Text(
                "${profmodel.profDesc}",
                style: TextStyle(
                  fontSize: 12,
                  color: AppColor.black,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ...List.generate(
                        5,
                        (index) => Icon(
                              Icons.star_rate_rounded,
                              color: AppColor.gold,
                              size: 15,
                            ))
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  height: 32,
                  width: 100,
                  child: ZegoSendCallInvitationButton(
                    margin: EdgeInsets.all(1),
                    resourceID: "zegouikit_call",
                    isVideoCall: false,
                    borderRadius: 10,
                    buttonSize: Size(10, 10),
                    unclickableBackgroundColor: AppColor.appelvideo,
                    clickableBackgroundColor: AppColor.appelvideo,
                    verticalLayout: false,
                    invitees: [
                      ZegoUIKitUser(
                        id: profmodel.profId.toString(),
                        name: profmodel.profName.toString(),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    child: Image.asset('images/chat.png')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
