import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/pages/account_settings/payment_info.dart';
import 'package:frontend/pages/account_settings/shipping_info.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  bool _pushNotifications = true;
  bool _locationServices = false;

  @override
  void initState() {
    super.initState();
    _loadSwitchStates();
  }

  Future<void> _loadSwitchStates() async {
    final pushNotifications = await _storage.read(key: 'push_notifications') ?? 'false';
    final locationServices = await _storage.read(key: 'location_services') ?? 'false';

    setState(() {
      _pushNotifications = pushNotifications == 'true';
      _locationServices = locationServices == 'true';
    });
  }

  Future<void> _saveSwitchState(String key, bool value) async {
    await _storage.write(key: key, value: value.toString());
  }

  void _showNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _togglePushNotifications(bool value) {
    setState(() {
      _pushNotifications = value;
    });
    _saveSwitchState('push_notifications', value);

    final message = value ? 'Push notifications enabled' : 'Push notifications disabled';
    _showNotification(context, message);
  }

  void _toggleLocationServices(bool value) {
    setState(() {
      _locationServices = value;
    });
    _saveSwitchState('location_services', value);

    final message = value ? 'Location services enabled' : 'Location services disabled';
    _showNotification(context, message);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double paddingHorizontal = screenWidth * 0.04;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Account & Settings"),
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const ShippingInfo()));
              },
            ),
            _buildListItem(
              context,
              icon: Icons.payment_outlined,
              title: "Payment info",
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const PaymentInfo()));
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
              value: _pushNotifications,
              onChanged: _togglePushNotifications,
            ),
            _buildSwitchItem(
              context,
              icon: Icons.location_on_outlined,
              title: "Enable location services",
              value: _locationServices,
              onChanged: _toggleLocationServices,
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
          title: const Text('Delete Account'),
          content: const Text('Are you sure you want to delete your account?'),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
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
        style: const TextStyle(fontSize: 16),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      tileColor: Colors.white,
    );
  }

  Widget _buildSwitchItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      tileColor: Colors.white,
    );
  }
}
