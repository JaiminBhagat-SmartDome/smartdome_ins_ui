class Agent {
  String agentId; // Use 'agentId' for readability in Dart
  String agentCode;
  String firstName;
  String middleName;
  String lastName;
  String address1;
  String address2;
  Map<String, String> emails;
  Map<String, String> phoneNumbers;
  String appId;
  String tenantId;
  String branchId;

  Agent({
    required this.agentId,
    required this.agentCode,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.address1,
    required this.address2,
    required this.emails,
    required this.phoneNumbers,
    required this.appId,
    required this.tenantId,
    required this.branchId,
  });

  // Convert JSON data to an Agent object
  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      agentId: json['agentId'],  // CosmosDB returns 'id', but we use 'agentId' in the model
      agentCode: json['agentCode'],
      firstName: json['firstName'],
      middleName: json['middleName'] ?? '',
      lastName: json['lastName'],
      address1: json['address1'],
      address2: json['address2'] ?? '',
      emails: {
        'primary': json['emails']['primary'] ?? '',
        'secondary': json['emails']['secondary'] ?? '',
      },
      phoneNumbers: {
        'mobile': json['phoneNumbers']['mobile'] ?? '',
        'work': json['phoneNumbers']['work'] ?? '',
        'other': json['phoneNumbers']['other'] ?? '',
      },
      appId: json['appId'],
      tenantId: json['tenantId'],
      branchId: json['branchId'],
    );
  }

  // Convert Agent object to JSON for sending in requests
  Map<String, dynamic> toMap() {
    return {
      'agentId': agentId,
      'agentCode': agentCode,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'address1': address1,
      'address2': address2,
      'emails': emails,
      'phoneNumbers': phoneNumbers,
      'appId': appId,
      'tenantId': tenantId,
      'branchId': branchId,
    };
  }
}
