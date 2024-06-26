import 'package:monami/core/class/curd.dart';
import 'package:monami/app_link.dart';

class SignUpData {
  Crud crud;
  SignUpData(this.crud);

  postdata( String name, String password, String email ,String age, String cuntry) async {
    var response = await crud.postData(AppLink.singUp, {
       "name" : name,
       "password" : password,
       "email" : email,
       "age" : age,
       "cuntry" : cuntry,
    });
   
   return response.fold((l) => l, (r) => r) ;
  }
}
