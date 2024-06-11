import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:google_fonts/google_fonts.dart';


class TermsOfStudent extends StatefulWidget {
  const TermsOfStudent({super.key});

  @override
  State<TermsOfStudent> createState() => _TermsOfStudentState();
}

class _TermsOfStudentState extends State<TermsOfStudent> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        title: Text(
          "35".tr,
          style: TextStyle(
            color: AppColor.buttommonami,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
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
     body : Container(
        margin: EdgeInsets.only(top: 20 , left: 15 , right: 10 ,bottom: 10),
        color: AppColor.white,
        child: ListView(children: [
          
         Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "109".tr,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "110".tr,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "111".tr,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '112'.tr,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "113".tr,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "114".tr,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  '115'.tr,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "116".tr,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "117".tr,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "118".tr,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "119".tr,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "120".tr,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
    
   
                // Container(
                //   width: double.infinity,
                //   height: 40,
                //   child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         CustomButton2(
                //           text: "154".tr,
                //           onPressed: () {
                //              exit(0);
                //           },
                //         ),
                //         CustomButton1(
                //           text: "147".tr,
                //           onPressed: () {
                //             Get.toNamed(AppRoute.onBoarding);
                //           },
                //         )
                //       ]),
                // )
              ],
            ),
          
        ]),
      ),
    );
  }
}

     
    