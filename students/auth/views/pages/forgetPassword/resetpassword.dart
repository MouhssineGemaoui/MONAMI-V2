import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/students/auth/controller/forgetpassword/resetpassword.dart';
import 'package:monami/core/class/statusrequest.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:monami/core/function/validinput.dart';
import 'package:monami/students/auth/views/widget/cstmBottomAuth.dart';
import 'package:monami/students/auth/views/widget/cstmTextBodyAuth.dart';
import 'package:monami/core/shared/custom_text_from_field.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
        Get.put(ResetpasswordcontrollerImp());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.white,
          elevation: 0,
          title: Text('Reset Password',
              style: Theme.of(context)
                  .textTheme
      // ignore: deprecated_member_use
                  .displayLarge!
                  .copyWith(color: AppColor.grey)),
        ),
     body: GetBuilder<ResetpasswordcontrollerImp>(
          builder: (controller) => controller.statusRequest ==
                  StatusRequest.loading
              ? const Center(child: Text("Loading..."))
              : Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Form(
                    key: controller.formstate,
                    child: ListView(children: [
                      const SizedBox(height: 20),
                      cstmTextBodyAuth(text: "35".tr),
                      const SizedBox(height: 10),
                      cstmTextBodyAuth(text: "35".tr),
                      const SizedBox(height: 15),
                      CustomTextFromFieldMedium(
                        // valid: (val) {
                        //   return ValidInput(val!, 3, 40, "password");
                        // },
                        mycontroller: controller.password,
                        hinttext: "13".tr,
                        iconData: Icons.lock_outline,
                        labeltext: "19".tr,
                        // mycontroller: ,
                      ),
                    CustomTextFromFieldMedium(

                        // valid: (val) {
                        //   return ValidInput(val!, 3, 40, "password");
                        // },
                        mycontroller: controller.repassword,
                        hinttext: "Re" + " " + "13".tr,
                        iconData: Icons.lock_outline,
                        labeltext: "19".tr,
                        // mycontroller: ,
                      ),
                      cstmBottomAuth(
                          text: "33".tr,
                          onPressed: () {
                            controller.goToSuccessResetPassword();
                          }),
                      const SizedBox(height: 40),
                    ]),
                  ),
                )),
    );
  }
}