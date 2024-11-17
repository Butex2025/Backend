import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/cart_cubit.dart';
import 'package:frontend/pages/loading.dart';

class LogicMain extends StatelessWidget {
  const LogicMain({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        
        return const LoadingScreen();
      },
    );
    ;
  }
}
