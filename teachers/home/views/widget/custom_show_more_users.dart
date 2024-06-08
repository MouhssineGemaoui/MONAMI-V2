import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monami/teachers/home/controller/show_more_students_english_controller.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:monami/students/auth/data/model/usersModel.dart';
import 'package:monami/app_link.dart';
import 'package:monami/students/favorites/controller/favoret_controller.dart';

class CustomShowMoreUsers extends GetView<viewpluslangenusresImp> {
  final usersModel usersmodel;
  const CustomShowMoreUsers({
    super.key,
    required this.usersmodel,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Favoritecontroller controllerfav = Get.put(Favoritecontroller());
    return Container(
      color: AppColor.white,
      child: InkWell(
        onTap: () {
          Get.defaultDialog(
              title: "Profile",
              content: Center(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 170,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60.0),
                            bottomLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0))),
                    child: Column(children: [
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
                                          '${AppLink.imagesprof}/${usersmodel.usersImage}',
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
                                      child: Text('${usersmodel.usersName}',
                                          style: TextStyle(
                                            fontSize: 20,
                                            letterSpacing: 2,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.black,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      child: Text('${usersmodel.usersCuntry}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 147, 146, 146),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Text('${usersmodel.usersDesc}',
                            style: TextStyle(
                              fontSize: 10,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              color: AppColor.black,
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 30,
                        width: 130,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "notification",
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Icon(
                                  Icons.notifications,
                                  color: AppColor.white,
                                )
                              ]),
                        ),
                      )
                    ])),
              ));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
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
                                    '${AppLink.imagesprof}/${usersmodel.usersImage}',
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
                            Text(
                              '${usersmodel.usersName}',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.black),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${usersmodel.usersCuntry}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 30,
                      width: 50,
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
                        child: 
                            
                              Icon(
                                Icons.notifications,
                                color: AppColor.white,
                              )
                       
                      ),
                    )
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
      ),
    );
  }
}
