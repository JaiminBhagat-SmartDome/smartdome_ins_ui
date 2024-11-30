import 'package:flutter/material.dart';
import '../models/renewals.dart';
import '../data/renewals_repository.dart';

class UpcomingRenewalsScreen extends StatefulWidget {
  const UpcomingRenewalsScreen({Key? key}) : super(key: key);

  @override
  State<UpcomingRenewalsScreen> createState() => _UpcomingRenewalsScreenState();
}

class _UpcomingRenewalsScreenState extends State<UpcomingRenewalsScreen>
    with SingleTickerProviderStateMixin {
  final RenewalRepository _renewalRepository = RenewalRepository();
  late TabController _tabController;
  List<Renewals> thisMonthRenewals = [];
  List<Renewals> nextMonthRenewals = [];
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
        thisMonthRenewals = thisMonth..sort((a, b) => a.dueDate.compareTo(b.dueDate));
        nextMonthRenewals = nextMonth..sort((a, b) => a.dueDate.compareTo(b.dueDate));
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

  Widget _buildRenewalsList(List<Renewals> renewals) {
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
        return ListTile(
          title: Text(renewal.name),
          subtitle: Text('Due Date: ${renewal.dueDate.toLocal().toString().split(' ')[0]}'),
          onTap: () {
            // Handle onTap logic
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
