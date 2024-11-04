import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(
            alignment: Alignment.center,
          ),
        ),
        body: Column(
          children: [
            const Text(
              'Twoje imie',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.lightBlue,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //moze jakis padding
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.home),
                  iconSize: 50,
                ),
                const Text(
                  'Home Page',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //moze jakis padding
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart),
                  iconSize: 50,
                ),
                const Text(
                  'My Cart',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //moze jakis padding
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.monitor_heart),
                  iconSize: 50,
                ),
                const Text(
                  'Favorite',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //moze jakis padding
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.fire_truck),
                  iconSize: 50,
                ),
                const Text(
                  'Orders',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //moze jakis padding
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications),
                  iconSize: 50,
                ),
                const Text(
                  'Notifications',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 1.0,
                width: 300.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //moze jakis padding
                IconButton(
                  onPressed: () {},
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
