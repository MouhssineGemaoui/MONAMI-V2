import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monami/core/function/chat.dart';
import 'package:monami/students/favorites/controller/favoret_controller.dart';
import 'package:monami/students/home/controller/home_page_controller.dart';
import 'package:monami/core/class/handlingDataview.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:monami/students/messages/data/model/ChatRoomModel.dart';
import 'package:monami/students/messages/views/widget/chats.dart';
import 'package:monami/teachers/auth/data/model/teachers_model.dart';
import 'package:monami/app_link.dart';
import 'package:monami/students/search/views/widget/custom_appbar_search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class SearchPageStudents extends StatefulWidget {
  const SearchPageStudents({super.key});

  @override
  State<SearchPageStudents> createState() => _SearchPageStudentsState();
}

class _SearchPageStudentsState extends State<SearchPageStudents> {
  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    return GetBuilder<HomeControllerImp>(
        builder: ((controller) => Scaffold(
          floatingActionButton:FloatingActionButton.extended(onPressed: () {
                                   controller.onSearchitems();
             
          }, 
          elevation: 10.0,
          foregroundColor: Colors.white,
          backgroundColor: AppColor.buttommonami,
          label: Text('13'.tr),
          icon: Icon(Icons.search),
          ) ,
                body: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(
                      Duration(seconds: 1),
                    );
                    controller.searchData();
                    setState(() {});
                  },
                  child: ListView(children: [
                    cstmappbarsearch(
                      titleappbar: '13'.tr,
                      onPressedSearch: () {
                        controller.onSearchitems();
                      },
                      mycontroller: controller.search!,
                      onChanged: (val) {
                        controller.checkSearch(val);
                      },
                    ),
                    SizedBox(height: 10),
                    handlingDataView(
                        statusRequest: controller.statusRequest,
                        widget: controller.isSearch
                            ? ListSearchPageStudents(
                                listdatasearch: controller.listdata)
                            : Center(
                                child: Text("There are no search results")))
                  ])),
            ))));
  }
}

class ListSearchPageStudents extends GetView<HomeControllerImp> {
  final List<profModel> listdatasearch;
  const ListSearchPageStudents({super.key, required this.listdatasearch});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    return ListView.builder(
        itemCount: listdatasearch.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
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
                                          '${AppLink.imagesprof}/${listdatasearch[index].profImage}',
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
                                      child: Text('${listdatasearch[index].profName}',
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
                                      child: Text('${listdatasearch[index].profCuntry}',
                                          style: GoogleFonts.arbutusSlab(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 147, 146, 146),
                                          )),
                                    ),
                                    Container(
                                      child: Text('${listdatasearch[index].profAge}Ans',
                                          style: GoogleFonts.arbutusSlab(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 147, 146, 146),
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
                                                .isFavorite[listdatasearch[index].profId] ==
                                            "1") {
                                          controllerfav.setFavorite(
                                              listdatasearch[index].profId, "0");
                                          controllerfav.removeFavorite(
                                              listdatasearch[index].profId!);
                                        } else {
                                          controllerfav.setFavorite(
                                              listdatasearch[index].profId, "1");
                                          controllerfav
                                              .addFavorite(listdatasearch[index].profId!);
                                        }
                                      },
                                      icon: Icon(
                                        controllerfav.isFavorite[
                                                    listdatasearch[index].profId] ==
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
                        child: Text('${listdatasearch[index].profDesc}',
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
                                    id: listdatasearch[index].profId.toString(),
                                    name: listdatasearch[index].profName.toString(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 25),
                            InkWell(
                              onTap: () async {
                                ChatRoomModel? chat = await ChatFunction()
                                    .getChatroomModel(listdatasearch[index]);
                                if (chat != null) {
                                  var instance =
                                      await SharedPreferences.getInstance();
                                  var id = instance.getString("id");
                                  print(int.parse(id.toString()));
                                  Get.to(() => ChatPage(
                                        name: listdatasearch[index].profName,
                                        currentUserId: int.parse(id.toString()),
                                        chatroom: chat,
                                        profmodel: listdatasearch[index],
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
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
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
                                        '${AppLink.imagesprof}/${listdatasearch[index].profImage}',
                                      ),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                    bottomLeft: Radius.circular(30.0),
                                  ),
                                  border: Border.all(
                                      color: AppColor.green, width: 1)),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${listdatasearch[index].profName}',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.black),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${listdatasearch[index].contryName}',
                                       style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.grey),
                                    ),
                                  ],
                                ),
                                      Row(
                            children: [
                              ...List.generate(
                                  5,
                                  (index) => Icon(
                                        Icons.star_rate_rounded,
                                        color: AppColor.gold,
                                        size: 7,
                                      ))
                            ],
                          ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    height: 0.21,
                    color: AppColor.grey,
                  )
                ],
              ),
            ),
          );
        });
  }
}
