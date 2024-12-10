import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/cart_cubit.dart';
import 'package:frontend/main.dart';
import 'package:frontend/pages/account_settings.dart';
import 'package:frontend/pages/logic/cart_logic.dart';
import 'package:frontend/pages/logic/secure_storage_manager.dart';
import 'package:frontend/pages/main_load.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _storageManager = SecureStorageManager.instance;
  String name = 'Brak nazwy';

  @override
  void initState() {
    super.initState();
    test();
  }

  void test() async {
    name = await _storageManager.read('name') ?? '';
    setState(() {
      name = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          leading: Container(
            alignment: Alignment.center,
          ),
        ),
        body: Column(
          children: [
            Text(
              name,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.lightBlue,
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  width: screenWidth * 0.55,
                  height: screenHeight * 0.06,
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainLoad(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.home,
                            color: Colors.black,
                            size: 40,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Home Page',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  width: screenWidth * 0.55,
                  height: screenHeight * 0.06,
                  child: OutlinedButton(
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => CartCubit(),
                                child: const CartLogic(),
                              ),
                            ),
                          ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.black,
                            size: 40,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Cart',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  width: screenWidth * 0.55,
                  height: screenHeight * 0.06,
                  child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.fire_truck,
                            color: Colors.black,
                            size: 40,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Orders',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  width: screenWidth * 0.55,
                  height: screenHeight * 0.06,
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AccountSettings(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.notifications,
                            color: Colors.black,
                            size: 40,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Notifications',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: screenHeight * 0.001,
                width: screenWidth,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MyApp()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout),
                  iconSize: 50,
                ),
                const Text(
                  'Sign Out',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
