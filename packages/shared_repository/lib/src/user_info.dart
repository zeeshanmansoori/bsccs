class UserDetails{
  final String userName;
  final String image;
  final String email;
  final String userId;

  const UserDetails({
    required this.userName,
    required this.image,
    required this.email,
    required this.userId,
  });

  Map<String,dynamic> toFireStore(){
    return {
      "userName":userName,
      "image":image,
      "email":email,
      "userId":userId,

    };
  }

}