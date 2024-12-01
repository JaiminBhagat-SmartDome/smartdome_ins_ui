import '../models/renewals.dart';
import '../data/mock_renewals_data.dart';
import '../../client/models/clients.dart';

class RenewalRepository {
  // Fetch renewals for this month
  Future<List<Renewal>> fetchThisMonthRenewals() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate API delay
    final now = DateTime.now();
    
    // Filter renewals for this month
    return mockRenewalsData.where((renewal) {
      DateTime expiryDate = DateTime.parse(renewal['policyExpiryDate']);
      return expiryDate.month == now.month && expiryDate.year == now.year;
    }).map((renewalData) {
      // Map data to Renewal model
      return Renewal(
        id: renewalData['id'],
        operatingOffice: renewalData['operatingOffice'],
        lobDescription: renewalData['lobDescription'],
        policyNumber: renewalData['policyNumber'],
        productCode: renewalData['productCode'],
        productName: renewalData['productName'],
        policyInceptionDate: DateTime.parse(renewalData['policyInceptionDate']),
        policyExpiryDate: DateTime.parse(renewalData['policyExpiryDate']),
        policyHolderCode: renewalData['policyHolderCode'],
        devOfficerCode: renewalData['devOfficerCode'],
        devOfficerName: renewalData['devOfficerName'],
        sumInsured: renewalData['sumInsured'],
        grossPremium: renewalData['grossPremium'],
        serviceTax: renewalData['serviceTax'],
        registrationNo: renewalData['registrationNo'],
        chassisNo: renewalData['chassisNo'],
        engineNo: renewalData['engineNo'],
        odExpiryDate: DateTime.parse(renewalData['odExpiryDate']),
        createdAt: DateTime.parse(renewalData['createdAt']),
        importStatus: renewalData['importStatus'],
        fileImportID: renewalData['fileImportid'],
        clientID: renewalData['clientid'],
        agentID: renewalData['agentid'],
        client: Client(
          clientID: renewalData['client']['clientID'],
          systemName: renewalData['client']['systemName'],
          initial: renewalData['client']['initial'],
          clientType: renewalData['client']['clientType'],
          firstName: renewalData['client']['firstName'],
          middleName: renewalData['client']['middleName'],
          lastName: renewalData['client']['lastName'],
          firmName: renewalData['client']['firmName'],
          address1: renewalData['client']['address1'],
          address2: renewalData['client']['address2'],
          pinCode: renewalData['client']['pinCode'],
          country: renewalData['client']['country'],
          phoneNumbers: Map<String, String>.from(renewalData['client']['phoneNumbers']),
          emailAddresses: Map<String, String>.from(renewalData['client']['emailAddresses']),
          agentID: renewalData['client']['agentID'],
          isActive: renewalData['client']['isActive'],
          createdAt: DateTime.parse(renewalData['client']['createdAt']),
        ),
      );
    }).toList();
  }

  // Fetch renewals for next month
  Future<List<Renewal>> fetchNextMonthRenewals() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate API delay
    final now = DateTime.now();
    final nextMonth = DateTime(now.year, now.month + 1);
    
    // Filter renewals for next month
    return mockRenewalsData.where((renewal) {
      DateTime expiryDate = DateTime.parse(renewal['policyExpiryDate']);
      return expiryDate.month == nextMonth.month && expiryDate.year == nextMonth.year;
    }).map((renewalData) {
      // Map data to Renewal model
      return Renewal(
        id: renewalData['id'],
        operatingOffice: renewalData['operatingOffice'],
        lobDescription: renewalData['lobDescription'],
        policyNumber: renewalData['policyNumber'],
        productCode: renewalData['productCode'],
        productName: renewalData['productName'],
        policyInceptionDate: DateTime.parse(renewalData['policyInceptionDate']),
        policyExpiryDate: DateTime.parse(renewalData['policyExpiryDate']),
        policyHolderCode: renewalData['policyHolderCode'],
        devOfficerCode: renewalData['devOfficerCode'],
        devOfficerName: renewalData['devOfficerName'],
        sumInsured: renewalData['sumInsured'],
        grossPremium: renewalData['grossPremium'],
        serviceTax: renewalData['serviceTax'],
        registrationNo: renewalData['registrationNo'],
        chassisNo: renewalData['chassisNo'],
        engineNo: renewalData['engineNo'],
        odExpiryDate: DateTime.parse(renewalData['odExpiryDate']),
        createdAt: DateTime.parse(renewalData['createdAt']),
        importStatus: renewalData['importStatus'],
        fileImportID: renewalData['fileImportid'],
        clientID: renewalData['clientid'],
        agentID: renewalData['agentid'],
        client: Client(
          clientID: renewalData['client']['clientID'],
          systemName: renewalData['client']['systemName'],
          initial: renewalData['client']['initial'],
          clientType: renewalData['client']['clientType'],
          firstName: renewalData['client']['firstName'],
          middleName: renewalData['client']['middleName'],
          lastName: renewalData['client']['lastName'],
          firmName: renewalData['client']['firmName'],
          address1: renewalData['client']['address1'],
          address2: renewalData['client']['address2'],
          pinCode: renewalData['client']['pinCode'],
          country: renewalData['client']['country'],
          phoneNumbers: Map<String, String>.from(renewalData['client']['phoneNumbers']),
          emailAddresses: Map<String, String>.from(renewalData['client']['emailAddresses']),
          agentID: renewalData['client']['agentID'],
          isActive: renewalData['client']['isActive'],
          createdAt: DateTime.parse(renewalData['client']['createdAt']),
        ),
      );
    }).toList();
  }
}
