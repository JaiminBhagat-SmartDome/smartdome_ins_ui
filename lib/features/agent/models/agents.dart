import 'dart:convert';

// Agent model class with the required fields
class Agent {
  String agentId;
  String appId;
  String tenantId;
  String branchId;
  String agentCode;
  String firstName;
  String middleName;
  String lastName;
  String address1;
  String address2;
  Map<String, String> emails; // List of key-value pairs
  Map<String, String> phoneNumbers; // List of key-value pairs

  // Constructor for the Agent model
  Agent({
    required this.agentId,
    required this.appId,
    required this.tenantId,
    required this.branchId,
    required this.agentCode,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.address1,
    required this.address2,
    required this.emails,
    required this.phoneNumbers,
  });

  // Method to create Agent from a Map (useful for parsing JSON or creating mock data)
  factory Agent.fromMap(Map<String, dynamic> map) {
    return Agent(
      agentId: map['agentId'],
      appId: map['appId'],
      tenantId: map['tenantId'],
      branchId: map['branchId'],
      agentCode: map['agentCode'],
      firstName: map['firstName'],
      middleName: map['middleName'],
      lastName: map['lastName'],
      address1: map['address1'],
      address2: map['address2'],
      emails: Map<String, String>.from(map['emails']),
      phoneNumbers: Map<String, String>.from(map['phoneNumbers']),
    );
  }

  // Method to convert Agent object into a Map (useful for saving to a database or JSON serialization)
  Map<String, dynamic> toMap() {
    return {
      'agentId': agentId,
      'appId': appId,
      'tenantId': tenantId,
      'branchId': branchId,
      'agentCode': agentCode,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'address1': address1,
      'address2': address2,
      'emails': emails,
      'phoneNumbers': phoneNumbers,
    };
  }

  // Method to convert Agent object into JSON
  String toJson() => json.encode(toMap());

  // Factory method to create an Agent from JSON
  factory Agent.fromJson(String source) => Agent.fromMap(json.decode(source));
}
