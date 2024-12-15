import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../../../core/shared_preferences_helper.dart';
import '../models/importedFiles.dart';
import '../../../config.dart';

class FileImportRepository {
  static const String _postPolicyImportPath = 'PolicyImport/import?agentId=';
  static const String _getPolicyImportPath = 'PolicyImport/agent';
  static const String _postSyncClientsPath = 'client/sync';

  /// Processes file bytes and uploads them to the server for policy import.
  Future<bool> processFileBytes(
      Uint8List fileBytes, String fileName, String agentId) async {
    final String postUrl =
        '${AppConfig.apiBaseUrl}/$_postPolicyImportPath$agentId';

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(postUrl),
      )..files.add(
          http.MultipartFile.fromBytes(
            'file', // Key expected by the API
            fileBytes,
            filename: fileName,
          ),
        );

      final response = await request.send();
      return response.statusCode == 200;
    } catch (e, stackTrace) {
      // Log errors properly using a logging package
      print('Error uploading file: $e');
      print(stackTrace);
      return false;
    }
  }

  /// Retrieves a list of imported files for the selected agent.
  Future<List<ImportedFile>> retrieveImportedFiles() async {
    try {
      final String? agentId =
          await SharedPreferencesHelper.getSelectedAgentId();
      if (agentId == null) {
        throw Exception('Agent ID is not available');
      }

      final String url =
          '${AppConfig.apiBaseUrl}/$_getPolicyImportPath/$agentId';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((file) => ImportedFile.fromJson(file)).toList();
      } else {
        throw Exception(
            'Failed to load imported files: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      print('Error retrieving imported files: $e');
      print(stackTrace);
      rethrow;
    }
  }

  /// Synchronizes clients with the given file import ID.
  Future<bool> syncClients(String fileImportId) async {
    try {
      final String? agentId =
          await SharedPreferencesHelper.getSelectedAgentId();
      if (agentId == null) {
        throw Exception('Agent ID is not available');
      }

      final String postUrl =
          '${AppConfig.apiBaseUrl}/$_postSyncClientsPath/$agentId/$fileImportId';

      final response = await http.post(
        Uri.parse(postUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({}), // Adjust the body if necessary
      );

      if (response.statusCode == 200) {
        print('Clients synced successfully.');
        return true;
      } else {
        print('Failed to sync clients: ${response.statusCode}');
        return false;
      }
    } catch (e, stackTrace) {
      print('Error syncing clients: $e');
      print(stackTrace);
      return false;
    }
  }
}
