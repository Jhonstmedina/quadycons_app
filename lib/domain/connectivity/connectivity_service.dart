abstract class ConnectivityService{
  Future<bool> thereIsConnectivity();
  Stream<bool> get connectivityStream;
}