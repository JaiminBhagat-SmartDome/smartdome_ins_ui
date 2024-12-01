import 'dart:async';
import '../models/fileImports.dart';
import 'mock_fileImport_data.dart';

class FileImportRepository {
  Future<List<FileImport>> fetchFileImports() async {
    // Simulating API call delay
    await Future.delayed(const Duration(seconds: 2));
    // Replace this with actual API logic in production
    return mockfileImportData;
  }
  Future<bool> updateFileImport(FileImport fileImport) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
