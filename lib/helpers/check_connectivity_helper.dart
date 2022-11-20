import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnectivityHelper {
  factory CheckConnectivityHelper() {
    return _mainCheckConnectivityHelper;
  }

  CheckConnectivityHelper._internal();

  static final CheckConnectivityHelper _mainCheckConnectivityHelper =
      CheckConnectivityHelper._internal();

  Future<bool> checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}
