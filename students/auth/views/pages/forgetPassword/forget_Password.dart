import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:monami/students/auth/controller/forgetpassword/forget_Password_controller.dart';
import 'package:monami/core/class/statusrequest.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:monami/core/constant/app_image_assets.dart';
import 'package:monami/students/auth/views/widget/cstmBottomAuth.dart';
import 'package:monami/students/auth/views/widget/cstmTextAuth.dart';
import 'package:monami/students/auth/views/widget/cstmTextBodyAuth.dart';
import 'package:monami/core/shared/custom_text_from_field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
        Get.put(ForgetPasswordcontrollerImp());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.white,
          elevation: 0,
          title: Text('Forget Password',
              style: Theme.of(context)
                  .textTheme
      // ignore: deprecated_member_use
                  .displayLarge!
                  .copyWith(color: AppColor.grey)),
        ),
        body:GetBuilder<ForgetPasswordcontrollerImp>(builder: (controller) =>
           controller.statusRequest == StatusRequest.loading ?
           Center(child: Lottie.asset(AppImageAsset.loading ,width: 250 ,height: 250))
         :   Container(
            color: AppColor.white,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Form(
              key: controller.formstate,
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  const cstmTextAuth(text: 'Check Email'),
                  const SizedBox(height: 20),
                  const cstmTextBodyAuth(text: "Please Enter Your new password"),
                  const SizedBox(height: 20),
                  CustomTextFromFieldMedium(
                    ObscureText: false,
                    // ignore: body_might_complete_normally_nullable
                    // valid: (val) {},
                    mycontroller: controller.email,
                    hinttext: 'Enter Your Email',
                    labeltext: ' Email',
                    iconData: Icons.email_outlined,
                    // mycontroller: mycontroller
                  ),SizedBox(height: 20,),
                  cstmBottomAuth(
                    text: 'Check',
                    onPressed: () {
                      controller.checkemail();
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            )),));
  }
}
