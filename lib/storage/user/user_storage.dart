import 'package:tennisapp/models/model.dart';

class UserStorage {
  User? _currentUser;
  User? get user => _currentUser;

  void update(User user){
    _currentUser = user;
  }
  void clear(){
    _currentUser = null;
  }
}