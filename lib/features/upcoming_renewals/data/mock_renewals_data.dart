import 'dart:convert';
import 'package:intl/intl.dart'; // For date formatting

// Mock data for Renewals and Client
List<Map<String, dynamic>> mockRenewalsData = [
  {
    "id": "c1a56d4e-8d3f-4e47-a72e-f8ed1b38332a", // GUID for Renewal
    "operatingOffice": "New York",
    "lobDescription": "Auto Insurance",
    "policyNumber": "POL123456",
    "productCode": "A001",
    "productName": "Auto Insurance Basic",
    "policyInceptionDate": "2024-01-01",
    "policyExpiryDate": DateFormat("yyyy-MM-dd")
        .format(DateTime(2024, 12, 15)), // Expiry Date in this month
    "policyHolderCode": "PH123",
    "devOfficerCode": "D123",
    "devOfficerName": "Jane Smith",
    "sumInsured": 100000.0,
    "grossPremium": 1200.0,
    "serviceTax": 150.0,
    "registrationNo": "XYZ1234",
    "chassisNo": "CH12345",
    "engineNo": "EN12345",
    "odExpiryDate": "2024-12-31",
    "createdAt": "2024-12-01",
    "importStatus": "Pending",
    "fileImportid":
        "f3c4c9b8-7b23-4bb9-a5a0-0f024b924d80", // GUID for FileImport
    "clientid": "b45a9d5f-9d29-42e1-bdfd-9a5238d2da55", // GUID for Client
    "agentid": "0a9b135b-5c99-4d73-8e2f-e84f4e5b0842", // GUID for Agent
    "client": {
      "clientID": "b45a9d5f-9d29-42e1-bdfd-9a5238d2da55", // GUID for Client
      "systemName": "System1",
      "initial": "JD",
      "clientType": "Individual",
      "firstName": "John",
      "middleName": "Doe",
      "lastName": "Smith",
      "firmName": "Smith Insurance",
      "address1": "123 Main St",
      "address2": "Suite 101",
      "pinCode": 123456,
      "country": "USA",
      "phoneNumbers": {"home": "123-456-7890", "office": "987-654-3210"},
      "emailAddresses": {
        "personal": "john@example.com",
        "work": "john.smith@insurance.com"
      },
      "agentID": "0a9b135b-5c99-4d73-8e2f-e84f4e5b0842", // GUID for Agent
      "isActive": true,
      "createdAt": "2020-01-01"
    }
  },
  {
    "id": "b0233c1a-c557-4a72-b56e-f0d2bc3d7072", // GUID for Renewal
    "operatingOffice": "Los Angeles",
    "lobDescription": "Health Insurance",
    "policyNumber": "POL987654",
    "productCode": "H002",
    "productName": "Health Insurance Premium",
    "policyInceptionDate": "2024-02-15",
    "policyExpiryDate": DateFormat("yyyy-MM-dd")
        .format(DateTime(2024, 12, 25)), // Expiry Date in next month
    "policyHolderCode": "PH987",
    "devOfficerCode": "D456",
    "devOfficerName": "John Doe",
    "sumInsured": 50000.0,
    "grossPremium": 800.0,
    "serviceTax": 100.0,
    "registrationNo": "ABC123",
    "chassisNo": "CH98765",
    "engineNo": "EN98765",
    "odExpiryDate": "2024-12-31",
    "createdAt": "2024-11-01",
    "importStatus": "Completed",
    "fileImportid":
        "3e0d2612-d54b-4de2-b0ea-29f8f7e04d1d", // GUID for FileImport
    "clientid": "d1cb6d62-9e4b-4d1a-a78f-d523762f0d92", // GUID for Client
    "agentid": "fd4db3a2-3fe4-4f5d-bd90-b7172c8be24d", // GUID for Agent
    "client": {
      "clientID": "d1cb6d62-9e4b-4d1a-a78f-d523762f0d92", // GUID for Client
      "systemName": "System2",
      "initial": "JD",
      "clientType": "Company",
      "firstName": "Alice",
      "middleName": "Eve",
      "lastName": "Johnson",
      "firmName": "Johnson Health Ins.",
      "address1": "456 Oak St",
      "address2": "Floor 2",
      "pinCode": 654321,
      "country": "USA",
      "phoneNumbers": {"home": "111-222-3333", "office": "444-555-6666"},
      "emailAddresses": {
        "personal": "alice@example.com",
        "work": "alice.johnson@health.com"
      },
      "agentID": "fd4db3a2-3fe4-4f5d-bd90-b7172c8be24d", // GUID for Agent
      "isActive": true,
      "createdAt": "2021-06-15"
    }
  }
];
