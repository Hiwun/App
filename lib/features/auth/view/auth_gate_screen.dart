

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/features/auth/auth.dart';
import 'package:tennisapp/features/auth/bloc/auth_bloc_state.dart';
import 'package:tennisapp/features/auth/view/auth_login_screen.dart';
import 'package:tennisapp/storage/storage.dart';

import '../bloc/auth_bloc.dart';

class AuthGate extends StatelessWidget{
  final Widget child;
  const AuthGate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if(state is AuthInitialState || state is AuthLoginFailureState){
          return LoginScreen();
        } else if(state is AuthLoginPhoneApproveState || state is AuthCheckCodeFailureState) {
          return AuthApproveCodeScreen();
        } else if(state is AuthLoadingState){
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if(state is AuthAuthenticatedState){
          return child;
        } else {
          return Scaffold(
            body: Center(child: Text("Что то пошло не так"))
          );
        }
      },
    );
  }
  
  
}