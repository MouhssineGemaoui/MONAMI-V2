import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/students/abonnement/controller/abonnement_controller.dart';

class SelectGroupLangueAbonnement extends GetView<AbonnementControllerImp> {
  final bool isSelectable;

  const SelectGroupLangueAbonnement({this.isSelectable = true});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, i) {
          return Padding(padding: EdgeInsets.all(16));
        },
        scrollDirection: Axis.horizontal,
        itemCount: controller.listLang.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              if (!isSelectable) return;
              if (controller.selectedLang
                  .contains(controller.listLang.keys.elementAt(i))) {
                controller.unselectLang(controller.listLang.keys.elementAt(i));
              } else {
                controller.selectLang(controller.listLang.keys.elementAt(i));
              }
            },
            child: SelectGroupItemLangueAbonnement(
              value: controller.listLang.keys.elementAt(i),
            ),
          );
        });
  }
}

class SelectGroupItemLangueAbonnement extends GetView<AbonnementControllerImp> {
  final String value;

  SelectGroupItemLangueAbonnement({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 70,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: Container(
                color: Colors.green,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(9999))),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(
                        controller.selectedLang.contains(value) ? 99 : 0)),
                child: CountryFlag.fromCountryCode(
                  value,
                  width: 76,
                  height: 56,
                ),
              ),
            ),
            controller.selectedLang.contains(value)
                ? Positioned(
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 16,
                    ),
                    bottom: 2,
                    right: 2,
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
