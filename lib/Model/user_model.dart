class UsersPageData{
 List<Users>? users;
 dynamic? page;
 dynamic? perPage;
 dynamic? total;
 dynamic? totalPage;

 UsersPageData({
   this.users,
   this.page,
   this.perPage,
   this.total,
   this.totalPage
});

 UsersPageData.fromJson(Map<String, dynamic>json){
   if (json['data'] != null) {
     users = <Users>[];
     json['data'].forEach((v) {
       users!.add(new Users.fromJson(v));
     });
   }
   page=json["page"];
   perPage=json["per_page"];
   total=json["total"];
   totalPage=json["total_pages"];
 }
}

class Users{
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  Users({
    this.email,
    this.firstName,
    this.lastName,
    this.avatar
});

  Users.fromJson(Map<String, dynamic>json){
    email= json["email"];
    firstName= json["first_name"];
    lastName=json["last_name"];
    avatar=json["avatar"];

  }
}
