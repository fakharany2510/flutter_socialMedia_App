class BrowisePostModel{
  String? userId;
  String? name;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  BrowisePostModel({
    this.userId,
    this.name,
    this.image,
    this.dateTime,
    this.text,
    this.postImage
  });
  BrowisePostModel.fromJson(Map<String , dynamic> json){
    userId=json['userId'];
    name=json['name'];
    image=json['image'];
    dateTime=json['dateTime'];
    text=json['text'];
    postImage=json['postImage'];
  }

  Map <String , dynamic> toMap(){
    return{
      'userId':userId,
      'name':name,
      'image':image,
      'dateTime':dateTime,
      'text':text,
      'postImage':postImage,
    };
  }
}