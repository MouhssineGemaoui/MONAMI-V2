import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/students/abonnement/controller/abonnement_controller.dart';

class SelectGroupDureeAbonnement extends GetView<AbonnementControllerImp> {
  final bool isSelectable;

  const SelectGroupDureeAbonnement({super.key, this.isSelectable=true});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: controller.listDureePrix.length,
        separatorBuilder: (context, i) => Padding(padding: EdgeInsets.all(4)),
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              if(!isSelectable) return;
              controller
                  .selectDuree(controller.listDureePrix.keys.elementAt(i));
            },
            child: SelectGroupItemDureeAbonnement(
              value: controller.listDureePrix.keys.elementAt(i),
            ),
          );
        });
  }
}

class SelectGroupItemDureeAbonnement extends GetView<AbonnementControllerImp> {
  final int value;

  SelectGroupItemDureeAbonnement({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            width: 1,
            color:
                value == controller.selectedDuree ? Colors.green : Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            value == controller.selectedDuree
                ? Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : Icon(Icons.access_time),
            Text(
              "${value} Min par jour",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Expanded(
              child: Text(
                textAlign: TextAlign.end,
                "Prix: ${controller.listDureePrix[value]} \$",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
