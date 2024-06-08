import 'package:monami/core/class/curd.dart';
import 'package:monami/app_link.dart';


class ShowMoreStudentsFrenchData {
  Crud crud;
  ShowMoreStudentsFrenchData(this.crud);

  getData(String userid) async {
    var response = await crud.postData(AppLink.VpLangFrusres, {
      // "id" : id.toString() ,
         "id" :  userid ,
    });
   return response.fold((l) => l, (r) => r) ;
  }
}