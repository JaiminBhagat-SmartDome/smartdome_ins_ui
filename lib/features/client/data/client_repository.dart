import 'dart:convert';
import '../../../core/shared_preferences_helper.dart';
import '../models/clients.dart';
import 'package:http/http.dart' as http;
import '../../../config.dart';

class ClientRepository {
  // API paths
  static const String _clientPath = '/client';

  // Method to retrieve all clients by agentId
  Future<List<Client>> getClientsByAgentId() async {
    // Retrieve the agentId using SharedPreferencesHelper
    String? agentId = await SharedPreferencesHelper.getSelectedAgentId();

    if (agentId == null) {
      throw Exception('No agentId found');
    }

    // Construct the API URL
    final String url = '${AppConfig.apiBaseUrl}$_clientPath/$agentId';

    try {
      // Make the GET request
      final response = await http.get(Uri.parse(url));

      // Check for successful response
      if (response.statusCode == 200) {
        // Parse the response body as JSON
        List<dynamic> jsonResponse = json.decode(response.body);

        // Map the JSON response to a list of Client objects
        return jsonResponse.map((client) => Client.fromJson(client)).toList();
      } else {
        // Handle unsuccessful status codes
        throw Exception(
            'Failed to load clients. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors like network issues, JSON parsing errors, etc.
      throw Exception('Error retrieving clients: $e');
    }
  }

  // Method to update the client information via the API
  Future<bool> updateClient(Client client) async {
    // Construct the API URL
    final String url = '${AppConfig.apiBaseUrl}$_clientPath/${client.clientId}';

    // Request body (convert client object to JSON)
    final Map<String, dynamic> clientData = {
      'clientId': client.clientId,
      'systemName': client.systemName,
      'clientType': client.clientType,
      'initial': client.initial,
      'firstName': client.firstName,
      'middleName': client.middleName,
      'lastName': client.lastName,
      'address1': client.address1,
      'address2': client.address2,
      'pinCode': client.pinCode,
      'firmName': client.firmName,
      'country': client.country,
      'phoneNumbers': client.phoneNumbers,
      'emailAddresses': client.emailAddresses,
      'agentId': client.agentId,
      'isActive': client.isActive
    };

    // Sending the PUT request
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(clientData),
      );

      if (response.statusCode == 204) {
        // If the server responds with a success status
        return true;
      } else {
        // If the server responds with an error status
        print('Failed to update client. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error updating client: $e');
      return false;
    }
  }
}
