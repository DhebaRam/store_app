import 'package:get_storage/get_storage.dart';

LocalStorage appAuth = LocalStorage();

class LocalStorage {
  static final LocalStorage localStorageSharedInstance =
  LocalStorage._internal();

  factory LocalStorage() => localStorageSharedInstance;

  LocalStorage._internal();

  String token = "token",
      login = 'login',
      themeMode = 'themeMode',
      userId = "userId",
      gander = "gender",
      userName = "userName",
      userGender = "userGender",
      name = "name",
      languages = "language",
      apiLanguages = "lang",
      starTheme = 'blue',
      email = "email",
      mobile = "mobile",
      isLocalAuth = "isLocalAuth",
      emirateId = "emirateId",
      role = "role",
      emirateIdExpire = "emirateIdExpire",
      fcmToken = "fcm_token",
      userImage = "userImage",
      studentId = "studentId",
      registrationStepId = "registrationStepId",
      voipToken = "voip_token",
      isCall = "isCall";

  setValue(String key, String value) async {
    GetStorage localStorage = GetStorage();
    await localStorage.write(key, value);
  }

  getValue(String key) async {
    GetStorage localStorage = GetStorage();
    var value = localStorage.read(key);
    return value ?? '';
  }

  setBoolValue(String key, bool value) async {
    GetStorage localStorage = GetStorage();
    await localStorage.write(key, value);
  }

  getBoolValue(String key) async {
    GetStorage localStorage = GetStorage();
    var value = await localStorage.read(key) ?? false;
    return value ?? false;
  }

  clearStorage() async {
    GetStorage localStorage = GetStorage();
    // var value = await localStorage.read(userId);
    await localStorage.erase();
    // await localStorage.write(userId, value);
  }
}