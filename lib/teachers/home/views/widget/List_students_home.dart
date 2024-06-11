import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/app_link.dart';
import 'package:monami/teachers/home/controller/home_page_tearchers_controller.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:monami/students/auth/data/model/usersModel.dart';

class ListStodentsHome extends GetView<HomeProfControllerImp> {
  const ListStodentsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: 
      GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                childAspectRatio:  0.9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
   itemCount: controller.langen.length,
          scrollDirection:Axis.vertical,
          itemBuilder: (context, i) {
            return ListStodents(
                usersmodel: usersModel.fromJson(controller.langen[i]));
          }),
    );
  }
}

class ListStodents extends GetView<HomeProfControllerImp> {
  final usersModel usersmodel;
  const ListStodents({super.key , required this.usersmodel});

  @override
  Widget build(BuildContext context) {
 return InkWell(
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
                                      child: Text('Français',
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
                             child:  Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
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
                ),)])
              ),)
            );
          },
        child: Container(
          // color: Colors.black,
          width: 90,
          height: 100,
          child: Stack(
            children: [
              Container(
                width: 80,
                height: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        '${AppLink.imagesprof}/${usersmodel.usersImage}',
                      ),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      bottomLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0)),
                      border: Border.all(
                          width: 1, color: AppColor.primaryColormonami),
                ),
              ),
              Positioned(
                  top: 75,
                  width: 80,
                  child: Container(
                    decoration: BoxDecoration(
                     color: AppColor.primaryColormonami ,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                      ),
                      border: Border.all(
                          width: 1, color: AppColor.primaryColormonami),
                    ),
                    height: 19,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${usersmodel.usersName}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColor.black,
                              )),
                        
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}
