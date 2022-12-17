import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_repository/shared_repo.dart';

class CsSharedPreferences {
  static SharedPreferences? _pref;

  static Future<void> _init() async {
    _pref ??= await SharedPreferences.getInstance();
  }

  static Future setUserInfo(UserDetails? userInfo) async {
    await _init();
    return await Future.wait([
      _pref!.setString(_userName, userInfo?.userName ?? ""),
      _pref!.setString(_userProfilePic, userInfo?.image ?? ""),
      _pref!.setString(_userEmail, userInfo?.email ?? ""),
      _pref!.setString(_userId, userInfo?.userId ?? ""),
    ]);
  }

  static Future<UserDetails> getUserInfo() async {
    await _init();
    return UserDetails(
      userName: _pref!.getString(_userName) ?? "",
      image: _pref!.getString(_userProfilePic) ?? "",
      email: _pref!.getString(_userEmail) ?? "",
      userId: _pref!.getString(_userId) ?? "",
    );
  }

  static const String _userId = "userId";
  static const String _userName = "userName";
  static const String _userEmail = "userEmail";
  static const String _userProfilePic = "userProfilePic";
}
