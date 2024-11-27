import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ShippingInfo extends StatefulWidget {
  const ShippingInfo({super.key});

  @override
  State<ShippingInfo> createState() => _ShippingInfoState();
}

class _ShippingInfoState extends State<ShippingInfo> {
  final _storage = const FlutterSecureStorage();

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
    _streetController.text = await _storage.read(key: 'street') ?? '';
    _buildingNumberController.text = await _storage.read(key: 'building_number') ?? '';
    _postalCodeController.text = await _storage.read(key: 'postal_code') ?? '';
    _cityController.text = await _storage.read(key: 'city') ?? '';
    setState(() {});
  }

  Future<void> _saveShippingInfo() async {
    await _storage.write(key: 'street', value: _streetController.text);
    await _storage.write(key: 'building_number', value: _buildingNumberController.text);
    await _storage.write(key: 'postal_code', value: _postalCodeController.text);
    await _storage.write(key: 'city', value: _cityController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Shipping information saved')),
    );
    setState(() {
      _isEditing = false;
    });
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
          borderSide: BorderSide(
            color: Colors.blue, 
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue, 
            width: 2.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Shipping Information"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildField("Street", _streetController),
            const SizedBox(height: 16),
            _buildField("Building Number", _buildingNumberController),
            const SizedBox(height: 16),
            _buildField("Postal Code", _postalCodeController),
            const SizedBox(height: 16),
            _buildField("City", _cityController),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_isEditing) {
                    _saveShippingInfo();
                  } else {
                    setState(() {
                      _isEditing = true;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.blue,
                ),
                child: Text(_isEditing ? "Save" : "Edit",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
