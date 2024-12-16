import 'package:flutter/material.dart';
import '../models/clients.dart'; // Import the Client model
import '../data/client_repository.dart'; // Import the Client Repository
import 'client_view_screen.dart'; // Import the Client Detail Screen (assumed to exist)

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({super.key});

  @override
  _ClientListScreenState createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  late Future<List<Client>> _clientsFuture;
  late final ClientRepository _repository;
  List<Client> _clients = [];
  List<Client> _filteredClients = [];

  @override
  void initState() {
    super.initState();
    _repository = ClientRepository();
    _clientsFuture = _repository.getClientsByAgentId();
    _loadClients();
  }

  // Method to fetch clients and set state
  Future<void> _loadClients() async {
    final clients = await _clientsFuture;
    setState(() {
      _clients = clients;
      _filteredClients = clients;  // Initially, no filtering
    });
  }

  // Filter clients based on search query
  void _filterClients(String query) {
    setState(() {
      _filteredClients = _clients.where((client) {
        return client.firstName.toLowerCase().contains(query.toLowerCase()) ||
            client.lastName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client List (${_filteredClients.length})'), // Show filtered count
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String search = await showSearch<String>(
                    context: context,
                    delegate: CustomSearchDelegate(
                        clients: _clients), // Use the full client list for searching
                  ) ??
                  '';
              _filterClients(search);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Client>>(
        future: _clientsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No clients available.'));
          }

          // No need to modify _filteredClients anymore, it's updated dynamically
          _filteredClients.sort((a, b) => a.firstName.compareTo(b.firstName));

          return ListView.builder(
            itemCount: _filteredClients.length,
            itemBuilder: (context, index) {
              final client = _filteredClients[index];
              return ListTile(
                title: Text(client.getDisplayName()),
                onTap: () {
                  // Navigate to client detail screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClientViewScreen(client: client),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

// Custom Search Delegate for searching clients
class CustomSearchDelegate extends SearchDelegate<String> {
  final List<Client> clients; // Store the list of clients passed

  CustomSearchDelegate({required this.clients});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search Results for: "$query"'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = clients.where((client) {
      return client.firstName.toLowerCase().contains(query.toLowerCase()) ||
          client.lastName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final client = suggestions[index];
        return ListTile(
          title: Text('${client.firstName} ${client.lastName}'),
          onTap: () {
            query = '${client.firstName} ${client.lastName}';
            showResults(context);
          },
        );
      },
    );
  }
}
