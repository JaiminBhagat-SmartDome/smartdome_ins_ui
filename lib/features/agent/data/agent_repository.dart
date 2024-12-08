import 'dart:async';
import 'dart:convert';
import '../models/agents.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AgentRepository {
  final String apiUrl = 'http://localhost:5043/api/Agent/TENANT789';
  Future<List<Agent>> fetchAgents() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Sending GET request to the API
      final response = await http.get(Uri.parse(apiUrl));

      // If the server returns a 200 OK response, parse the JSON
      if (response.statusCode == 200) {
        // Parse the response body into a list of agents
        List<dynamic> jsonResponse = json.decode(response.body);

                  // Save the response data in shared preferences for later use
          await prefs.setString('agentsData', response.body);

        // Convert the JSON response into a List of Agent objects
        return jsonResponse
            .map((agentJson) => Agent.fromJson(agentJson))
            .toList();
      } else {
        throw Exception('Failed to load agents');
      }
    } catch (e) {
      throw Exception('Failed to load agents: $e');
    }
  }

  Future<bool> updateAgent(Agent agent) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
