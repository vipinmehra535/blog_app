import 'dart:io';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class ConnectionChecker {
  Future<bool> get isConnected;
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnection internetConnectionChecker;
  ConnectionCheckerImpl(this.internetConnectionChecker);
  @override
  Future<bool> get isConnected async {
    return await internetConnectionChecker.hasInternetAccess;
  }
}
