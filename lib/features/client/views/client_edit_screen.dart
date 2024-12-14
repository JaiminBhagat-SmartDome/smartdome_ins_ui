import 'package:flutter/material.dart';
import '../data/client_repository.dart';
import '../models/clients.dart'; // Import the Client model

class ClientEditScreen extends StatefulWidget {
  final Client client;
  late final ClientRepository _repository;

  ClientEditScreen({required this.client});

  @override
  _ClientEditScreenState createState() => _ClientEditScreenState();
}

class _ClientEditScreenState extends State<ClientEditScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _address1Controller;
  late TextEditingController _address2Controller;
  late TextEditingController _pinCodeController;
  late TextEditingController _countryController;
  late TextEditingController _mobileController;
  late TextEditingController _officeController;
  late TextEditingController _otherController;
  late TextEditingController _primaryEmailController;
  late TextEditingController _secondaryEmailController;
  late TextEditingController _firmNameController;
  late String _clientType = ''; // Track selected client type

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with current client data
    _firstNameController = TextEditingController(text: widget.client.firstName);
    _middleNameController =
        TextEditingController(text: widget.client.middleName ?? '');
    _lastNameController = TextEditingController(text: widget.client.lastName);
    _address1Controller = TextEditingController(text: widget.client.address1);
    _address2Controller = TextEditingController(text: widget.client.address2);
    _pinCodeController =
        TextEditingController(text: widget.client.pinCode.toString());
    _countryController = TextEditingController(text: widget.client.country);
    _mobileController =
        TextEditingController(text: widget.client.phoneNumbers['Mobile'] ?? '');
    _officeController =
        TextEditingController(text: widget.client.phoneNumbers['Office'] ?? '');
    _otherController =
        TextEditingController(text: widget.client.phoneNumbers['Other'] ?? '');
    _primaryEmailController = TextEditingController(
        text: widget.client.emailAddresses['Primary'] ?? '');
    _secondaryEmailController = TextEditingController(
        text: widget.client.emailAddresses['Secondary'] ?? '');
    _firmNameController =
        TextEditingController(text: widget.client.firmName ?? '');
    _clientType = widget.client.clientType.isNotEmpty ? widget.client.clientType : "Individual"; // Set the client type
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _pinCodeController.dispose();
    _countryController.dispose();
    _mobileController.dispose();
    _officeController.dispose();
    _otherController.dispose();
    _primaryEmailController.dispose();
    _secondaryEmailController.dispose();
    _firmNameController.dispose();
    super.dispose();
  }

  Future<void> _saveClient() async {
    // Save the edited client information (this is where you would call an API to save the data)
    final updatedClient = Client(
        clientId: widget.client.clientId,
        systemName: widget.client.systemName,
        clientType: _clientType,
        initial: widget.client.initial,
        firstName: _firstNameController.text.trim(),
        middleName: _middleNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        address1: _address1Controller.text.trim(),
        address2: _address2Controller.text.trim(),
        pinCode: int.parse(_pinCodeController.text.trim()),
        firmName: _firmNameController.text.trim(),
        country: _countryController.text.trim(),
        phoneNumbers: {
          'mobile': _mobileController.text.trim(),
          'office': _officeController.text.trim(),
          'other': _otherController.text.trim(),
        },
        emailAddresses: {
          'primary': _primaryEmailController.text.trim(),
          'secondary': _secondaryEmailController.text.trim(),
        },
        agentId: widget.client.agentId,
        isActive: widget.client.isActive);
    final clientRepository = ClientRepository();
    bool isSuccess = await clientRepository.updateClient(updatedClient);

    if (isSuccess) {
      // If API call is successful, show success message and go back
      print(
          'Client updated: ${updatedClient.firstName} ${updatedClient.lastName}');
      Navigator.pop(context); // Go back to the previous screen
    } else {
      // If API call failed, show an error message
      print('Failed to update client');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update client. Please try again.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Client : ${widget.client.systemName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              children: [
                Radio<String>(
                  value: 'Individual',
                  groupValue: _clientType,
                  onChanged: (value) {
                    setState(() {
                      _clientType = value.toString();
                    });
                  },
                ),
                Text('Individual'),
                Radio<String>(
                  value: 'Firm',
                  groupValue: _clientType,
                  onChanged: (value) {
                    setState(() {
                      _clientType = value.toString();
                    });
                  },
                ),
                Text('Firm'),
              ],
            ),
            _buildTextField('First Name', _firstNameController),
            _buildTextField('Middle Name', _middleNameController),
            _buildTextField('Last Name', _lastNameController),
            _buildTextField('Firm Name', _firmNameController),
            _buildTextField('Address1', _address1Controller),
            _buildTextField('Address2', _address2Controller),
            _buildTextField('Pin Code', _pinCodeController,
                inputType: TextInputType.number),
            _buildTextField('Country', _countryController),
            _buildTextField('Mobile', _mobileController,
                inputType: TextInputType.phone),
            _buildTextField('Office', _officeController,
                inputType: TextInputType.phone),
            _buildTextField('Other', _otherController,
                inputType: TextInputType.phone),
            _buildTextField('Primary Email', _primaryEmailController,
                inputType: TextInputType.emailAddress),
            _buildTextField('Secondary Email', _secondaryEmailController,
                inputType: TextInputType.emailAddress),

            // Client Type Radio Buttons

            // Save and Cancel buttons
            Row(
              children: [
                ElevatedButton(
                  onPressed: _saveClient,
                  child: Text('Save'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
