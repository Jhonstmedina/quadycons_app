import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quadycons/domain/exceptions.dart';

abstract class StorageConnector{
  Future<void> setString(String string, String key);
  Future<String> getString(String key);
  Future<void> remove(String key);
  Future<void> removeAll();
}

class StorageConnectorImpl implements StorageConnector{

  static const normalStorageExceptionMessage = 'Ha ocurrido un error con los datos en el storage';

  final FlutterSecureStorage fss;
  StorageConnectorImpl({
    required this.fss
  });

  @override
  Future<void> setString(String string, String key)async{
    await _write(string, key);
  }

  @override
  Future<String> getString(String key)async{
    return await _read(key)??'';
  }

  @override
  Future<void> remove(String key)async{
    await _remove(key);
  }

  @override
  Future<void> removeAll()async{
    await executeStorageFunction(()async{
      await fss.deleteAll();
    });
  }

  Future<void> _write(String value, String key)async{
    await executeStorageFunction(
      ()async{
        await fss.write(key: key, value: value);
      }
    );
  }
  
  Future<String?> _read(String key)async{
    return await executeStorageFunction(
      ()async{
        return await fss.read(key: key);
      }
    );
  }

  Future<void> _remove(String key)async{
    await executeStorageFunction(
      ()async{
        await fss.delete(key: key);
      }
    );
  }
  
  Future executeStorageFunction(Function function)async{
    try{
      return await function();
    }on PlatformException {
      throw const GeneralException(message: normalStorageExceptionMessage);
    }catch(e){
      print('❌ STORAGE ERROR: $e');
      throw const GeneralException(message: 'Ha ocurrido un error inesperado');
    }
  }
}