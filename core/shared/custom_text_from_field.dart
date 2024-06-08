import 'package:flutter/material.dart';
import 'package:monami/core/constant/app_color.dart';

class CustomTextFromFieldSmall extends StatelessWidget {
  final String hinttext;
  final String labeltext;
  final IconData iconData;
  final TextEditingController mycontroller;
  // final String? Function(String?) valid;
  final String? Function()? onTapIcon;
  final bool? ObscureText;

  const CustomTextFromFieldSmall(
      {super.key,
      required this.hinttext,
      required this.labeltext,
      required this.iconData,
      required this.mycontroller,
      // required this.valid,
      this.ObscureText,
      this.onTapIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(alignment: Alignment.topLeft, child: Text(labeltext)),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 35,
          width: MediaQuery.of(context).size.width * 0.4,
          // margin: const EdgeInsets.only(bottom: 21),
          // padding: const EdgeInsets.symmetric(horizontal: 10 ),
          child: TextFormField(
            // validator: valid,
            controller: mycontroller,
            obscureText:
                ObscureText == null || ObscureText == false ? false : true,
            decoration: InputDecoration(
                hintText: hinttext,
                hintStyle: TextStyle(fontSize: 12),
                floatingLabelBehavior: FloatingLabelBehavior.always,

                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
               
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
        ),
      ],
    );
  }
}


class CustomTextFromFieldMedium extends StatelessWidget {
  final String hinttext;
  final String labeltext;
  final IconData iconData;
  final TextEditingController mycontroller;
  // final String? Function(String?) valid;
  final String? Function()? onTapIcon;
  final bool? ObscureText;

  const CustomTextFromFieldMedium(
      {super.key,
      required this.hinttext,
      required this.labeltext,
      required this.iconData,
      required this.mycontroller,
      // required this.valid,
      this.ObscureText,
      this.onTapIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(alignment: Alignment.topLeft, child: Text(labeltext)),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 35,
            width: MediaQuery.of(context).size.width * 0.9,

            child: TextFormField(
              // validator: valid,
              controller: mycontroller,
              obscureText:
                  ObscureText == null || ObscureText == false ? false : true,
              decoration: InputDecoration(
                  hintText: hinttext,
                  hintStyle: TextStyle(fontSize: 12),
                  floatingLabelBehavior: FloatingLabelBehavior.always,

                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  // suffixIcon:
                  // InkWell(
                  //   child: Icon(iconData),
                  //   onTap: onTapIcon,
                  // ),
                  // label: Text(labeltext , style: TextStyle(color: AppColor.black, fontWeight: FontWeight.w700),),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
        ],
      ),
    );
  }
}



class CustomTextFromFieldLarg extends StatelessWidget {
  final String hinttext;
  final String labeltext;
  final IconData iconData;
  final TextEditingController mycontroller;
  final String? Function()? onTapIcon;
  final bool? ObscureText;
  const CustomTextFromFieldLarg(
      {super.key,
      required this.hinttext,
      required this.labeltext,
      required this.iconData,
      required this.mycontroller,
      this.ObscureText,
      this.onTapIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(alignment: Alignment.topLeft, child: Text(labeltext)),
          SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              maxLines: 5,
              controller: mycontroller,
              obscureText:
                  ObscureText == null || ObscureText == false ? false : true,
              decoration: InputDecoration(
                  hintText: hinttext,
                  hintStyle: TextStyle(fontSize: 12),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: const EdgeInsets.only(top: 10 ,  left: 10),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
        ],
      ),
    );
  }
}


class CustomTextFromFieldauth extends StatelessWidget {
  final String hinttext;
  final String labeltext;
  final IconData iconData;
  final TextEditingController mycontroller;
  final String? Function(String?) valid;
  final String? Function()? onTapIcon;
  final bool? ObscureText;

  const CustomTextFromFieldauth(
      {super.key,
      required this.hinttext,
      required this.labeltext,
      required this.iconData,
      required this.mycontroller,
      required this.valid,
      this.ObscureText,
      this.onTapIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(alignment: Alignment.topLeft, child: Text(labeltext)),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 35,
            width: MediaQuery.of(context).size.width * 0.9,

            child: TextFormField(
              validator: valid,
              controller: mycontroller,
              obscureText:
                  ObscureText == null || ObscureText == false ? false : true,
              decoration: InputDecoration(
                  hintText: hinttext,
                  hintStyle: TextStyle(fontSize: 12),
                  floatingLabelBehavior: FloatingLabelBehavior.always,

                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  // suffixIcon:
                  // InkWell(
                  //   child: Icon(iconData),
                  //   onTap: onTapIcon,
                  // ),
                  // label: Text(labeltext , style: TextStyle(color: AppColor.black, fontWeight: FontWeight.w700),),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
        ],
      ),
    );
  }
}