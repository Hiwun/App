
import 'package:uuid/uuid.dart';

abstract class AuthEvent {}

class LoginRequested extends AuthEvent{
  final String username;
  final String password;
  LoginRequested(this.username, this.password);
}
class LoginPhoneRequested extends AuthEvent{
  final String phone;
  LoginPhoneRequested(this.phone);
}
class CodeAuthRequestedEvent extends AuthEvent{
  final UuidValue? userGUID;
  final int code;
  CodeAuthRequestedEvent(this.code, this.userGUID);
}
class LogoutRequested extends AuthEvent{}