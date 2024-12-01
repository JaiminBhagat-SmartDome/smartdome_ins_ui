import 'package:flutter/material.dart';
import '../models/clients.dart';  // Import the Client model

class ClientEditScreen extends StatefulWidget {
  final Client client;

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
  late TextEditingController _workController;
  late TextEditingController _homeController;
  late TextEditingController _primaryEmailController;
  late TextEditingController _secondaryEmailController;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with current client data
    _firstNameController = TextEditingController(text: widget.client.firstName);
    _middleNameController = TextEditingController(text: widget.client.middleName ?? '');
    _lastNameController = TextEditingController(text: widget.client.lastName);
    _address1Controller = TextEditingController(text: widget.client.address1);
    _address2Controller = TextEditingController(text: widget.client.address2);
    _pinCodeController = TextEditingController(text: widget.client.pinCode.toString());
    _countryController = TextEditingController(text: widget.client.country);
    _mobileController = TextEditingController(text: widget.client.phoneNumbers['mobile'] ?? '');
    _workController = TextEditingController(text: widget.client.phoneNumbers['work'] ?? '');
    _homeController = TextEditingController(text: widget.client.phoneNumbers['home'] ?? '');
    _primaryEmailController = TextEditingController(text: widget.client.emailAddresses['primary'] ?? '');
    _secondaryEmailController = TextEditingController(text: widget.client.emailAddresses['secondary'] ?? '');
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
    _workController.dispose();
    _homeController.dispose();
    _primaryEmailController.dispose();
    _secondaryEmailController.dispose();
    super.dispose();
  }

  void _saveClient() {
    // Save the edited client information (this is where you would call an API to save the data)
    final updatedClient = Client(
      clientID: widget.client.clientID,
      systemName: widget.client.systemName,
      clientType: widget.client.clientType,
      initial: widget.client.initial,
      firstName: _firstNameController.text,
      middleName: _middleNameController.text,
      lastName: _lastNameController.text,
      address1: _address1Controller.text,
      address2: _address2Controller.text,
      pinCode: int.parse(_pinCodeController.text),
      firmName: widget.client.firmName,
      country: _countryController.text,
      phoneNumbers: {
        'mobile': _mobileController.text,
        'work': _workController.text,
        'home': _homeController.text,
      },
      emailAddresses: {
        'primary': _primaryEmailController.text,
        'secondary': _secondaryEmailController.text,
      },
      agentID: widget.client.agentID,
      isActive: widget.client.isActive,
      createdAt: widget.client.createdAt,
    );

    // Simulate saving by printing the updated client data (You can replace this with actual API call)
    print('Client updated: ${updatedClient.firstName} ${updatedClient.lastName}');
    // Go back to the previous screen (client view screen) after saving
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Client'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField('First Name', _firstNameController),
            if (widget.client.clientType == 'Individual') ...[
              _buildTextField('Middle Name', _middleNameController),
              _buildTextField('Last Name', _lastNameController),
            ],
            _buildTextField('Address1', _address1Controller),
            _buildTextField('Address2', _address2Controller),
            _buildTextField('Pin Code', _pinCodeController, inputType: TextInputType.number),
            _buildTextField('Country', _countryController),
            _buildTextField('Mobile', _mobileController, inputType: TextInputType.phone),
            _buildTextField('Work', _workController, inputType: TextInputType.phone),
            _buildTextField('Home', _homeController, inputType: TextInputType.phone),
            _buildTextField('Primary Email', _primaryEmailController, inputType: TextInputType.emailAddress),
            _buildTextField('Secondary Email', _secondaryEmailController, inputType: TextInputType.emailAddress),

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

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType inputType = TextInputType.text}) {
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
