import 'dart:async';
import 'dart:convert';
import '../../../core/shared_preferences_helper.dart';
import '../models/agents.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartdome_ins_ui/Config.dart';

class AgentRepository {
  final String getAgentsbyTenantIdPath = 'Agent/${AppConfig.defaultTenantId}';
  final String updateAgentPath = 'Agent';
  Future<List<Agent>> fetchAgents() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Sending GET request to the API
      final response = await http
          .get(Uri.parse('${AppConfig.apiBaseUrl}/$getAgentsbyTenantIdPath'));
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
    try {
      // Prepare the request URL
      final url = Uri.parse('${AppConfig.apiBaseUrl}/$updateAgentPath');

      // Convert the agent object to JSON
      final body = jsonEncode(agent.toMap());

      // Make the PUT request with the body
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      // Check for successful response
      if (response.statusCode == 204) {
        await SharedPreferencesHelper.setSelectedAgent(agent);
        // No content, the agent was successfully updated
        return true;
      } else {
        // Handle errors from the API
        print('Failed to update agent: ${response.body}');
        return false;
      }
    } catch (e) {
      // Handle any errors such as network issues or timeout
      print('Error updating agent: $e');
      return false;
    }
  }

  Future<Agent> fetchAgentById(String agentId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final agentsData = prefs.getString('agentsData');

      if (agentsData != null) {
        // If agents data exists in shared preferences, decode it
        List<dynamic> jsonResponse = json.decode(agentsData);

        // Find the agent with the given agentId
        final agentJson = jsonResponse.firstWhere(
          (agent) => agent['agentId'] == agentId,
          orElse: () => null, // Return null if agentId is not found
        );

        if (agentJson != null) {
          // Return the agent object if found
          return Agent.fromJson(agentJson);
        } else {
          // If agent is not found, throw an exception
          throw Exception('Agent with ID $agentId not found');
        }
      } else {
        throw Exception('No agents data found in SharedPreferences');
      }
    } catch (e) {
      throw Exception('Failed to fetch agent by ID: $e');
    }
  }
}
