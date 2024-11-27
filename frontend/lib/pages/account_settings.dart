import 'package:flutter/material.dart';
import 'package:frontend/pages/account_settings/payment_info.dart';
import 'package:frontend/pages/account_settings/shipping_info.dart';
import 'package:frontend/pages/main_load.dart';
import 'package:frontend/pages/main_screen.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double paddingHorizontal = screenWidth * 0.04;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MainLoad()));
          }
        ),
        title: Text("Account & Settings"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            _buildListItem(
              context,
              icon: Icons.local_shipping_outlined,
              title: "Shipping address",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ShippingInfo()));
              },
            ),
            _buildListItem(
              context,
              icon: Icons.payment_outlined,
              title: "Payment info",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentInfo()));
              },
            ),
            _buildListItem(
              context,
              icon: Icons.delete_outline,
              title: "Delete account",
              onTap: () {
                _showDeleteConfirmationDialog(context);
              },
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "App settings",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            _buildSwitchItem(
              context,
              icon: Icons.notifications_active_outlined,
              title: "Enable push notifications",
              onChanged: (value) {
                // tu trzeba zapytac o uprawnienia do notyfikacji
              },
            ),
            _buildSwitchItem(
              context,
              icon: Icons.location_on_outlined,
              title: "Enable location services",
              onChanged: (value) {
                //  tu trzeba zapytac o uprawnienia do lokalizacji
              },
            ),
          ],
        ),
      ),
    );
  }


  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text('Are you sure you want to delete your account?'),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                // tu trzeba usunac konto
              },
            ),
          ],
        );
      },
    );
  }
  
  Widget _buildListItem(BuildContext context,
      {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      tileColor: Colors.white,
    );
  }

  Widget _buildSwitchItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required ValueChanged<bool> onChanged,
  }) {
    bool switchValue = false;
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return ListTile(
          leading: Icon(icon, color: Colors.blue),
          title: Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          trailing: Switch.adaptive(
            value: switchValue,
            onChanged: (value) {
              setState(() => switchValue = value);
              onChanged(value);
            },
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          tileColor: Colors.white,
        );
      },
    );
  }
}
