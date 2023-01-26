import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_repository/shared_repo.dart';

class CsSharedPreferences {
  static SharedPreferences? _pref;

  static Future<SharedPreferences> _init() async {
    _pref ??= await SharedPreferences.getInstance();
    return _pref!;
  }

  static Future setUserInfo(UserDetails? userInfo) async {
    var pref = await _init();

    return await Future.wait([
      pref.setString(_userName, userInfo?.userName ?? ""),
      pref.setString(_userProfilePic, userInfo?.image ?? ""),
      pref.setString(_userEmail, userInfo?.email ?? ""),
      pref.setString(_userId, userInfo?.userId ?? ""),
      pref.setInt(_mySemester, userInfo?.mySemester ?? -1),
    ]);
  }

  static void saveMySem(int mySemester) async {
    var pref = await _init();
    pref.setInt(_mySemester, mySemester);
  }

  static Future<UserDetails> getUserInfo() async {
    var pref = await _init();
    return UserDetails(
      userName: pref.getString(_userName) ?? "",
      image: pref.getString(_userProfilePic) ?? "",
      email: pref.getString(_userEmail) ?? "",
      userId: pref.getString(_userId) ?? "",
      mySemester: pref.getInt(_mySemester) ?? -1,
    );
  }

  static const String _userId = "userId";
  static const String _userName = "userName";
  static const String _userEmail = "userEmail";
  static const String _userProfilePic = "userProfilePic";
  static const String _mySemester = "semester";
}
