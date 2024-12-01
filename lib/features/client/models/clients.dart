import 'dart:convert';

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
  Map<String, String> emailAddresses;  // Change this to a map
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
      clientID: json['id'],
      systemName: json['systemName'],
      initial: json['initial'],
      clientType: json['clientType'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      firmName: json['firmName'],
      address1: json['address1'],
      address2: json['address2'],
      pinCode: json['pinCode'],
      country: json['country'],
      phoneNumbers: Map<String, String>.from(json['phoneNumbers']),
      emailAddresses: Map<String, String>.from(json['emailAddresses']),
      agentID: json['agentid'],
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': clientID,
      'systemName': systemName,
      'initial': initial,
      'clientType': clientType,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'firmName': firmName,
      'address1': address1,
      'address2': address2,
      'pinCode': pinCode,
      'country': country,
      'phoneNumbers': phoneNumbers,
      'emailAddresses': emailAddresses,
      'agentid': agentID,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
