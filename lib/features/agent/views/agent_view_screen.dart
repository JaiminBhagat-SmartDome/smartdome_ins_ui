// agent_screen.dart

import 'package:flutter/material.dart';
import '../data/agent_repository.dart'; // Import the Agent repository to get agent data
import '../models/agents.dart';

class AgentScreen extends StatelessWidget {
  final AgentRepository agentRepository = AgentRepository();

  @override
  Widget build(BuildContext context) {
    // Use FutureBuilder to handle async fetching of agent data
    return Scaffold(
      appBar: AppBar(
        title: Text('Agent Details'),
      ),
      body: FutureBuilder<List<Agent>>(
        // Fetch the list of agents asynchronously
        future: agentRepository.fetchAgents(),
        builder: (context, snapshot) {
          // Handle different states of the future
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show loading spinner while waiting
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Show error if any
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No agents available')); // Handle empty data
          }

          // Find the agent with agentId == 'A12345' (you can change the ID here)
          final agent = snapshot.data!.firstWhere(
                (a) => a.agentId == '1', // Replace 'A12345' with the ID you're looking for
            orElse: () => Agent(
              agentId: 'N/A',
              agentName: 'Not Found',
              agentAddress: 'Not Available',
              agentPhoneNumber: 'N/A',
              agentCode: 'N/A',
              agentEmail: 'Not Available',
            ),
          );

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Agent ID:', agent.agentId),
                _buildDetailRow('Agent Name:', agent.agentName),
                _buildDetailRow('Agent Address:', agent.agentAddress),
                _buildDetailRow('Phone Number:', agent.agentPhoneNumber),
                _buildDetailRow('Agent Code:', agent.agentCode),
                _buildDetailRow('Agent Email:', agent.agentEmail),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper function to build detail row
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
