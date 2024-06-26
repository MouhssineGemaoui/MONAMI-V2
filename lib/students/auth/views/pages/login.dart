import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:monami/students/auth/controller/login_controller.dart';
import 'package:monami/core/class/statusrequest.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:monami/core/constant/app_image_assets.dart';
import 'package:monami/core/function/validinput.dart';
import 'package:monami/core/shared/LogoAuth.dart';
import 'package:monami/students/auth/views/widget/cstmBottomAuth.dart';
import 'package:monami/students/auth/views/widget/cstmTextAuth.dart';
import 'package:monami/students/auth/views/widget/cstmTextBodyAuth.dart';
import 'package:monami/students/auth/views/widget/textsignup&login.dart';
import 'package:monami/core/shared/custom_text_from_field.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
Get.put(LogincontrollerImp());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.white,

          elevation: 0,
          centerTitle: true,
          flexibleSpace: Container(
              margin: EdgeInsets.only(top: 50),
              height: 150,
              width: 200,
              decoration: const BoxDecoration(
                color: AppColor.white,
                image: DecorationImage(
                    image: AssetImage('images/monami.png'),
                    fit: BoxFit.fitHeight),
              )),
        ),
        body:
             GetBuilder<LogincontrollerImp>(
              builder: (controller) => controller.statusRequest ==
                      StatusRequest.loading
                  ? Center(
                      child: Lottie.asset(AppImageAsset.loading,
                          width: 250, height: 250))
                  : Container(
                    color: AppColor.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      child: Form(
                        key: controller.formstate,
                        child: ListView(
                          children: [
                            const LogoAuth(),
                            const SizedBox(height: 30),
                            const cstmTextchesir(text: 'Welecom Back'),
                            const SizedBox(height: 10),
                            const cstmTextBodyAuth(text:" Sign In With your Email And  Password"),
                            const SizedBox(height: 20),
                            CustomTextFromFieldauth(
                              valid: (val) {
                                return ValidInput(val!, 5, 100, 'email');
                              },
                              mycontroller: controller.email,
                              hinttext: 'Enter Your Email',
                              labeltext: ' Email',
                              iconData: Icons.email,
                              // mycontroller: mycontroller
                            ),
                            SizedBox(height: 15,),
                            GetBuilder<LogincontrollerImp>(
                              builder: (controller) => CustomTextFromFieldauth(
                                ObscureText: controller.isshowpassword,
                                valid: (val) {
                                  return ValidInput(val!, 5, 100, 'password');
                                },
                                mycontroller: controller.password,
                                hinttext: 'Enter Your Password',
                                labeltext: ' Password',
                                iconData: Icons.remove_red_eye,
                                // ignore: body_might_complete_normally_nullable
                                onTapIcon: () {
                                  controller.showPassword();
                                },
                              ),
                            ),
                         

                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: InkWell(
                                onTap: () {
                                  controller.goToForgetPassword();
                                },
                                child: Text(
                                  'forget Password',
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                               const SizedBox(
                              height: 15,
                            ),
                            cstmBottomchesir(
                              text: 'Sign In',
                              onPressed: () {
                                controller.login(context);
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            textsignuplogin(
                              textone: "don't have an account?",
                              texttwo: "Sing Up",
                              onTap: () {
                                controller.goToSingUp();
                              },
                            ),
                          ],
                        ),
                      )),
            ));
  }
}
