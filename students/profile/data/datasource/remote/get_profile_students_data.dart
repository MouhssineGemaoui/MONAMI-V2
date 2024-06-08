import 'package:monami/core/class/curd.dart';
import 'package:monami/app_link.dart';

class GetProfileStudentsData {
  Crud crud;
  GetProfileStudentsData(this.crud);

  getData( id,  ) async {
    var response = await crud.postData(AppLink.viewdatausers, {"id" : id });
   return response.fold((l) => l, (r) => r) ;
  }
}
