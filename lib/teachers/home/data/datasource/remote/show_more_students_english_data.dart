import 'package:monami/core/class/curd.dart';
import 'package:monami/app_link.dart';


class ShowMoreStudentsEnglishData {
  Crud crud;
  ShowMoreStudentsEnglishData(this.crud);

  getData(String userid) async {
    var response = await crud.postData(AppLink.VpLangEnusres, {
      // "id" : id.toString() ,
         "id" :  userid ,
    });
   return response.fold((l) => l, (r) => r) ;
  }
}