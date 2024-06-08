import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/students/abonnement/controller/abonnement_controller.dart';
import 'package:monami/core/constant/app_color.dart';

import 'package:monami/teachers/auth/data/model/teachers_model.dart';

class SelectGroupProfAbonnement extends GetView<AbonnementControllerImp> {
  final bool isSelectable;

  const SelectGroupProfAbonnement({Key? key, this.isSelectable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Center(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.listProfs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              var prof = profModel.fromJson(controller.listProfs[i]);
              return InkWell(
                onTap: () {
                  if (!isSelectable) return;
                  if (controller.selectedProf.contains(prof.profId)) {
                    controller.unselectProf(prof.profId!);
                  } else {
                    controller.selectProf(prof.profId!);
                  }
                },
                child: SelectGroupItemProfAbonnement(
                  profmodel: prof,
                ),
              );
            }),
      ),
    );
  }
}

class SelectGroupItemProfAbonnement extends GetView<AbonnementControllerImp> {
  final profModel profmodel;

  const SelectGroupItemProfAbonnement({
    super.key,
    required this.profmodel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: 80,
        height: 100,
        child: Stack(
          children: [
            Container(
              width: 70,
              height: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'images/${profmodel.profImage}',
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    bottomLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0)),
                border:
                    Border.all(width: 1, color: AppColor.primaryColormonami),
              ),
            ),
            Positioned(
                top: 65,
                width: 70,
                child: Container(
                  decoration: BoxDecoration(
                    color: controller.selectedProf.contains(profmodel.profId)
                        ? Colors.green
                        : AppColor.primaryColormonami,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                    ),
                    border: Border.all(
                        width: 1, color: AppColor.primaryColormonami),
                  ),
                  height: 18,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${profmodel.profName}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColor.black,
                            )),
                        // Container(
                        //     height: 12,
                        //     width: 12,
                        //     margin: EdgeInsets.only(right: 2),
                        //     decoration: BoxDecoration(
                        //         image: DecorationImage(
                        //             image: AssetImage("images/falg2.png"),
                        //             fit: BoxFit.cover),
                        //         borderRadius: BorderRadius.circular(40.0)))
                      ],
                    ),
                  ),
                )),
            controller.selectedProf.contains(profmodel.profId)
                ? Positioned(
                    top: 65,
                    right: 12,
                    child: Icon(
                      Icons.check_circle_outline,
                      size: 16,
                      color: Colors.white,
                    ))
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
