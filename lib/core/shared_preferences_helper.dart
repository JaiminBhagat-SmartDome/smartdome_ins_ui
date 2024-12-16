import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../features/agent/models/agents.dart';

class SharedPreferencesHelper {
  // Get the selected agent ID from SharedPreferences
  static Future<String> getSelectedAgentId() async {
       final prefs = await SharedPreferences.getInstance();
    String? agentJson = prefs.getString('selectedAgent');

    if (agentJson != null) {
      Map<String, dynamic> agentMap = json.decode(agentJson);
      return agentMap['agentId']; // Assuming agentId is present in the agentMap
    }
    return '';
  }

  // Set the selected agent ID in SharedPreferences
  static Future<void> setSelectedAgent(Agent agent) async {
    final prefs = await SharedPreferences.getInstance();
    // Convert the selected agent object to JSON string
    String agentJson = json.encode(agent.toMap());
    print('setSelectedAgent: $agentJson');
    await prefs.setString('selectedAgent', agentJson); // Save JSON to SharedPreferences
  }

  // You can add other shared preferences methods here
  // For example, to get or set any other key-value pairs
  static Future<void> removeSelectedAgentId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('selectedAgent');
  }
}
