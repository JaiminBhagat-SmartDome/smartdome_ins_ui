import 'package:flutter/material.dart';
import '../models/clients.dart';  // Import the Client model
import '../data/client_repository.dart';  // Import the Client Repository
import 'client_view_screen.dart';  // Import the Client Detail Screen (assumed to exist)

class ClientListScreen extends StatefulWidget {
  @override
  _ClientListScreenState createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  late Future<List<Client>> _clients;
  List<Client> _filteredClients = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _clients = ClientRepository().fetchClients();
  }

  void _filterClients(String query) {
    setState(() {
      _searchQuery = query;
      _filteredClients = _filteredClients
          .where((client) =>
      client.firstName.toLowerCase().contains(query.toLowerCase()) ||
          client.lastName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client List'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String search = await showSearch<String>(
                context: context,
                delegate: CustomSearchDelegate(clients: _filteredClients), // Passing filtered clients
              ) ?? '';
              _filterClients(search);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Client>>(
        future: _clients,
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

          _filteredClients = snapshot.data!;
          _filteredClients.sort((a, b) => a.firstName.compareTo(b.firstName));

          return ListView.builder(
            itemCount: _filteredClients.length,
            itemBuilder: (context, index) {
              final client = _filteredClients[index];
              return ListTile(
                title: Text('${client.firstName} ${client.lastName}'),
                subtitle: Text('Client ID: ${client.clientID}'),
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
  final List<Client> clients;  // Store the list of clients passed

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
