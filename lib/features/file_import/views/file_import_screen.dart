import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/fileImport_repository.dart';
import '../models/importedFiles.dart'; // Assuming the repository is in a separate file

class FileImportScreen extends StatefulWidget {
  const FileImportScreen({super.key});

  @override
  _FileImportScreenState createState() => _FileImportScreenState();
}

class _FileImportScreenState extends State<FileImportScreen> {
  late Future<List<ImportedFile>> importedFilesFuture;
  final FileImportRepository repository = FileImportRepository();

  @override
  void initState() {
    super.initState();
    importedFilesFuture =
        repository.retrieveImportedFiles(); // Fetch the initial data
  }

  // Function to select a file and call the repository method to upload it
  Future<void> _selectFile() async {
    // Pick a file using the file picker
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls', 'csv'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      String? agentId = await _getSelectedAgentId();
      // File selectedFile = File(file.path!); // Ensure path is not null
      if (agentId != null) {
        // For web: use bytes for file upload
        bool success =
            await repository.processFileBytes(file.bytes!, file.name, agentId);
        if (success) {
          _showPopup("File uploaded successfully");
          setState(() {
            // Refresh the data after successful upload
            importedFilesFuture = repository.retrieveImportedFiles();
          });
        } else {
          _showPopup("File upload failed");
        }
      } else {
        _showPopup("No agent selected");
      }
    }
  }

  // Function to retrieve the selected agentId from SharedPreferences
  Future<String?> _getSelectedAgentId() async {
    final prefs = await SharedPreferences.getInstance();
    String? agentJson = prefs.getString('selectedAgent');
    if (agentJson != null) {
      Map<String, dynamic> agentMap = json.decode(agentJson);
      return agentMap['agentId']; // Assuming agentId is in the selected agent map
    }
    return null;
  }

  // Function to sync a file
  Future<void> _syncFile(String fileImportId) async {
    bool success = await repository.syncClients(fileImportId);
    if (success) {
      _showPopup("File synced successfully");
      setState(() {
        importedFilesFuture =
            repository.retrieveImportedFiles(); // Refresh data
      });
    }
  }

  // Show popup with API response
  void _showPopup(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Okay"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Import Files"),
      ),
      body: FutureBuilder<List<ImportedFile>>(
        future: importedFilesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No files found"));
          } else {
            // Data is available, render the list
            List<ImportedFile> importedFiles = snapshot.data!;

            return ListView.builder(
              itemCount: importedFiles.length,
              itemBuilder: (context, index) {
                final file = importedFiles[index];
                return ListTile(
                  title: Text(file.filename),
                  subtitle: Text("Created: ${file.createdDate}"),
                  trailing: file.status == "Pending"
                      ? ElevatedButton(
                          onPressed: () {
                            // Use the unique fileImportId for any required action
                            _syncFile(file.fileImportId);
                          },
                          child: const Text("Sync"),
                        )
                      : const Text("Completed"),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectFile,
        child: const Icon(Icons.add),
      ),
    );
  }
}
