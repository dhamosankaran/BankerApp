import 'package:flutter/material.dart';
import 'main.dart';

// ============================================================================
// ADDITIONAL FEATURES - SEGMENT DASHBOARDS, ANALYTICS, HIERARCHY, COMPLIANCE
// ============================================================================

// User Role enum for role-based views
enum UserRole {
  relationshipManager,
  coverageHead,
  productSpecialist,
  complianceOfficer,
}

// 1. SEGMENT-SPECIFIC DASHBOARDS (WEB RESPONSIVE)

class SegmentDashboardSelector extends StatefulWidget {
  const SegmentDashboardSelector({Key? key}) : super(key: key);

  @override
  State<SegmentDashboardSelector> createState() => _SegmentDashboardSelectorState();
}

class _SegmentDashboardSelectorState extends State<SegmentDashboardSelector> {
  ClientSegment _selectedSegment = ClientSegment.privateBanking;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 12 : 16),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Segment View:',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),
                      _buildSegmentButtons(),
                    ],
                  )
                : Row(
                    children: [
                      const Text(
                        'Segment View:',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 16),
                      Expanded(child: _buildSegmentButtons()),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 16),
        _buildSegmentDashboard(_selectedSegment),
      ],
    );
  }

  Widget _buildSegmentButtons() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return SegmentedButton<ClientSegment>(
      segments: [
        ButtonSegment(
          value: ClientSegment.privateBanking,
          label: Text('Private', style: TextStyle(fontSize: isMobile ? 10 : 11)),
          icon: Icon(Icons.account_balance_wallet, size: isMobile ? 14 : 16),
        ),
        ButtonSegment(
          value: ClientSegment.corporateBanking,
          label: Text('Corporate', style: TextStyle(fontSize: isMobile ? 10 : 11)),
          icon: Icon(Icons.business, size: isMobile ? 14 : 16),
        ),
        ButtonSegment(
          value: ClientSegment.institutional,
          label: Text('Inst', style: TextStyle(fontSize: isMobile ? 10 : 11)),
          icon: Icon(Icons.account_balance, size: isMobile ? 14 : 16),
        ),
        ButtonSegment(
          value: ClientSegment.investmentBanking,
          label: Text('IB', style: TextStyle(fontSize: isMobile ? 10 : 11)),
          icon: Icon(Icons.trending_up, size: isMobile ? 14 : 16),
        ),
      ],
      selected: {_selectedSegment},
      onSelectionChanged: (Set<ClientSegment> newSelection) {
        setState(() {
          _selectedSegment = newSelection.first;
        });
      },
    );
  }

  Widget _buildSegmentDashboard(ClientSegment segment) {
    switch (segment) {
      case ClientSegment.privateBanking:
        return const PrivateBankingDashboard();
      case ClientSegment.corporateBanking:
        return const CorporateBankingDashboard();
      case ClientSegment.institutional:
        return const InstitutionalDashboard();
      case ClientSegment.investmentBanking:
        return const InvestmentBankingDashboard();
    }
  }
}

