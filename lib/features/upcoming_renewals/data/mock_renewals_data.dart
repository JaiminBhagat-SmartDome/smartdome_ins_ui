import '../models/renewals.dart';

List<Renewals> mockRenewalData = [
  Renewals(policyId: '101', name: 'Alice Johnson', dueDate: DateTime.now().add(const Duration(days: 5))),
  Renewals(policyId: '102', name: 'Bob Smith', dueDate: DateTime.now().add(const Duration(days: 35))),
  Renewals(policyId: '103', name: 'Charlie Brown', dueDate: DateTime.now().add(const Duration(days: 10))),
  Renewals(policyId: '104', name: 'Diana Prince', dueDate: DateTime.now().add(const Duration(days: 65))),
  Renewals(policyId: '105', name: 'Edward Norton', dueDate: DateTime.now().add(const Duration(days: 20))),
];
