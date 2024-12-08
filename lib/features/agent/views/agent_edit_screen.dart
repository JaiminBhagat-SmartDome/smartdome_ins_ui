import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/agents.dart';
import '../data/agent_repository.dart';

class AgentEditScreen extends StatefulWidget {
  final Agent agent;

  AgentEditScreen({required this.agent});

  @override
  _AgentEditScreenState createState() => _AgentEditScreenState();
}

class _AgentEditScreenState extends State<AgentEditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AgentRepository agentRepository = AgentRepository();

  late TextEditingController _firstNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _address1Controller;
  late TextEditingController _address2Controller;
  late TextEditingController _primaryEmailController;
  late TextEditingController _secondaryEmailController;
  late TextEditingController _mobileController;
  late TextEditingController _workController;
  late TextEditingController _homeController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current agent values
    _firstNameController = TextEditingController(text: widget.agent.firstName);
    _middleNameController = TextEditingController(text: widget.agent.middleName);
    _lastNameController = TextEditingController(text: widget.agent.lastName);
    _address1Controller = TextEditingController(text: widget.agent.address1);
    _address2Controller = TextEditingController(text: widget.agent.address2);
    _primaryEmailController = TextEditingController(text: widget.agent.emails['primary'] ?? '');
    _secondaryEmailController = TextEditingController(text: widget.agent.emails['secondary'] ?? '');
    _mobileController = TextEditingController(text: widget.agent.phoneNumbers['mobile'] ?? '');
    _workController = TextEditingController(text: widget.agent.phoneNumbers['work'] ?? '');
    _homeController = TextEditingController(text: widget.agent.phoneNumbers['home'] ?? '');
  }

  // Email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Phone number validation (Indian 10-digit number)
  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^\d{10}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  // Save the edited agent details
  void _saveAgent() async {
    if (_formKey.currentState!.validate()) {
      // Collect updated data
      final updatedAgent = Agent(
        agentId: widget.agent.agentId,
        appId: widget.agent.appId,
        tenantId: widget.agent.tenantId,
        branchId: widget.agent.branchId,
        agentCode: widget.agent.agentCode,  // Keep AgentCode as it is
        firstName: _firstNameController.text,
        middleName: _middleNameController.text,
        lastName: _lastNameController.text,
        address1: _address1Controller.text,
        address2: _address2Controller.text,
        emails: {
          'primary': _primaryEmailController.text,
          'secondary': _secondaryEmailController.text,
        },
        phoneNumbers: {
          'mobile': _mobileController.text,
          'work': _workController.text,
          'home': _homeController.text,
        },
      );

      // Call the API to update agent
      final success = await agentRepository.updateAgent(updatedAgent);
      if (success) {
        // Navigate back to AgentViewScreen on success
        Navigator.pop(context);
      } else {
        // Handle failure (e.g., show error message)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update agent')));
      }
    }
  }

  // Cancel and navigate back
  void _cancelEdit() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Agent'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Agent Code (Read-only)
              TextFormField(
                initialValue: widget.agent.agentCode,
                decoration: InputDecoration(labelText: 'Agent Code'),
                readOnly: true,
              ),
              // FirstName
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'First Name is required';
                  }
                  return null;
                },
              ),
              // MiddleName
              TextFormField(
                controller: _middleNameController,
                decoration: InputDecoration(labelText: 'Middle Name'),
              ),
              // LastName
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Last Name is required';
                  }
                  return null;
                },
              ),
              // Address Details
              TextFormField(
                controller: _address1Controller,
                decoration: InputDecoration(labelText: 'Address 1'),
              ),
              TextFormField(
                controller: _address2Controller,
                decoration: InputDecoration(labelText: 'Address 2'),
              ),
              // Email Details
              TextFormField(
                controller: _primaryEmailController,
                decoration: InputDecoration(labelText: 'Primary Email'),
                validator: _validateEmail,
              ),
              TextFormField(
                controller: _secondaryEmailController,
                decoration: InputDecoration(labelText: 'Secondary Email'),
                validator: _validateEmail,
              ),
              // Phone Number Details
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(labelText: 'Mobile'),
                validator: _validatePhoneNumber,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              TextFormField(
                controller: _workController,
                decoration: InputDecoration(labelText: 'Work'),
                validator: _validatePhoneNumber,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              TextFormField(
                controller: _homeController,
                decoration: InputDecoration(labelText: 'Home'),
                validator: _validatePhoneNumber,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              // Action Buttons (Save and Cancel)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _saveAgent,
                    child: Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: _cancelEdit,
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
