import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _secureStorage = const FlutterSecureStorage();
  String name = '';
  String email = '';
  String phone = '';
  String address = '';
  String paymentMethod = '';
  String shippingOption = 'Shipping';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      name = 'Loading...';
      email = 'Loading...';
      phone = 'Loading...';
      address = 'Loading...';
      paymentMethod = 'Loading...';
    });

    final fetchedStreet = await _secureStorage.read(key: 'street') ?? 'Empty';
    final fetchedBuildingNumber = await _secureStorage.read(key: 'building_number') ?? 'Empty';
    final fetchedPostalCode = await _secureStorage.read(key: 'postal_code') ?? 'Empty';
    final fetchedCity = await _secureStorage.read(key: 'city') ?? 'Empty';
    
    final fullAddress = '$fetchedStreet, $fetchedBuildingNumber, $fetchedPostalCode, $fetchedCity';

    final fetchedName = await _secureStorage.read(key: 'name') ?? 'Empty';
    final fetchedEmail = await _secureStorage.read(key: 'email') ?? 'Empty';
    final fetchedPayment = await _secureStorage.read(key: 'card_number') ?? 'Empty';

    setState(() {
      name = fetchedName;
      email = fetchedEmail;
      address = fullAddress;
      paymentMethod = fetchedPayment;
    });
  }

  void _editField(String label, String value, void Function(String) onChanged) {
    final controller = TextEditingController(text: value);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $label'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter $label',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onChanged(controller.text);
                setState(() {});
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Information',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            _buildEditableField(Icons.person, name, 'Name', (value) {
              name = value;
            }),
            _buildEditableField(Icons.email, email, 'Email', (value) {
              email = value;
            }),
            const SizedBox(height: 16),
            const Text(
              'Address',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            _buildEditableField(Icons.home, address, 'Address', (value) {
              address = value;
            }),
            const SizedBox(height: 16),
            const Text(
              'Payment Method',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            _buildEditableField(Icons.payment, paymentMethod, 'Payment Method', (value) {
              paymentMethod = value;
            }),
            const SizedBox(height: 16),
            const Text(
              'Shipping or Pickup',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Container(
              width: MediaQuery.of(context).size.width - 32,
              padding: const EdgeInsets.only(left: 16), 
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), 
                borderRadius: BorderRadius.circular(8), 
              ),
              child: DropdownButton<String>(
                value: shippingOption,
                isExpanded: true, 
                onChanged: (String? newValue) {
                  setState(() {
                    shippingOption = newValue ?? 'Shipping';
                  });

                  // pick up - mapa
                  if (shippingOption == 'Pickup') {
                    print("MAPA");
                  }
                },
                items: <String>['Shipping', 'Pickup']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => payNow(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                ),
                child: const Text(
                  'Payment',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(IconData icon, String value, String label, void Function(String) onChanged) {
    return ListTile(
      leading: Icon(icon),
      title: Text(value),
      subtitle: Text(label),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () => _editField(label, value, onChanged),
      ),
    );
  }
}

payNow() {
}