class Client {
  String clientID;
  String systemName;
  String initial;
  String clientType;
  String firstName;
  String middleName;
  String lastName;
  String firmName;
  String address1;
  String address2;
  int pinCode;
  String country;
  Map<String, String> phoneNumbers;
  Map<String, String> emailAddresses; // Change this to a map
  String agentID;
  bool isActive;
  DateTime createdAt;

  // Constructor
  Client({
    required this.clientID,
    required this.systemName,
    required this.initial,
    required this.clientType,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.firmName,
    required this.address1,
    required this.address2,
    required this.pinCode,
    required this.country,
    required this.phoneNumbers,
    required this.emailAddresses,
    required this.agentID,
    required this.isActive,
    required this.createdAt,
  });

  // From JSON
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      clientID: json['clientId'], // Change 'id' to 'clientId'
      systemName: json['systemName'],
      initial: json['initial'] ?? '', // Handle null values
      clientType: json['clientType'] ?? '', // Handle null values
      firstName: json['firstName'] ?? '', // Handle null values
      middleName: json['middleName'] ?? '', // Handle null values
      lastName: json['lastName'] ?? '', // Handle null values
      firmName: json['firmName'] ?? '', // Handle null values
      address1: json['address1'],
      address2: json['address2'] ?? '', // Handle null values
      pinCode: json['pinCode'],
      country: json['country'] ?? '', // Handle null values
      phoneNumbers: Map<String, String>.from(
          json['phoneNumbers'] ?? {}), // Handle null or empty phone numbers
      emailAddresses: Map<String, String>.from(
          json['emailAddresses'] ?? {}), // Handle null or empty email addresses
      agentID: json['agentId'], // Change 'agentid' to 'agentId'
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'clientId':
          clientID, // Change 'id' to 'clientId' to match the API response
      'systemName': systemName,
      'initial': initial.isEmpty
          ? null
          : initial, // Handle empty strings, convert to null if necessary
      'clientType': clientType.isEmpty
          ? null
          : clientType, // Handle empty strings, convert to null if necessary
      'firstName': firstName.isEmpty
          ? null
          : firstName, // Handle empty strings, convert to null if necessary
      'middleName': middleName.isEmpty
          ? null
          : middleName, // Handle empty strings, convert to null if necessary
      'lastName': lastName.isEmpty
          ? null
          : lastName, // Handle empty strings, convert to null if necessary
      'firmName': firmName.isEmpty
          ? null
          : firmName, // Handle empty strings, convert to null if necessary
      'address1': address1,
      'address2': address2.isEmpty
          ? null
          : address2, // Handle empty strings, convert to null if necessary
      'pinCode': pinCode,
      'country': country.isEmpty
          ? null
          : country, // Handle empty strings, convert to null if necessary
      'phoneNumbers':
          phoneNumbers.isEmpty ? null : phoneNumbers, // Handle empty maps
      'emailAddresses':
          emailAddresses.isEmpty ? null : emailAddresses, // Handle empty maps
      'agentId':
          agentID, // Change 'agentid' to 'agentId' to match the API response
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
