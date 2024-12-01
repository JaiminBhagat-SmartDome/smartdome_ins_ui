import 'dart:convert';
import '../../client/models/clients.dart';  // Import the Client class from clients.dart

// Renewal Class with Client
class Renewal {
  String id;
  String operatingOffice;
  String lobDescription;
  String policyNumber;
  String productCode;
  String productName;
  DateTime policyInceptionDate;
  DateTime policyExpiryDate;
  String policyHolderCode;
  String devOfficerCode;
  String devOfficerName;
  double sumInsured;
  double grossPremium;
  double serviceTax;
  String registrationNo;
  String chassisNo;
  String engineNo;
  DateTime? odExpiryDate;
  DateTime createdAt;
  String importStatus;
  String fileImportID;
  String clientID;
  String agentID;
  Client? client;  // Client as a field

  Renewal({
    required this.id,
    required this.operatingOffice,
    required this.lobDescription,
    required this.policyNumber,
    required this.productCode,
    required this.productName,
    required this.policyInceptionDate,
    required this.policyExpiryDate,
    required this.policyHolderCode,
    required this.devOfficerCode,
    required this.devOfficerName,
    required this.sumInsured,
    required this.grossPremium,
    required this.serviceTax,
    required this.registrationNo,
    required this.chassisNo,
    required this.engineNo,
    this.odExpiryDate,
    required this.createdAt,
    required this.importStatus,
    required this.fileImportID,
    required this.clientID,
    required this.agentID,
    this.client,  // Initialize Client
  });

  // From JSON to Dart
  factory Renewal.fromJson(Map<String, dynamic> json) {
    return Renewal(
      id: json['id'] ?? '',
      operatingOffice: json['operatingOffice'] ?? '',
      lobDescription: json['lobDescription'] ?? '',
      policyNumber: json['policyNumber'] ?? '',
      productCode: json['productCode'] ?? '',
      productName: json['productName'] ?? '',
      policyInceptionDate: json['policyInceptionDate'],
      policyExpiryDate: json['policyExpiryDate'],
      policyHolderCode: json['policyHolderCode'] ?? '',
      devOfficerCode: json['devOfficerCode'] ?? '',
      devOfficerName: json['devOfficerName'] ?? '',
      sumInsured: json['sumInsured']?.toDouble() ?? 0.0,
      grossPremium: json['grossPremium']?.toDouble() ?? 0.0,
      serviceTax: json['serviceTax']?.toDouble() ?? 0.0,
      registrationNo: json['registrationNo'] ?? '',
      chassisNo: json['chassisNo'] ?? '',
      engineNo: json['engineNo'] ?? '',
      odExpiryDate: json['odExpiryDate'] != null
          ? DateTime.parse(json['odExpiryDate'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      importStatus: json['importStatus'] ?? '',
      fileImportID: json['fileImportid'] ?? '',
      clientID: json['clientid'] ?? '',
      agentID: json['agentid'] ?? '',
      client: json['client'] != null
          ? Client.fromJson(json['client']) // Deserialize nested Client object
          : null,
    );
  }

  // From Dart to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'operatingOffice': operatingOffice,
      'lobDescription': lobDescription,
      'policyNumber': policyNumber,
      'productCode': productCode,
      'productName': productName,
      'policyInceptionDate': policyInceptionDate?.toIso8601String(),
      'policyExpiryDate': policyExpiryDate?.toIso8601String(),
      'policyHolderCode': policyHolderCode,
      'devOfficerCode': devOfficerCode,
      'devOfficerName': devOfficerName,
      'sumInsured': sumInsured,
      'grossPremium': grossPremium,
      'serviceTax': serviceTax,
      'registrationNo': registrationNo,
      'chassisNo': chassisNo,
      'engineNo': engineNo,
      'odExpiryDate': odExpiryDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'importStatus': importStatus,
      'fileImportid': fileImportID,
      'clientid': clientID,
      'agentid': agentID,
      'client': client?.toJson(), // Serialize the Client object
    };
  }
}
