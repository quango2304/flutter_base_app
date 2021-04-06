import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_standard_app/blocs/auth/auth_cubit.dart';
import 'package:flutter_standard_app/repositories/auth_repository.dart';
import 'package:flutter_standard_app/screens/login_screen/login_cubit/login_cubit.dart';
import 'package:flutter_standard_app/utils/locale_text.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) {
        final authRepo = context.read<AuthRepository>();
        return LoginCubit(authRepository: authRepo);
      },
      child: LoginScreen._());

  LoginScreen._();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginCubit get loginCubit => context.read<LoginCubit>();

  void onPressLogin() async {
    final user = await loginCubit.logIn();
    if(user != null) {
      context.read<AuthCubit>().loggedIn(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: onPressLogin,
          child: Text(LocaleText.pressToLogin.tr()),
        ),
      ),
    );
  }
}
