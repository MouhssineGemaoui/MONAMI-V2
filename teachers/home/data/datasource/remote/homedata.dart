import 'package:monami/core/class/curd.dart';
import 'package:monami/app_link.dart';

class HomePageTearchersData {
  Crud crud;
  HomePageTearchersData(this.crud);

  getData() async {
    var response = await crud.postData(AppLink.homepageprof, {});
   return response.fold((l) => l, (r) => r) ;
  }

}
