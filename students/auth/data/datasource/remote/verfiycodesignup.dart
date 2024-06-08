import 'package:monami/core/class/curd.dart';
import 'package:monami/app_link.dart';

class VerfiyCodeSignUpData {
  Crud crud;
  VerfiyCodeSignUpData(this.crud);

  postdata(String email ,String verfiycode) async {
    var response = await crud.postData(AppLink.verfiycodeSingUp, {
       "email" : email,
       "verifycode" :verfiycode ,
    });
   
   return response.fold((l) => l, (r) => r) ;
  }
}
