import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenStorage {
  FlutterSecureStorage storage;
  String? _accessToken;
  String? get token => _accessToken;

  TokenStorage(this.storage);

  Future<void> init() async {
    final accessToken = await storage.read(key: 'access_token');
    _accessToken = accessToken;
  }
  Future<bool> hasAccessTokenAndValid() async {
    final localToken = token;
    if(localToken == null){
      return false;
    }
    final isExpired = JwtDecoder.isExpired(localToken);
    return !isExpired;
  }
  Future<bool> isNull() async {
    final localToken = token;
    if(localToken == null){
      return true;
    }
    return false;
  }
  Future<bool> isExpired() async {
    final localToken = token;
    if(localToken == null){
      return true;
    }
    return JwtDecoder.isExpired(localToken);
  }

  void saveToken(String? token){
    _accessToken = token;
    storage.write(key: 'access_token', value: token);

  }

  void clear(){
    _accessToken = null;
    storage.delete(key: 'access_token');
  }
}