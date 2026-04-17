import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/features/auth/auth.dart';
import 'package:tennisapp/modules/main/main.dart';
import 'package:tennisapp/storage/storage.dart';

class IntermediateAuthGate extends StatelessWidget{
  const IntermediateAuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = getIt<AuthBloc>();
    final userStorage = getIt<UserStorage>();
    final user = userStorage.user;
    //final mode = user != null && (user.roles.contains("Master") || user.roles.contains("Court") || user.roles.contains("Club")) ? "CRM" : "CLIENT";
    final mode = "CLIENT";
    return BlocBuilder(
      bloc: authBloc,
      builder: (context, state){
        if(state is AuthAuthenticatedState){
          if(mode == "CRM"){
            return CrmMainScreen();
          } else if (mode == "CLIENT"){
            return ClientMainScreen();
          }
        }

        return SizedBox();
      },
    );
  }
}