import 'dart:convert';

// FileImport model class with the required fields
class FileImport {
  String agentId;
  String tenantId;
  String fileImportId;
  String fileName;
  DateTime createdAt;
  String status;

  // Constructor for the Agent model
  FileImport({
    required this.agentId,
    required this.tenantId,
    required this.fileImportId,
    required this.fileName,
    required this.createdAt,
    required this.status,
  });

  // Method to create Agent from a Map (useful for parsing JSON or creating mock data)
  factory FileImport.fromMap(Map<String, dynamic> map) {
    return FileImport(
      agentId: map['agentId'],
      tenantId: map['tenantId'],
      fileImportId: map['fileImportId'],
      fileName: map['fileName'],
      createdAt: map['createdAt'],
      status: map['status'],
    );
  }

  // Method to convert Agent object into a Map (useful for saving to a database or JSON serialization)
  Map<String, dynamic> toMap() {
    return {
      'agentId': agentId,
      'tenantId': tenantId,
      'fileImportId': fileImportId,
      'fileName': fileName,
      'createdAt': createdAt,
      'status': status,
    };
  }

  // Method to convert FileImport object into JSON
  String toJson() => json.encode(toMap());

  // Factory method to create an FileImport from JSON
  factory FileImport.fromJson(String source) => FileImport.fromMap(json.decode(source));
}
