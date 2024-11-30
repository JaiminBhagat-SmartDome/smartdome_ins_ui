import '../models/renewals.dart';
import '../data/mock_renewals_data.dart';

class RenewalRepository {
  // Fetch renewals for this month
  Future<List<Renewals>> fetchThisMonthRenewals() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate API delay
    final now = DateTime.now();
    return mockRenewalData.where((renewal) =>
    renewal.dueDate.month == now.month && renewal.dueDate.year == now.year).toList();
  }

  // Fetch renewals for next month
  Future<List<Renewals>> fetchNextMonthRenewals() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate API delay
    final now = DateTime.now();
    final nextMonth = DateTime(now.year, now.month + 1);
    return mockRenewalData.where((renewal) =>
    renewal.dueDate.month == nextMonth.month && renewal.dueDate.year == nextMonth.year).toList();
  }
}
