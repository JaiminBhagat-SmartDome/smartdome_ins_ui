import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/shared_preferences_helper.dart';
import '../models/agents.dart';
import '../data/agent_repository.dart';

class AgentSelectionScreen extends StatefulWidget {
  const AgentSelectionScreen({super.key});

  @override
  State<AgentSelectionScreen> createState() => _AgentSelectionScreenState();
}

class _AgentSelectionScreenState extends State<AgentSelectionScreen> {
  late final AgentRepository _agentRepository;
  late Future<List<Agent>> _agentsFuture;
  bool _isFirstLoad = true; // Flag to track first load

  @override
  void initState() {
    super.initState();
    _agentRepository = AgentRepository();
    if (_isFirstLoad) {
      _agentsFuture = _agentRepository.fetchAgents();
      _isFirstLoad = false; // Set flag to false after first load
    }
  }

  // Method to save the selected agent to SharedPreferences
  Future<void> _saveSelectedAgent(Agent agent) async {
    final prefs = await SharedPreferences.getInstance();
    // Convert the selected agent object to JSON string
    String agentJson = json.encode(agent.toMap());
    await prefs.setString('selectedAgent', agentJson); // Save JSON to SharedPreferences
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agent Selection'),
      ),
      body: FutureBuilder<List<Agent>>(
        future: _agentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Agents Found'));
          }

          final agents = snapshot.data!.take(2).toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two columns in the grid
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: agents.length,
              itemBuilder: (context, index) {
                final agent = agents[index];

                return GestureDetector(
                  onTap: () async {
                    // Save the selected agent to SharedPreferences
                    await SharedPreferencesHelper.setSelectedAgent(agent);

                    // Redirect to the next screen (fileImport screen)
                    Navigator.pushNamed(context, '/main');
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          // backgroundImage: NetworkImage(agent.profileImage),  // Assuming profileImage is a URL
                        ),
                        const SizedBox(height: 8),
                        Text(
                          agent.firstName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
