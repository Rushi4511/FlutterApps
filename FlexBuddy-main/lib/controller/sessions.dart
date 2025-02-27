
import 'package:shared_preferences/shared_preferences.dart';

class SessionData{
  static bool isLogin = false;
  static bool isFirstTime = true;
  static String emailId = "";

  static Future<void> storeSessionData(
    {required isLogin ,required String emailId, required bool isFirstTime,})async{
      SharedPreferences sharedPreferences = await
      SharedPreferences.getInstance();
      /// SET DATA
      sharedPreferences.setBool("isLogin", isLogin);
      sharedPreferences.setBool("isFirstTime", isFirstTime);
      sharedPreferences.setString("email", emailId);
      /// GET DATA
      await getSessionData();
    }
    static Future<void> getSessionData()async{
      SharedPreferences sharedPreferences = await
      SharedPreferences.getInstance();

      isLogin = sharedPreferences.getBool("isLogin") ?? false;
      isFirstTime = sharedPreferences.getBool("isFirstTime") ??true;
      emailId = sharedPreferences.getString("email") ??"";
    }
}

 