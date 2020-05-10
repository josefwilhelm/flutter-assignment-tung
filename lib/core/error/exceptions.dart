class RemoteException implements Exception {
  int code;
  String message;

  RemoteException({this.code, this.message});
}

const NETWORK_ERROR_MESSAGE =
    'Cannot connect to server. Check your internet connection';
