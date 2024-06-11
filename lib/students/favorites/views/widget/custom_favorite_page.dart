
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:monami/core/function/chat.dart';
import 'package:monami/students/messages/data/model/ChatRoomModel.dart';
import 'package:monami/students/favorites/data/model/favorite_model.dart';
import 'package:monami/teachers/auth/data/model/teachers_model.dart';
import 'package:monami/app_link.dart';
import 'package:monami/students/favorites/controller/favorite_page_controller.dart';
import 'package:monami/students/messages/views/widget/chats.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CstmMyfavoriteprof extends GetView<MyFavoritecontroller> {
  final myfavoriteModel  myfavoritemodel;
  const CstmMyfavoriteprof( {super.key, required this.myfavoritemodel,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
                onTap: () {
                      // controller.gotoprofile2_0(myfavoritemodel);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
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
                                            '${AppLink.imagesprof}/${myfavoritemodel.profImage}',
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
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                             controller.gotoprofile2_0(myfavoritemodel);
                                          },
                                          child: Text(
                                            '${myfavoritemodel.profName}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.black),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                      
                                      ],
                                    ),
                                      Text(
                                      '${myfavoritemodel.profCuntry}',
                                    )
                                    // Text(
                                    //   '${myfavoritemodel.profLang}',
                                    // )
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                   
                         InkWell(onTap: () {                          
                                  controller.deletFromFavorite(myfavoritemodel.favorieId!) ;

                         },
                           child: 
                               Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                           
                            
                         ),
                              
                                  ],
                                ),
                         
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "${myfavoritemodel.profDesc}",
                          style: TextStyle(fontSize: 15, color: AppColor.black , ),
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
                                isVideoCall: true,
                                borderRadius: 10,
                                buttonSize: Size(10, 10),                       
                                unclickableBackgroundColor: AppColor.appelvideo,
                                clickableBackgroundColor: AppColor.appelvideo,
                                verticalLayout: false,
                                invitees: [
                                  ZegoUIKitUser(
                                    id: myfavoritemodel.profId.toString(),
                                    name: myfavoritemodel.profName.toString(),
                                  ),
                                ],
                              ),
                            ),
                                InkWell(
                                  onTap: ()async{
                                    var instance = await SharedPreferences.getInstance();
                                    String? id = instance.getString("id");
                                    Map<String,dynamic> model = myfavoriteModel().toJson();
                                    profModel prof = profModel.fromJson({
                                      "prof_id" : myfavoritemodel.profId,
                                      "prof_name" : myfavoritemodel.profName,
                                      "prof_image" : myfavoritemodel.profImage,
                                    });
                                    ChatRoomModel? chatRoomModel = await ChatFunction().getChatroomModel(prof);
                                    if(chatRoomModel != null){
                                      Get.to(()=>ChatPage(
                                        chatroom: chatRoomModel, name: myfavoritemodel.profName, currentUserId: int.parse(id.toString()), profmodel: prof,
                                        ));
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Image.asset('images/chat.png')),
                                ),
                                
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                        height: 1,
                        color: AppColor.buttommonami,
                      )
                    ],
                  ),
                ),
              );
            
  }
}
