import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/cart_cubit.dart';
import 'package:frontend/cubit/shop_cubit.dart';
import 'package:frontend/pages/logic/logic_main.dart';

class MainLoad extends StatelessWidget {
  const MainLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ShopCubit()),
        BlocProvider(create: (BuildContext context) => CartCubit())
      ],
      child: const LogicMain(),
    );

  }
} 
