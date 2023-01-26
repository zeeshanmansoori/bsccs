class UserDetails{
  final String userName;
  final String image;
  final String email;
  final String userId;
  final int mySemester;

  const UserDetails({
    required this.userName,
    required this.image,
    required this.email,
    required this.userId,
    required this.mySemester,
  });

  Map<String,dynamic> toFireStore(){
    return {
      "userName":userName,
      "image":image,
      "email":email,
      "userId":userId,
      "mySemester":mySemester,

    };
  }

  UserDetails copyWith({
    String? userName,
    String? image,
    String? email,
    String? userId,
    int? mySemester,
  }) {
    return UserDetails(
      userName: userName ?? this.userName,
      image: image ?? this.image,
      email: email ?? this.email,
      userId: userId ?? this.userId,
      mySemester: mySemester ?? this.mySemester,
    );
  }
}