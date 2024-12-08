import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import '../models/fileImports.dart';
import '../models/importedFiles.dart';
import 'mock_fileImport_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FileImportRepository {
  Future<bool> updateFileImport(FileImport fileImport) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<bool> processFileBytes(
      Uint8List fileBytes, String fileName, String agentId) async {
    try {
      // Construct multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://localhost:5043/api/PolicyImport/import?agentId=$agentId'),
      );

      request.files.add(
        http.MultipartFile.fromBytes(
          'file', // The key expected by your API
          fileBytes.toList(), // Convert to a list to avoid stream reuse issues
          filename: fileName,
        ),
      );

      // Send the request
      var response = await request.send();
      return response.statusCode == 200; // Check success status
    } catch (e) {
      print("Error uploading file: $e");
      return false;
    }
  }

  Future<List<ImportedFile>> retrieveImportedFiles() async {
    final agentId = await _getSelectedAgentId();

    // API endpoint
    final String url = 'http://localhost:5043/api/PolicyImport/agent/$agentId';

    // Send GET request to the API
    final response = await http.get(Uri.parse(url));

    // Check for successful response
    if (response.statusCode == 200) {
      // Parse the response body
      List<dynamic> jsonResponse = json.decode(response.body);

      // Convert the JSON response to a list of ImportedFile objects
      List<ImportedFile> importedFiles = jsonResponse.map((file) {
        return ImportedFile.fromJson(file);
      }).toList();

      return importedFiles;
    } else {
      throw Exception('Failed to load imported files');
    }
  }

  Future<bool> processFile(File file, String agentId) async {
    try {
      final agentId = await _getSelectedAgentId();

      if (agentId == null) {
        throw Exception('No agent selected');
      }

      final Uri url =
          Uri.parse('http://localhost:5043/api/ImportPolicy/$agentId');

      // Prepare the multipart request
      var request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('file', file.path))
        ..headers['Content-Type'] = 'multipart/form-data';

      // Send the request
      final response = await request.send();

      // Handle response
      if (response.statusCode == 200) {
        print('File uploaded successfully');
        return true;
      } else {
        throw Exception('Failed to upload file: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading file: $e');
      return false;
    }
  }

  Future<bool> syncClients(String fileImportId) async {
    // Get the agentId using the existing method
    String? agentId = await _getSelectedAgentId();

    // API endpoint with dynamic parameters
    final String url =
        'http://localhost:5043/api/client/sync/$agentId/$fileImportId';

    // Send POST request to sync clients
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body:
            jsonEncode({}), // If you need to send a body, update it accordingly
      );

      // Handle the response
      if (response.statusCode == 200) {
        // Successfully synced clients
        print("Clients synced successfully.");
        return true;
        // Perform any necessary UI updates or logic here
      } else {
        // Handle the error if the API response is not 200
        print('Failed to sync clients: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Handle any errors during the HTTP request
      print('Error syncing clients: $e');
      return false;
    }
  }

  // Retrieve the agentId from SharedPreferences
  Future<String?> _getSelectedAgentId() async {
    final prefs = await SharedPreferences.getInstance();
    String? agentJson = prefs.getString('selectedAgent');

    if (agentJson != null) {
      Map<String, dynamic> agentMap = json.decode(agentJson);
      return agentMap['agentId']; // Assuming agentId is present in the agentMap
    }
    return null;
  }
}
