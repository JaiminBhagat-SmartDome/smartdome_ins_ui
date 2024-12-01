import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FileImportScreen extends StatefulWidget {
  @override
  _FileImportScreenState createState() => _FileImportScreenState();
}

class _FileImportScreenState extends State<FileImportScreen> {
  // Mock data for imported files
  List<Map<String, dynamic>> importedFiles = [
    {"filename": "file1.csv", "createdDate": "2024-11-04", "status": "pending"},
    {"filename": "file2.xlsx", "createdDate": "2024-11-03", "status": "completed"},
  ];

  // Function to select a file and call API
  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
     // print(file.name);
     // print(file.bytes);
    //  print(file.extension);
     // print(file.path);
      bool success = await _callFileProcessingAPI(file.name);
      if (success) {
        _showPopup("File processed successfully");
        // Update imported files list
        setState(() {
          importedFiles.add({
            "filename": file.name,
            "createdDate": DateTime.now().toIso8601String().split("T").first,
            "status": "completed",
          });
        });
      }
    }
  }

  // Function to sync a file
  Future<void> _syncFile(String filename) async {
    // Call API for sync
    bool success = await _callFileSyncAPI(filename);
    if (success) {
      _showPopup("File synced successfully");
      setState(() {
        importedFiles = importedFiles.map((file) {
          if (file["filename"] == filename) {
            file["status"] = "completed";
          }
          return file;
        }).toList();
      });
    }
  }

  // Mock API call for file processing
  Future<bool> _callFileProcessingAPI(String file) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return true; // Simulate success response
  }

  // Mock API call for file syncing
  Future<bool> _callFileSyncAPI(String file) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return true; // Simulate success response
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
        title: const Text("Import"),
      ),
      body: Column(
        children: [
          // Display imported file information
          Expanded(
            child: ListView.builder(
              itemCount: importedFiles.length,
              itemBuilder: (context, index) {
                final file = importedFiles[index];
                return ListTile(
                  title: Text(file["filename"]),
                  subtitle: Text("Created: ${file["createdDate"]}"),
                  trailing: file["status"] == "pending"
                      ? ElevatedButton(
                    onPressed: () => _syncFile(file["filename"]),
                    child: const Text("Sync"),
                  )
                      : const Text("Completed"),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectFile,
        child: const Icon(Icons.add),
      ),
    );
  }
}