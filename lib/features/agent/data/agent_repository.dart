import 'dart:async';
import '../models/agents.dart';
import 'mock_agent_data.dart';

class AgentRepository {
  Future<List<Agent>> fetchAgents() async {
    // Simulating API call delay
    await Future.delayed(const Duration(seconds: 2));
    // Replace this with actual API logic in production
    return mockAgentData;
  }
  Future<bool> updateAgent(Agent agent) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
