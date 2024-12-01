import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

// Assuming this is your repository class
class FileImportRepository {
  // Mock method to fetch data from repository
  Future<List<Map<String, dynamic>>> getFileImports() async {
    // Simulate network or DB delay
    await Future.delayed(Duration(seconds: 2));
    return [
      {"filename": "file1.csv", "createdDate": "2024-11-04", "status": "pending"},
      {"filename": "file2.xlsx", "createdDate": "2024-11-03", "status": "completed"},
    ];
  }

  // Mock API call for file processing
  Future<bool> processFile(String file) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return true; // Simulate success response
  }

  // Mock API call for file syncing
  Future<bool> syncFile(String file) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return true; // Simulate success response
  }
}

class FileImportScreen extends StatefulWidget {
  @override
  _FileImportScreenState createState() => _FileImportScreenState();
}

class _FileImportScreenState extends State<FileImportScreen> {
  late Future<List<Map<String, dynamic>>> importedFilesFuture;
  final FileImportRepository repository = FileImportRepository();

  @override
  void initState() {
    super.initState();
    importedFilesFuture = repository.getFileImports(); // Fetch the initial data
  }

  // Function to select a file and call API
  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      bool success = await repository.processFile(file.name);
      if (success) {
        _showPopup("File processed successfully");
        setState(() {
          // Add new file to the list
          importedFilesFuture = repository.getFileImports();
        });
      }
    }
  }

  // Function to sync a file
  Future<void> _syncFile(String filename) async {
    bool success = await repository.syncFile(filename);
    if (success) {
      _showPopup("File synced successfully");
      setState(() {
        importedFilesFuture = repository.getFileImports(); // Refresh data
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
        title: const Text("Import"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: importedFilesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No files found"));
          } else {
            // Data is available, render the list
            List<Map<String, dynamic>> importedFiles = snapshot.data!;

            return ListView.builder(
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
