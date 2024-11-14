import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/access_cubit.dart';
import 'package:frontend/pages/account_settings.dart';
import 'package:frontend/pages/account_settings/notifications.dart';
import 'package:frontend/pages/account_settings/payment_info.dart';
import 'package:frontend/pages/account_settings/shipping_info.dart';
import 'package:frontend/pages/logic.dart';
import 'package:frontend/pages/main_screen.dart';
import 'package:frontend/pages/sign_in.dart';
import 'package:frontend/pages/sign_up.dart';
import 'package:frontend/pages/splash.dart';
import 'package:frontend/pages/user_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Butex',
      home: BlocProvider(
        create: (context) => AccessCubit(),
        child: const LogicLogIn(),
      ),
    );
  }
}



// MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Butex',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         initialRoute: '/',
//         // https://docs.flutter.dev/cookbook/navigation/named-routes
//         routes: {
//           '/': (context) => SplashPage(),
//           '/signin': (context) => SignIn(),
//           '/signup': (context) => SignUp(),
//           '/main': (context) => MainScreen(),
//           '/user_page': (context) => UserPage(),
//           '/account_settings': (context) => AccountSettings(),

//           // account settings pages
//           '/account_settings/notificationSettings': (context) =>
//               NotificationSettings(),
//           '/account_settings/shippingInfo': (context) => ShippingInfo(),
//           '/account_settings/paymentInfo': (context) => PaymentInfo(),
//           // '/account_settings/deleteAccount': (context) => DeleteAccount(),
//         },
//       ),