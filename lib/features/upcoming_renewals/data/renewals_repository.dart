import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/renewals.dart';

class RenewalRepository {
  static const String _baseUrl = 'http://localhost:5043/api/Renewals/agent/';

  // Function to fetch renewals for this month
  Future<List<Renewal>> fetchThisMonthRenewals() async {
    final agentId = await _getSelectedAgentId();
    if (agentId == null) {
      throw Exception('Agent ID not found');
    }
    final response = await http.get(Uri.parse('$_baseUrl$agentId'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data
          .map((renewalData) => Renewal.fromJson(renewalData))
          .where((renewal) {
            final now = DateTime.now();
            return renewal.policyExpiryDate != null &&
                renewal.policyExpiryDate!.month == now.month;
          }).toList();
    } else {
      throw Exception('Failed to load renewals');
    }
  }

  // Function to fetch renewals for next month
  Future<List<Renewal>> fetchNextMonthRenewals() async {
    final agentId = await _getSelectedAgentId();
    if (agentId == null) {
      throw Exception('Agent ID not found');
    }
    final response = await http.get(Uri.parse('$_baseUrl$agentId'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data
          .map((renewalData) => Renewal.fromJson(renewalData))
          .where((renewal) {
            final now = DateTime.now();
            return renewal.policyExpiryDate != null &&
                renewal.policyExpiryDate!.month == now.month + 1;
          }).toList();
    } else {
      throw Exception('Failed to load renewals');
    }
  }

  // Function to retrieve the agentId from SharedPreferences
  Future<String?> _getSelectedAgentId() async {
    final prefs = await SharedPreferences.getInstance();
    String? agentJson = prefs.getString('selectedAgent');

    if (agentJson != null) {
      Map<String, dynamic> agentMap = json.decode(agentJson);
      return agentMap['agentId']; // Assuming agentId is present in the agentMap
    }
    return null;
  }
}
