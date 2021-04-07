import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_standard_app/blocs/auth/auth_cubit.dart';
import 'package:flutter_standard_app/routing/routes.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text('splash screen'),
            ElevatedButton(onPressed: () {
              Get.offAllNamed(AppRoutes.login);
                }, child: Text("Login"))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().checkAuth();
  }
}
