/*import 'dart:io';

import 'package:app_manteni_correc/app/domain/repositories/connectivity_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository{
  final Connectivity _connectivity;
  ConnectivityRepositoryImpl(this._connectivity);

  @override
  Future<bool> get hasInternet async{
    final result = await _connectivity.checkConnectivity();
    if(result == ConnectivityResult.none){
      return false;
    }
    return _hasInternet();
    
  }

  Future<bool> _hasInternet() async{
    try{
      final list = await InternetAddress.lookup('google.com');
      return list.isNotEmpty && list.first.rawAddress.isNotEmpty;
    } catch(e){
      return false;
    }
  }
}*/