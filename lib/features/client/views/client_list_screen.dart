import 'package:flutter/material.dart';
import '../models/clients.dart';
import '../data/client_repository.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({Key? key}) : super(key: key);

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final ClientRepository _clientRepository = ClientRepository();
  List<Client> clients = [];
  List<Client> filteredClients = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadClients();
    searchController.addListener(_filterClients);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _loadClients() async {
    try {
      final fetchedClients = await _clientRepository.fetchClients();
      setState(() {
        clients = fetchedClients..sort((a, b) => a.name.compareTo(b.name));
        filteredClients = clients;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching clients: $e')),
      );
    }
  }

  void _filterClients() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredClients = clients
          .where((client) => client.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clients'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          // Clients List
          Expanded(
            child: filteredClients.isEmpty
                ? const Center(
              child: Text(
                'No clients found',
                style: TextStyle(fontSize: 16),
              ),
            )
                : ListView.builder(
              itemCount: filteredClients.length,
              itemBuilder: (context, index) {
                final client = filteredClients[index];
                return ListTile(
                  title: Text(client.name),
                  subtitle: Text('ID: ${client.id}'),
                  onTap: () {
                    // Navigate to Client Details Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ClientDetailsScreen(clientId: client.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ClientDetailsScreen extends StatelessWidget {
  final String clientId;

  const ClientDetailsScreen({Key? key, required this.clientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Details'),
      ),
      body: Center(
        child: Text('Details for Client ID: $clientId'),
      ),
    );
  }
}
