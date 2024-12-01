import 'package:flutter/material.dart';
import '../models/agents.dart';
import '../data/agent_repository.dart';
import 'agent_edit_screen.dart';  // Import the edit screen

class AgentViewScreen extends StatelessWidget {
  final AgentRepository agentRepository = AgentRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agent Details'),
      ),
      body: FutureBuilder<List<Agent>>(
        // Fetch the list of agents asynchronously
        future: agentRepository.fetchAgents(),
        builder: (context, snapshot) {
          // Handle loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Handle error state
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Handle no data state
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No agents found'));
          }

          // Get the first agent from the list
          final agent = snapshot.data![0];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                // Basic Details Section
                _buildSectionTitle('Basic Details'),
                _buildDetailsRow('Agent Code', agent.agentCode),
                _buildDetailsRow('First Name', agent.firstName),
                _buildDetailsRow('Middle Name', agent.middleName),
                _buildDetailsRow('Last Name', agent.lastName),
                const SizedBox(height: 20),

                // Address Details Section
                _buildSectionTitle('Address Details'),
                _buildDetailsRow('Address 1', agent.address1),
                _buildDetailsRow('Address 2', agent.address2),
                const SizedBox(height: 20),

                // Contact Details Section
                _buildSectionTitle('Contact Details'),
                _buildContactDetails(agent.emails, 'Email'),
                _buildContactDetails(agent.phoneNumbers, 'Phone Number'),

                // Edit Button (Navigating to Edit Screen)
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Navigate to AgentEditScreen and pass the current agent object
                    final updatedAgent = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgentEditScreen(agent: agent),
                      ),
                    );

                    // If the agent is updated, refresh the agent data
                    if (updatedAgent != null) {
                      // Normally you'd want to update the state of the widget, but since this is a StatelessWidget,
                      // you would need a way to fetch updated data or trigger a rebuild.
                      // Here we can just pop and let the screen reload automatically by navigating back.
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Edit Agent'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper method to build section title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  // Helper method to build row of key-value details
  Widget _buildDetailsRow(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(key, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }

  // Helper method to build contact details section
  Widget _buildContactDetails(Map<String, String> contactDetails, String type) {
    List<Widget> contactWidgets = [];
    contactDetails.forEach((key, value) {
      contactWidgets.add(
        _buildDetailsRow('$type: $key', value),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: contactWidgets,
    );
  }
}
