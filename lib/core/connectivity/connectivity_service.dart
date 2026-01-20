import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityService{
  Future<bool> thereIsConnectivity();
}

class ConnectivityServiceImpl implements ConnectivityService {
  @override
  Future<bool> thereIsConnectivity()async{
    final result = await Connectivity().checkConnectivity();
    return result.any(
      (r) => r == ConnectivityResult.wifi
        || r == ConnectivityResult.mobile
    );
  }
}