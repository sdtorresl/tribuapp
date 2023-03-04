import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _prefs;
  static final UserPreferences _instance = UserPreferences._internal();
  static const bool _onBoardingViewed = false;
  static const bool _isPremium = false;
  static const int _selectedPoster = 1;
  static const String? _token = null;

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get onBoardingViewed {
    // return _prefs.getBool('onboardingViewed');
    return _prefs.getBool('onboardingViewed') ?? _onBoardingViewed;
  }

  set onboardingViewed(bool value) {
    _prefs.setBool('onboardingViewed', value);
  }

  set token(String? token) {
    if (token != null) _prefs.setString('token', token);
  }

  String? get token => _prefs.getString('token');

  set posterVoted(bool voted) => _prefs.setBool('posterVoted', voted);

  bool get posterVoted => false;

  set selectedPoster(int selectedPoster) =>
      _prefs.setInt('selectedPoster', selectedPoster);

  int get selectedPoster => _prefs.getInt('selectedPoster') ?? _selectedPoster;

  set isPremium(bool isPremium) => _prefs.setBool('isPremium', isPremium);

  bool get isPremium => _prefs.getBool('isPremium') ?? _isPremium;
}
