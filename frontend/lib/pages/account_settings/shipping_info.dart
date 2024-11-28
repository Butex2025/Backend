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
    if (!_validatePostalCode(_postalCodeController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid postal code format (00-000)')),
      );
      return;
    }

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
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _PostalCodeInputFormatter(),
      ],
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
            _buildPostalCodeField(),
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
                child: Text(_isEditing ? "Save" : "Edit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostalCodeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    final digitsOnly = text.replaceAll(RegExp(r'\D'), '');

    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 2) formatted += '-';
      formatted += digitsOnly[i];
    }

    if (formatted.length > 6) {
      formatted = formatted.substring(0, 6);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
