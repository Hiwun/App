import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/features/auth/auth.dart';

class AuthApproveCodeScreen extends StatefulWidget{
  const AuthApproveCodeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AuthApproveCodeScreenState();
}

class _AuthApproveCodeScreenState extends State<AuthApproveCodeScreen>{

  final TextEditingController _pinController = TextEditingController();

  // void _printCode() {
  //   String code = _pinController.text;
  //   print("Введённый код: $code");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Подтверждение"))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder(
              bloc: getIt<AuthBloc>(),
              builder: (context, state) {
                if(state is AuthCheckCodeFailureState){
                  return Text('Неверный код', style: TextStyle(color: Colors.redAccent));
                }
                return SizedBox();
              },
            ),
            PinCodeTextField(
              appContext: context,
              controller: _pinController,
              length: 6,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onCompleted: (value) {
                final bloc = getIt<AuthBloc>();
                final state = bloc.state;
                if(state is AuthLoginPhoneApproveState){
                  bloc.add(CodeAuthRequestedEvent(int.parse(value), state.userGUID));
                } else if (state is AuthCheckCodeFailureState){
                  bloc.add(CodeAuthRequestedEvent(int.parse(value), state.userGUID));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Ошибка в процессе обработки кода")
                  ));
                }
              },
            ),
          ],
        ),
      )
    );
  }
}