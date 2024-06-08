import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/students/abonnement/controller/abonnement_controller.dart';
import 'package:monami/core/constant/app_color.dart';

class SelectGroupMoisAbonnement extends GetView<AbonnementControllerImp> {
  const SelectGroupMoisAbonnement({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controller.listMois.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              controller.selectMois(controller.listMois[i]);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SelectGroupItemMoisAbonnement(
                value: controller.listMois[i],
              ),
            ),
          );
        });
  }
}

class SelectGroupItemMoisAbonnement extends GetView<AbonnementControllerImp> {
  final int value;

  const SelectGroupItemMoisAbonnement({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColor.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Opacity(
                    opacity: controller.selectedMois == value ? 1 : 0,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20,
                    ),
                  ),
                  Text(
                    "${value} mois",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ))
      ],
    );
  }
}
