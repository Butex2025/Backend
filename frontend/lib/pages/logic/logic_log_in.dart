import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/access_cubit.dart';
import 'package:frontend/pages/loading.dart';
import 'package:frontend/pages/main_load.dart';
import 'package:frontend/pages/sign_in.dart';
import 'package:frontend/pages/sign_up.dart';
import 'package:frontend/pages/splash.dart';

class LogicLogIn extends StatelessWidget {
  const LogicLogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessCubit, AccessState>(
      builder: (context, state) {
        if (state is AccessInit) {
          return const LoadingScreen();
        } else if (state is Splash) {
          return const SplashPage();
        } else if (state is Register) {
          return const SignUp();
        } else if (state is LogIn) {
          return const SignIn();
        } else if (state is UserIn) {
          return const MainLoad();
        }
        return const SplashPage();
      },
    );
  }
}
