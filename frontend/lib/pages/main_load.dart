import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/shop_cubit.dart';
import 'package:frontend/pages/logic/logic_main.dart';

class MainLoad extends StatelessWidget {
  const MainLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: const LogicMain(),
    );
  }
}
