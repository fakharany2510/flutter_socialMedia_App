class BrowiseUserModel{
  String? userId;
  String? name;
  String? email;
  String? phone;
  late String image;
  String? bio;
  late String cover;
  bool? isEmailVrefied;

  BrowiseUserModel({
    this.userId,
    this.email,
    this.name,
    this.phone,
    required this.image,
    this.bio,
    required this.cover,
    this.isEmailVrefied,
});
  BrowiseUserModel.fromJson(Map<String , dynamic> json){
    userId=json['userId'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    bio=json['bio'];
    cover=json['cover'];
    isEmailVrefied=json['isEmailVrefied'];
      }

  Map <String , dynamic> toMap(){
    return{
    'userId':userId,
    'name':name,
    'email':email,
    'phone':phone,
    'image':image,
    'bio':bio,
    'cover':cover,
    'isEmailVrefied':isEmailVrefied,
    };
}
}