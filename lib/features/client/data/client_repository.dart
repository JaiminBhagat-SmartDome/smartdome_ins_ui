import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/clients.dart';
import '../data/mock_client_data.dart';
import 'package:http/http.dart' as http;

class ClientRepository {
  // Method to retrieve all clients by agentId
  Future<List<Client>> getClientsByAgentId() async {
    // Retrieve the agentId using the existing method
    String? agentId = await _getSelectedAgentId();

    // API endpoint with dynamic agentId
    final String url = 'http://localhost:5043/api/client/$agentId';

    try {
      // Make the GET request
      final response = await http.get(Uri.parse(url));

      // Check for successful response
      if (response.statusCode == 200) {
        // Parse the response body as JSON
        List<dynamic> jsonResponse = json.decode(response.body);

        // Map the JSON response to a list of Client objects
        List<Client> clients = jsonResponse.map((client) {
          return Client.fromJson(client);
        }).toList();

        return clients;
      } else {
        // Handle unsuccessful status codes
        throw Exception('Failed to load clients. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors like network issues, JSON parsing errors, etc.
      throw Exception('Error retrieving clients: $e');
    }
  }

    Future<String?> _getSelectedAgentId() async {
    final prefs = await SharedPreferences.getInstance();
    String? agentJson = prefs.getString('selectedAgent');

    if (agentJson != null) {
      Map<String, dynamic> agentMap = json.decode(agentJson);
      return agentMap['agentId']; // Assuming agentId is present in the agentMap
    }
    return null;
  }
}