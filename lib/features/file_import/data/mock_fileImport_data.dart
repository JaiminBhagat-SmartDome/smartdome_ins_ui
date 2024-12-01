import '../models/fileImports.dart';

List<FileImport> mockfileImportData = [
    FileImport(
      agentId: 'a2b3c8b7-dc35-4bb7-93b1-e3a54c5d4602',  // Static GUID for agentId
      tenantId: '550e8400-e29b-41d4-a716-446655440000',  // Static GUID for tenantId
      fileImportId: 'd2d2b3d5-e5b7-47b9-aaf9-57b32f66ecbb',  // Static GUID for fileImportId
      fileName: 'file_001.txt',
      createdAt: DateTime(2024, 11, 25, 14, 30),
      status: 'Completed',
    ),
    FileImport(
      agentId: '7eae64bc-9453-4b56-9a2f-d6db3ff1e238',  // Static GUID for agentId
      tenantId: '1e3e4500-4d59-4fe6-8a5a-926154dff457',
      fileImportId: '16f05e09-549b-4671-a8d8-5ac53f6b1ef4',
      fileName: 'file_002.txt',
      createdAt: DateTime(2024, 11, 22, 09, 00),
      status: 'Pending',
    ),
    FileImport(
      agentId: 'd6f7cced-9b3f-4d0f-9d9b-d470e1771f29',  // Static GUID for agentId
      tenantId: '3d2e17f0-d66b-49bc-83a6-bf41758d9f11',
      fileImportId: 'bc1f2303-6b3b-4563-8b1d-c8b321dc0d56',
      fileName: 'file_003.txt',
      createdAt: DateTime(2024, 11, 28, 16, 45),
      status: 'In Progress',
    ),
    FileImport(
      agentId: '9f6d84b3-4d99-41e7-96db-e7748e30a8d6',  // Static GUID for agentId
      tenantId: '73a70390-3f4d-4c36-98b8-9a16f0e716e9',
      fileImportId: '0c52a911-9c85-47e0-b649-e2a1a8c89f52',
      fileName: 'file_004.txt',
      createdAt: DateTime(2024, 11, 15, 18, 20),
      status: 'Failed',
    ),
    FileImport(
      agentId: '6d7cc6b9-9c88-466e-9789-bc8f89e5e03b',  // Static GUID for agentId
      tenantId: 'ab9ed828-719b-4f16-85c4-6744107a7f92',
      fileImportId: 'c7ac12fa-f37b-478d-8418-eabe0c8129cf',
      fileName: 'file_005.txt',
      createdAt: DateTime(2024, 11, 12, 11, 50),
      status: 'Completed',
    ),
  ];
