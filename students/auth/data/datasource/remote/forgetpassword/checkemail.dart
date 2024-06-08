import 'package:monami/core/class/curd.dart';
import 'package:monami/app_link.dart';

class CheckEmailForgetPasswordData {
  Crud crud;
  CheckEmailForgetPasswordData(this.crud);

  postdata( String email ,) async {
    var response = await crud.postData(AppLink.checkemailforgetpassword, {
       "email" : email,
    });
   
   return response.fold((l) => l, (r) => r) ;
  }
}
