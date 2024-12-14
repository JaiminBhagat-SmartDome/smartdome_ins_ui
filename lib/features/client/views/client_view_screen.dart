import 'package:flutter/material.dart';
import '../models/clients.dart';  // Import the Client model
import 'client_edit_screen.dart';  // Import the Client Edit Screen (assumed to exist)

class ClientViewScreen extends StatelessWidget {
  final Client client;

  // Constructor to accept client object from previous screen
  ClientViewScreen({required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${client.firstName} ${client.lastName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Client Basic Details Section
            _buildSectionTitle('Basic Details'),
            _buildDetailRow('System Name', client.systemName),
            _buildDetailRow('Client Type', client.clientType),
            if (client.clientType == 'Individual') ...[
              _buildDetailRow('First Name', client.firstName),
              _buildDetailRow('Middle Name', client.middleName ?? ''),
              _buildDetailRow('Last Name', client.lastName),
            ] else ...[
              _buildDetailRow('First Name', client.firstName),
            ],

            // Address Details Section
            _buildSectionTitle('Address Details'),
            _buildDetailRow('Address1', client.address1),
            _buildDetailRow('Address2', client.address2),
            _buildDetailRow('Pin Code', client.pinCode.toString()),
            _buildDetailRow('Country', client.country),

            // Contact Details Section
            _buildSectionTitle('Contact Details'),
            _buildDetailRow('Mobile', client.phoneNumbers['mobile'] ?? ''),
            _buildDetailRow('Office', client.phoneNumbers['office'] ?? ''),
            _buildDetailRow('Other', client.phoneNumbers['other'] ?? ''),
            _buildDetailRow('Primary Email', client.emailAddresses['primary'] ?? ''),
            _buildDetailRow('Secondary Email', client.emailAddresses['secondary'] ?? ''),

            // Edit Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to edit screen and pass the selected client object
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClientEditScreen(client: client),
                    ),
                  );
                },
                child: Text('Edit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