// Private Banking Dashboard (Responsive)
class PrivateBankingDashboard extends StatelessWidget {
  const PrivateBankingDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.account_balance_wallet, color: Colors.purple[700], size: isMobile ? 18 : 20),
                const SizedBox(width: 8),
                Text(
                  'Private Banking Metrics',
                  style: TextStyle(fontSize: isMobile ? 14 : 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 14 : 20),
            _buildMetricsGrid(isMobile, [
              const MetricTileData(
                label: 'Total AUM',
                value: '\$2.4B',
                trend: '+12.3%',
                trendPositive: true,
              ),
              const MetricTileData(
                label: 'Avg Net Worth',
                value: '\$425M',
                trend: '+8.1%',
                trendPositive: true,
              ),
              const MetricTileData(
                label: 'Active Trusts',
                value: '47',
                trend: '+5',
                trendPositive: true,
              ),
              const MetricTileData(
                label: 'Estate Plans',
                value: '34',
                trend: '12 in progress',
                trendPositive: null,
              ),
              const MetricTileData(
                label: 'Next Gen (G2→G3)',
                value: '18',
                trend: 'High priority',
                trendPositive: null,
              ),
              const MetricTileData(
                label: 'Avg Family Size',
                value: '8.4',
                trend: '3.2 generations',
                trendPositive: null,
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsGrid(bool isMobile, List<MetricTileData> metrics) {
    if (isMobile) {
      return Column(
        children: metrics
            .map((m) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: MetricTile(data: m),
                ))
            .toList(),
      );
    } else {
      return Column(
        children: [
          Row(
            children: metrics
                .sublist(0, 3)
                .map((m) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: MetricTile(data: m),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 12),
          Row(
            children: metrics
                .sublist(3, 6)
                .map((m) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: MetricTile(data: m),
                      ),
                    ))
                .toList(),
          ),
        ],
      );
    }
  }
}

// Corporate Banking Dashboard (Responsive)
class CorporateBankingDashboard extends StatelessWidget {
  const CorporateBankingDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.business, color: Colors.blue[700], size: isMobile ? 18 : 20),
                const SizedBox(width: 8),
                Text(
                  'Corporate Banking Metrics',
                  style: TextStyle(fontSize: isMobile ? 14 : 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 14 : 20),
            _buildMetricsGrid(isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsGrid(bool isMobile) {
    final metrics = [
      const MetricTileData(
        label: 'Total Facilities',
        value: '\$8.2B',
        trend: '+15.2%',
        trendPositive: true,
      ),
      const MetricTileData(
        label: 'Avg EBITDA',
        value: '\$125M',
        trend: '+10.5%',
        trendPositive: true,
      ),
      const MetricTileData(
        label: 'Credit Util.',
        value: '68%',
        trend: '-5% YoY',
        trendPositive: false,
      ),
      const MetricTileData(
        label: 'Working Capital',
        value: '\$1.4B',
        trend: 'optimized',
        trendPositive: true,
      ),
      const MetricTileData(
        label: 'Trade Finance',
        value: '\$450M',
        trend: '+22%',
        trendPositive: true,
      ),
      const MetricTileData(
        label: 'Treasury Svc',
        value: '124',
        trend: 'active clients',
        trendPositive: null,
      ),
    ];

    if (isMobile) {
      return Column(
        children: metrics
            .map((m) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: MetricTile(data: m),
                ))
            .toList(),
      );
    } else {
      return Column(
        children: [
          Row(
            children: metrics
                .sublist(0, 3)
                .map((m) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: MetricTile(data: m),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 12),
          Row(
            children: metrics
                .sublist(3, 6)
                .map((m) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: MetricTile(data: m),
                      ),
                    ))
                .toList(),
          ),
        ],
      );
    }
  }
}

// Institutional Dashboard (Responsive)
class InstitutionalDashboard extends StatelessWidget {
  const InstitutionalDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.account_balance, color: Colors.green[700], size: isMobile ? 18 : 20),
                const SizedBox(width: 8),
                Text(
                  'Institutional Metrics',
                  style: TextStyle(fontSize: isMobile ? 14 : 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 14 : 20),
            _buildMetricsGrid(isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsGrid(bool isMobile) {
    final metrics = [
      const MetricTileData(
        label: 'Total AUM',
        value: '\$12.5B',
        trend: '+8.7%',
        trendPositive: true,
      ),
      const MetricTileData(
        label: 'ESG Focused',
        value: '42%',
        trend: '+12% YoY',
        trendPositive: true,
      ),
      const MetricTileData(
        label: 'Custody Vol.',
        value: '\$8.9B',
        trend: '+5.3%',
        trendPositive: true,
      ),
      const MetricTileData(
        label: 'Benchmark Beat',
        value: '78%',
        trend: 'vs peers',
        trendPositive: true,
      ),
      const MetricTileData(
        label: 'Avg Mandate',
        value: '\$285M',
        trend: 'per client',
        trendPositive: null,
      ),
      const MetricTileData(
        label: 'RFP Win Rate',
        value: '65%',
        trend: '+8% YoY',
        trendPositive: true,
      ),
    ];

    if (isMobile) {
      return Column(
        children: metrics
            .map((m) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: MetricTile(data: m),
                ))
            .toList(),
      );
    } else {
      return Column(
        children: [
          Row(
            children: metrics
                .sublist(0, 3)
                .map((m) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: MetricTile(data: m),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 12),
          Row(
            children: metrics
                .sublist(3, 6)
                .map((m) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: MetricTile(data: m),
                      ),
                    ))
                .toList(),
          ),
        ],
      );
    }
  }
}

