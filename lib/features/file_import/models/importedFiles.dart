class ImportedFile {
  final String fileImportId;
  final String filename;
  final String createdDate;
  final String status;
  final int totalCount;

  ImportedFile({
    required this.fileImportId,
    required this.filename,
    required this.createdDate,
    required this.status,
    required this.totalCount,
  });

  factory ImportedFile.fromJson(Map<String, dynamic> json) {
    return ImportedFile(
      fileImportId: json['fileImportId'],
      filename: json['filename'],
      createdDate: json['createdDate'],
      status: json['status'],
      totalCount: json['totalCount'],
    );
  }
}
