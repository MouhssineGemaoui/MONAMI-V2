import 'package:flutter/material.dart';
import 'package:monami/core/constant/app_color.dart';

class MonAcc extends StatefulWidget {
  MonAcc({super.key});

  @override
  State<MonAcc> createState() => _MonAccState();
}

class _MonAccState extends State<MonAcc> {
  @override
  Widget build(BuildContext context) {
    return 
    
    
     Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
                    width: 350,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage("images/monacc.png"),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                      border: Border.all(
                          width: 1, color: AppColor.primaryColormonami),
                    ));
  
  }
}
