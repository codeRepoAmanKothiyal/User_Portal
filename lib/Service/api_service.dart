import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:user_portal/Model/user_model.dart';


class Api {
  static const _UserListUrl = "https://reqres.in/api/users?page=";

  Future<UsersPageData?> getUserData(int pageNo) async {
    final response = await http.get(Uri.parse(_UserListUrl + "$pageNo"));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      print(decodedData);
      return UsersPageData.fromJson(decodedData);
    } else {
      throw Exception("Something happened");
    }
  }

  static const _registerUrl = "https://reqres.in/api/register";

  void register(String email, String password) async {
    try{
      Object body = {
        "email": email,
        "password":password
      };
      Response response= await http.post(
          Uri.parse(_registerUrl),body: body,
        // headers: {
        //     "Content-Type" : "application/json"
        // }
      );
      if(response.statusCode== 200){
        print(" Acount created successfully ${response.body}");
      }else{
        print ("faild");
      }
    }catch(e){
      print(e.toString());
    }
  }


  static const _loginUrl = "https://reqres.in/api/login";

  void login(String email, String password) async {
    try{
      Object body = {
        "email": email,
        "password":password
      };
      Response response= await http.post(
        Uri.parse(_loginUrl),body: body,);
      if(response.statusCode== 200){
        print(" Acount created successfully ${response.body}");
      }else{
        print ("faild");
      }
    }catch(e){
      print(e.toString());
    }
  }

  static const _creatUrl = "https://reqres.in/api/users";

  void create(String name, String job) async {
    try{
      Object body = {
        "name": name,
        "job":job
      };
      Response response= await http.post(
        Uri.parse(_creatUrl),body: body,);
      if(response.statusCode== 201){
        print(" Acount created successfully ${response.body}");
      }else{
        print ("faild");
      }
    }catch(e){
      print(e.toString());
    }
  }
}
