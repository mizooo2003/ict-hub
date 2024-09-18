class UserModel {
  String? image;
  String? name;
  String? titlejop;
  int? age;
  
  
  UserModel({
    this.image,
    this.name,
    this.titlejop,
    this.age,
});


static List<UserModel> userModelList = [
  UserModel(image: 'assets/image/1.jpg',name: "neymar", titlejop:"footballer",age:34),
  UserModel(image:'assets/image/2.jpg' ,name: "ronaldo", titlejop:"footballer",age:39),
  UserModel(image: 'assets/image/3.jpg',name: "ronaldinho", titlejop:"footballer",age:45),
];
}