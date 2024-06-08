import 'package:monami/core/class/curd.dart';
import 'package:monami/app_link.dart';

class CustomerServicesStudentsData {
  Crud crud;
  CustomerServicesStudentsData(this.crud);
  postdata(String body, String usersid) async {
    var response =
        await crud.postData(AppLink.ServiceClients, {"body": body, "id": usersid});
    return response.fold((l) => l, (r) => r);
  }
}
