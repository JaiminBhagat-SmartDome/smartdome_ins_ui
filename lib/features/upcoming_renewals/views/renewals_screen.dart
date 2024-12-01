import 'package:flutter/material.dart';
import '../models/renewals.dart';
import '../data/renewals_repository.dart';
import 'renewals_detail_screen.dart'; // Import the detail screen where you will show the renewal details

class UpcomingRenewalsScreen extends StatefulWidget {
  const UpcomingRenewalsScreen({Key? key}) : super(key: key);

  @override
  State<UpcomingRenewalsScreen> createState() => _UpcomingRenewalsScreenState();
}

class _UpcomingRenewalsScreenState extends State<UpcomingRenewalsScreen>
    with SingleTickerProviderStateMixin {
  final RenewalRepository _renewalRepository = RenewalRepository();
  late TabController _tabController;
  List<Renewal> thisMonthRenewals = [];
  List<Renewal> nextMonthRenewals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadRenewals();
  }

  Future<void> _loadRenewals() async {
    try {
      final thisMonth = await _renewalRepository.fetchThisMonthRenewals();
      final nextMonth = await _renewalRepository.fetchNextMonthRenewals();
      setState(() {
        thisMonthRenewals = thisMonth..sort((a, b) => a.policyExpiryDate.compareTo(b.policyExpiryDate));
        nextMonthRenewals = nextMonth..sort((a, b) => a.policyExpiryDate.compareTo(b.policyExpiryDate));
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching renewals: $e')),
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildRenewalsList(List<Renewal> renewals) {
    if (renewals.isEmpty) {
      return const Center(
        child: Text(
          'No renewals found',
          style: TextStyle(fontSize: 16),
        ),
      );
    }
    return ListView.builder(
      itemCount: renewals.length,
      itemBuilder: (context, index) {
        final renewal = renewals[index];
        final clientName = '${renewal.client?.firstName} ${renewal.client?.lastName}'; // Combine first and last name
        return ListTile(
          title: Text(clientName), // Show client name
          subtitle: Text('Policy Expiry Date: ${renewal.policyExpiryDate.toLocal().toString().split(' ')[0]}'),
          onTap: () {
            // Navigate to detail screen and pass the selected renewal object
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RenewalDetailScreen(renewal: renewal),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Renewals'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'This Month'),
            Tab(text: 'Next Month'),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildRenewalsList(thisMonthRenewals),
                _buildRenewalsList(nextMonthRenewals),
              ],
            ),
    );
  }
}
