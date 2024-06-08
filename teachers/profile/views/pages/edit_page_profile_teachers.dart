import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:monami/teachers/profile/controller/edit_page_profile_teachers_controller.dart';
import 'package:monami/teachers/profile/controller/get_page_profile_teachers_controller.dart';
import 'package:monami/core/class/handlingDataview.dart';
import 'package:monami/core/class/statusrequest.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:monami/core/constant/app_image_assets.dart';
import 'package:monami/app_link.dart';
import 'package:monami/students/auth/views/widget/cstmBottomAuth.dart';
import 'package:monami/core/shared/custom_text_from_field.dart';


class EditPageProfileTeachers extends StatelessWidget {
  const EditPageProfileTeachers({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    EditPageProfileTeachersControllerImp controller =
        Get.put(EditPageProfileTeachersControllerImp());
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        title: Text(
          "Edit Profile",
            style: TextStyle(
            color: AppColor.buttommonami,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 
            2,
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
        body: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 255,
                width: double.infinity,
                child: ListView(
                  children: [
                    Column(children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Color.fromARGB(160, 255, 239, 215),
                                    Color.fromARGB(168, 238, 205, 155),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(60),
                                  bottomRight: Radius.circular(60)),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 290),
                              height: 0.5,
                              width: double.infinity,
                              decoration:
                                  const BoxDecoration(color: AppColor.grey)),
                          Container(
                            height: 250,
                            child: GetBuilder<PageProfileTeachersControllerImp>(
                                builder: (controller) => handlingDataView(
                                    statusRequest: controller.statusRequest,
                                    widget: ListView.builder(
                                        itemCount: controller.data.length,
                                        itemBuilder: (context, index) {
                                          return Center(
                                            child: Container(
                                              margin: EdgeInsets.only(top: 40),
                                              width: 150,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        '${AppLink.imagesprof}/${controller.data[index].profImage}',
                                                      ),
                                                      fit: BoxFit.cover),
                                                  borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16.0),
                                                    bottomRight:
                                                        Radius.circular(16.0),
                                                    topRight:
                                                        Radius.circular(16.0),
                                                    bottomLeft:
                                                        Radius.circular(16.0),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppColor.black
                                                          .withOpacity(0.1),
                                                      spreadRadius: 2,
                                                      blurRadius: 4,
                                                      offset: Offset(0,
                                                          4), // changes position of shadow
                                                    ),
                                                  ],
                                                  border: Border.all(
                                                      color: AppColor.white,
                                                      width: 3)),
                                            ),
                                          );
                                        }))),
                          ),
                          Container(
                            child: GetBuilder<EditPageProfileTeachersControllerImp>(
                              builder: (controller) => controller.statusRequest ==
                                      StatusRequest.loading
                                  ? Center(
                                      child: Lottie.asset(
                                      AppImageAsset.loading,
                                    ))
                                  : InkWell(
                                      onTap: () {
                                        controller.showOptionImage();
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        margin:
                                            EdgeInsets.only(top: 215, left: 245),
                                        decoration: BoxDecoration(
                                          color: AppColor.white,
                                          image: DecorationImage(image: AssetImage("images/Camera.png")),
                                          borderRadius: BorderRadius.circular(30),
        
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  AppColor.black.withOpacity(0.1),
                                              spreadRadius: 2,
                                              blurRadius: 4,
                                              offset: Offset(0,
                                                  4), // changes position of shadow
                                            ),
                                          ],
                                            border: Border.all(
                                                        color: AppColor.white,
                                                        width: 3)
                                        ),
                                     
                                      ),
                                    ),
                            ),
                          ),
                          Container(
                            height: 250,
                            child: GetBuilder<EditPageProfileTeachersControllerImp>(
                              builder: (controller) => 
                                  Center(
                                      child: Stack(
                                        children: [
                                          if (controller.file != null)
                                            Container(
                                              margin: EdgeInsets.only(top: 40),
                                              width: 153,
                                              height: 253,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: FileImage(
                                                          controller.file!)),
                                                  borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16.0),
                                                    bottomRight:
                                                        Radius.circular(16.0),
                                                    topRight:
                                                        Radius.circular(16.0),
                                                    bottomLeft:
                                                        Radius.circular(16.0),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppColor.black
                                                          .withOpacity(0.1),
                                                      spreadRadius: 2,
                                                      blurRadius: 4,
                                                      offset: Offset(0,
                                                          4), // changes position of shadow
                                                    ),
                                                  ],
                                                  border: Border.all(
                                                      color: AppColor.white,
                                                      width: 3)),
                                            ),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ])
                  ],
                ),
              ),
        SingleChildScrollView(
             scrollDirection: Axis.vertical,       
               child: Container(
                  height: 400,
                  child: GetBuilder<EditPageProfileTeachersControllerImp>(
                      builder: (controller) => 
                           Container(
                              child: Form(
                                key: controller.formstate,
                                child: ListView(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        children: [
                                          CustomTextFromFieldSmall(
                                            ObscureText: false,
                                            hinttext: 'Enter Your Nom',
                                            labeltext: ' Nom',
                                            iconData: Icons.person,
                                            mycontroller: controller.username,
                                            // mycontroller: mycontroller
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          CustomTextFromFieldSmall(
                                            ObscureText: false,
                                            hinttext: 'Enter Your Age',
                                            labeltext: ' Age',
                                            iconData: Icons.person,
                                            mycontroller: controller.age,
                                            // mycontroller: mycontroller
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextFromFieldMedium(
                                      ObscureText: false,
                                      hinttext: 'Enter Your Pays',
                                      labeltext: ' Pays',
                                      iconData: Icons.person,
                                      mycontroller: controller.cuntry,
                                      // mycontroller: mycontroller
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextFromFieldLarg(
                                      ObscureText: false,
                                      hinttext: 'Enter Your Description ',
                                      labeltext: 'Description',
                                      iconData: Icons.person,
                                      mycontroller: controller.desc, 
                                      // mycontroller: mycontroller.
                                    ),
                                     SizedBox(
                                      height: 20,
                                    ),
              
                                    cstmBottomAuth(
                                      text: 'Continue',
                                      onPressed: () {
                                        controller.editedata();
                                      },
                                    ),
                                     SizedBox(
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                ),
              ),
            ],
          ),
        ));
  }
}
