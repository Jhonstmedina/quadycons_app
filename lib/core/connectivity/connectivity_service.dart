import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:quadycons/domain/connectivity/connectivity_service.dart';

class ConnectivityServiceImpl implements ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  @override
  Future<bool> thereIsConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    return result.any(
      (r) => r == ConnectivityResult.wifi
        || r == ConnectivityResult.mobile
    );
  }

  /*
  * Permite mostrar en tiempo real el estado de conectividad
  * - wifi, datos: conectado
  * - ninguno: sin conexión
  */
  @override
  Stream<bool> get connectivityStream {
    return _connectivity.onConnectivityChanged.map((results) {
      return results.any(
        (r) => r == ConnectivityResult.wifi
          || r == ConnectivityResult.mobile
      );
    });
  }
  
}