import '../models/clients.dart';
import '../data/mock_client_data.dart';

class ClientRepository {
  // Fetch all clients
  Future<List<Client>> fetchClients() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate API call
    return mockClientData;
  }
}
