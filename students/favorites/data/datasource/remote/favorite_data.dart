import 'package:monami/core/class/curd.dart';
import 'package:monami/app_link.dart';

class FavoriteData {
  Crud crud;
  FavoriteData(this.crud);
  addFavorite( usersid,  profid) async {
    var response = await crud.postData(
        AppLink.AddFavorite, {"usersid": usersid, "profid": profid});
    return response.fold((l) => l, (r) => r);
  }

  removeFavorite( usersid,  profid) async {
    var response = await crud.postData(
        AppLink.RemoveFavorite, {"usersid": usersid, "profid": profid});
    return response.fold((l) => l, (r) => r);
  }

  Deletfromfavorite( id ) async {
    var response = await crud.postData(AppLink.deletfromfavorite,{"id" : id});
   return response.fold((l) => l, (r) => r) ;
  }
}