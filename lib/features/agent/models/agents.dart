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
  // Factory constructor to create an instance from JSON
  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      agentId: json['agentId'],
      appId: json['appId'],
      tenantId: json['tenantId'],
      branchId: json['branchId'],
      agentCode: json['agentCode'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      address1: json['address1'],
      address2: json['address2'],
      emails: Map<String, String>.from(json['emails']),
      phoneNumbers: Map<String, String>.from(json['phoneNumbers']),
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
   // Factory method to create an Agent from JSON (String)
  factory Agent.fromJsonString(String source) {
    return Agent.fromJson(json.decode(source));
  }
}
