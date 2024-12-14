import 'package:flutter/material.dart';
import 'package:smartdome_ins_ui/core/shared_preferences_helper.dart';
import '../models/agents.dart';
import '../data/agent_repository.dart';
import 'agent_edit_screen.dart'; // Import the edit screen

class AgentViewScreen extends StatefulWidget {
  @override
  _AgentViewScreenState createState() => _AgentViewScreenState();
}

class _AgentViewScreenState extends State<AgentViewScreen> {
  final AgentRepository agentRepository = AgentRepository();
  Future<Agent>? agentFuture; // Initially nullable
  late String agentId;

  @override
  void initState() {
    super.initState();
    _loadAgentId();
  }

  // Load the agentId and fetch agent details
  Future<void> _loadAgentId() async {
    final selectedAgentId = await SharedPreferencesHelper.getSelectedAgentId();
    setState(() {
      agentId = selectedAgentId ?? ''; // Set the agentId here
      // Fetch agent details once agentId is available
      agentFuture = agentRepository.fetchAgentById(agentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agent Details'),
      ),
      body: agentFuture == null
          ? Center(child: CircularProgressIndicator()) // Wait until agentFuture is set
          : FutureBuilder<Agent>(
              future: agentFuture,
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
                if (!snapshot.hasData) {
                  return Center(child: Text('No agent found'));
                }

                // Get the agent from the snapshot
                final agent = snapshot.data!;

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
                            setState(() {
                              // Re-fetch the agent data after update
                              agentFuture = agentRepository.fetchAgentById(agentId);
                            });

                            // Optionally, show a success message after update
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Agent updated successfully')),
                            );
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
