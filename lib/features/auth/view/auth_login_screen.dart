

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/features/auth/auth.dart';


class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen>{
  final TextEditingController _phoneController = TextEditingController();

  void _onLoginPressed(){

    String rawPhone = '7${toNumericString(_phoneController.text)}';

    if (rawPhone.length == 11){
      context.read<AuthBloc>().add(LoginPhoneRequested(rawPhone));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Введите корректный номер телефона")
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Авторизация"))),
       body: Padding(
         padding: const EdgeInsets.all(16),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             BlocBuilder(
               bloc: getIt<AuthBloc>(),
               builder: (context, state) {
                 if(state is AuthLoginFailureState){
                   return Text('Ошибка', style: TextStyle(color: Colors.redAccent));
                 }
                 return SizedBox();
               },
             ),
             CupertinoTextField(
               controller: _phoneController,
               keyboardType: TextInputType.phone,
               inputFormatters: [
                 PhoneInputFormatter(
                   defaultCountryCode: 'RU',
                   allowEndlessPhone: false,
                 )
               ],
               prefix: const Padding(
                 padding: EdgeInsets.only(left: 12),
                 child: Text(
                   '+7 ',
                   style: TextStyle(
                     color: CupertinoColors.label,
                     fontSize: 17,
                   ),
                 ),
               ),
               padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
               placeholder: '(XXX) XXX-XX-XX',
               decoration: BoxDecoration(
                 border: Border.all(color: CupertinoColors.systemGrey, width: 0.5),
                 borderRadius: BorderRadius.circular(8),
               ),
             ),
             const SizedBox(height: 24),
             ElevatedButton(
               onPressed: _onLoginPressed,
               child: const Text('Войти')
             ),
           ],
         ),
       ),
    );
  }
}