// Investment Banking Dashboard (Responsive)
class InvestmentBankingDashboard extends StatelessWidget {
  const InvestmentBankingDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.trending_up, color: Colors.orange[700], size: isMobile ? 18 : 20),
                const SizedBox(width: 8),
                Text(
                  'Investment Banking Metrics',
                  style: TextStyle(fontSize: isMobile ? 14 : 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 14 : 20),
            _buildMetricsGrid(isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsGrid(bool isMobile) {
    final metrics = [
      const MetricTileData(
        label: 'Deal Pipeline',
        value: '\$4.8B',
        trend: '18 active',
        trendPositive: true,
      ),
      const MetricTileData(
        label: 'Avg Deal Size',
        value: '\$265M',
        trend: '+18%',
        trendPositive: true,
      ),
      const MetricTileData(
        label: 'Win Rate',
        value: '72%',
        trend: 'vs 58% industry',
        trendPositive: true,
      ),
      const MetricTileData(
        label: 'M&A Volume',
        value: '\$2.4B',
        trend: 'YTD',
        trendPositive: null,
      ),
      const MetricTileData(
        label: 'ECM/DCM',
        value: '\$1.8B',
        trend: '+25%',
        trendPositive: true,
      ),
      const MetricTileData(
        label: 'Advisory Fees',
        value: '\$45M',
        trend: 'strong pipeline',
        trendPositive: true,
      ),
    ];

    if (isMobile) {
      return Column(
        children: metrics
            .map((m) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: MetricTile(data: m),
                ))
            .toList(),
      );
    } else {
      return Column(
        children: [
          Row(
            children: metrics
                .sublist(0, 3)
                .map((m) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: MetricTile(data: m),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 12),
          Row(
            children: metrics
                .sublist(3, 6)
                .map((m) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: MetricTile(data: m),
                      ),
                    ))
                .toList(),
          ),
        ],
      );
    }
  }
}

// Data class for metrics
class MetricTileData {
  final String label;
  final String value;
  final String trend;
  final bool? trendPositive;

  const MetricTileData({
    required this.label,
    required this.value,
    required this.trend,
    this.trendPositive,
  });
}

// Metric Tile Widget (Responsive)
class MetricTile extends StatelessWidget {
  final MetricTileData data;

  const MetricTile({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Container(
      padding: EdgeInsets.all(isMobile ? 10 : 14),
      decoration: BoxDecoration(
       color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.02),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.label,
            style: TextStyle(
              fontSize: isMobile ? 9 : 10,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: isMobile ? 4 : 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              data.value,
              style: TextStyle(
                fontSize: isMobile ? 18 : 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              if (data.trendPositive != null)
                Icon(
                  data.trendPositive! ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 12,
                  color: data.trendPositive! ? Colors.green : Colors.red,
                ),
              if (data.trendPositive != null) const SizedBox(width: 4),
              Expanded(
                child: Text(
                  data.trend,
                  style: TextStyle(
                    fontSize: isMobile ? 9 : 10,
                    color: data.trendPositive == null
                        ? Colors.grey[600]
                        : (data.trendPositive! ? Colors.green : Colors.red),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Additional features exports continued in next part due to length...
// This file contains: Segment Dashboards (completed above)
// Relationship Hierarchy, Compliance, and Role-Based Views will be in separate imports
