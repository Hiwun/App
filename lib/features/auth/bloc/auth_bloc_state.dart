

import 'package:uuid/uuid.dart';

abstract class AuthState{}

class AuthInitialState extends AuthState{}
class AuthLoadingState extends AuthState{}
class AuthLoginPhoneApproveState extends AuthState{
  final UuidValue? userGUID;
  AuthLoginPhoneApproveState(this.userGUID);
}
class AuthAuthenticatedState extends AuthState{}
class AuthLoginFailureState extends AuthState{}
class AuthCheckCodeFailureState extends AuthState{
  final UuidValue? userGUID;
  AuthCheckCodeFailureState(this.userGUID);
}