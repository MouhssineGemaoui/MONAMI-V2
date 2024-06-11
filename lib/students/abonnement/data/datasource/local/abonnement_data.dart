import 'package:get/get.dart';
import 'package:monami/core/class/curd.dart';

class AbonnementData {
  Crud crud;

  AbonnementData(this.crud);

  getData() async {
    await 1.delay();

    final Map response = {
      'status': 'success',
      'data': [
        {'prof_id': 1, 'prof_name': 'Local', 'prof_image': 'prof-local.png'},
        {
          'prof_id': 2,
          'prof_name': 'Afrique',
          'prof_image': 'prof-afrique.png'
        },
        {'prof_id': 3, 'prof_name': 'EUR/USA', 'prof_image': 'prof-usa.png'},
      ]
    };

    return response;
  }
}
