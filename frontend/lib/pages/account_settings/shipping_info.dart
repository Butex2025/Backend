import 'package:flutter/material.dart';
import '../logic/secure_storage_manager.dart';

class ShippingInfo extends StatefulWidget {
  const ShippingInfo({super.key});

  @override
  State<ShippingInfo> createState() => _ShippingInfoState();
}

class _ShippingInfoState extends State<ShippingInfo> {
  final _storageManager = SecureStorageManager.instance;

  final _streetController = TextEditingController();
  final _buildingNumberController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _cityController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadShippingInfo();
  }

  Future<void> _loadShippingInfo() async {
    _streetController.text = await _storageManager.read('street') ?? '';
    _buildingNumberController.text = await _storageManager.read('building_number') ?? '';
    _postalCodeController.text = await _storageManager.read('postal_code') ?? '';
    _cityController.text = await _storageManager.read('city') ?? '';
    setState(() {});
  }

  Future<void> _saveShippingInfo() async {
    if (!_validatePostalCode(_postalCodeController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid postal code format (00-000)')),
      );
      return;
    }

    await _storageManager.write('street', _streetController.text);
    await _storageManager.write('building_number', _buildingNumberController.text);
    await _storageManager.write('postal_code', _postalCodeController.text);
    await _storageManager.write('city', _cityController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Shipping information saved')),
    );

    setState(() {
      _isEditing = false;
    });
  }

  bool _validatePostalCode(String postalCode) {
    final postalCodeRegExp = RegExp(r'^\d{2}-\d{3}$');
    return postalCodeRegExp.hasMatch(postalCode);
  }

  Widget _buildField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      enabled: _isEditing,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.blue),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _isEditing ? Colors.grey : Colors.blue,
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
      ),
    );
  }

  Widget _buildPostalCodeField() {
    return TextField(
      controller: _postalCodeController,
      enabled: _isEditing,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: "Postal Code",
        labelStyle: const TextStyle(color: Colors.blue),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _isEditing ? Colors.grey : Colors.blue,
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        errorText: _validatePostalCode(_postalCodeController.text)
            ? null
            : "Invalid postal code format (00-000)",
      ),
      onChanged: (_) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shipping Information"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildField("Street", _streetController),
            const SizedBox(height: 16),
            _buildField("Building Number", _buildingNumberController),
            const SizedBox(height: 16),
            _buildPostalCodeField(),
            const SizedBox(height: 16),
            _buildField("City", _cityController),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_isEditing) {
                  _saveShippingInfo();
                } else {
                  setState(() {
                    _isEditing = true;
                  });
                }
              },
              child: Text(_isEditing ? "Save" : "Edit"),
            ),
          ],
        ),
      ),
    );
  }
}
