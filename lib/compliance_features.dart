import 'package:flutter/material.dart';
import 'main.dart';
import 'segment_features.dart';

// ============================================================================
// RELATIONSHIP HIERARCHY, COMPLIANCE & ROLE-BASED FEATURES (RESPONSIVE)
// ============================================================================

// 3. RELATIONSHIP HIERARCHY VISUALIZATION (Responsive)

class RelationshipHierarchyWidget extends StatelessWidget {
  final ClientData client;

  const RelationshipHierarchyWidget({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Card(
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(isMobile ? 6 : 8),
                  decoration: BoxDecoration(
                    color: Colors.cyan.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.account_tree, color: Colors.cyan, size: isMobile ? 18 : 20),
                ),
                SizedBox(width: isMobile ? 8 : 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Relationship Hierarchy',
                        style: TextStyle(fontSize: isMobile ? 14 : 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Family structure & decision makers',
                        style: TextStyle(fontSize: isMobile ? 9 : 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 14 : 20),
            
            // Decision Makers Section
            Container(
              padding: EdgeInsets.all(isMobile ? 10 : 14),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.purple.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.stars, size: isMobile ? 14 : 16, color: Colors.purple),
                      const SizedBox(width: 8),
                      Text(
                        'Key Decision Makers',
                        style: TextStyle(fontSize: isMobile ? 11 : 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...client.decisionMakers.map((dm) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: isMobile ? 10 : 12,
                          backgroundColor: Colors.purple.withOpacity(0.3),
                          child: Text(
                            dm.substring(0, 1),
                            style: TextStyle(fontSize: isMobile ? 9 : 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            dm,
                            style: TextStyle(fontSize: isMobile ? 10 : 11),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
            
            SizedBox(height: isMobile ? 10 : 14),
            
            // Corporate Structure (if applicable)
            if (client.parentEntity != null || client.subsidiaries.isNotEmpty)
              Container(
                padding: EdgeInsets.all(isMobile ? 10 : 14),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.corporate_fare, size: isMobile ? 14 : 16, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          'Corporate Structure',
                          style: TextStyle(fontSize: isMobile ? 11 : 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    
                    if (client.parentEntity != null) ...[
                      _buildEntityTile(
                        Icons.arrow_upward,
                        'Parent: ${client.parentEntity!}',
                        'parent',
                        isMobile,
                        isDark,
                      ),
                      const SizedBox(height: 8),
                    ],
                    
                    _buildEntityTile(
                      Icons.business,
                      client.name,
                      'current',
                      isMobile,
                      isDark,
                    ),
                    
                    if (client.subsidiaries.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      ...client.subsidiaries.map((sub) => Padding(
                        padding: EdgeInsets.only(bottom: 6, left: isMobile ? 12 : 16),
                        child: _buildEntityTile(
                          Icons.arrow_downward,
                          sub,
                          'subsidiary',
                          isMobile,
                          isDark,
                        ),
                      )).toList(),
                    ],
                  ],
                ),
              ),
              
            // Private Banking Family Info
            if (client.privateBankingData != null) ...[
              SizedBox(height: isMobile ? 10 : 14),
              Container(
                padding: EdgeInsets.all(isMobile ? 10 : 14),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.amber.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.family_restroom, size: isMobile ? 14 : 16, color: Colors.amber),
                        const SizedBox(width: 8),
                        Text(
                          'Family Office Structure',
                          style: TextStyle(fontSize: isMobile ? 11 : 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _HierarchyMetric(
                                icon: Icons.people,
                                label: 'Members',
                                value: '${client.privateBankingData!.familyMembers}',
                              ),
                              const SizedBox(height: 8),
                              _HierarchyMetric(
                                icon: Icons.account_balance,
                                label: 'Trusts',
                                value: '${client.privateBankingData!.trustEntities.length}',
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              _HierarchyMetric(
                                icon: Icons.people,
                                label: 'Members',
                                value: '${client.privateBankingData!.familyMembers}',
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _HierarchyMetric(
                                  icon: Icons.account_balance,
                                  label: 'Trusts',
                                  value: '${client.privateBankingData!.trustEntities.length}',
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.02),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.timeline, size: isMobile ? 12 : 14, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              client.privateBankingData!.generationFocus,
                              style: TextStyle(fontSize: isMobile ? 9 : 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEntityTile(IconData icon, String label, String type, bool isMobile, bool isDark) {
    Color bgColor;
    Color? borderColor;
    
    if (type == 'current') {
      bgColor = Colors.blue.withOpacity(0.2);
      borderColor = Colors.blue;
    } else {
      bgColor = isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.02);
      borderColor = Colors.grey.withOpacity(0.3);
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 10, vertical: isMobile ? 5 : 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      child: Row(
        children: [
          Icon(icon, size: isMobile ? 10 : 12, color: type == 'current' ? Colors.blue : Colors.grey),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isMobile ? 9 : 10,
                fontWeight: type == 'current' ? FontWeight.bold : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (type == 'current')
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                'MAIN',
                style: TextStyle(fontSize: isMobile ? 7 : 8, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}

class _HierarchyMetric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _HierarchyMetric({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: isMobile ? 12 : 14, color: Colors.grey),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: isMobile ? 8 : 9, color: Colors.grey)),
            Text(value, style: TextStyle(fontSize: isMobile ? 11 : 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}

// 4. REGULATORY COMPLIANCE DASHBOARD (Responsive)

class RegulatoryComplianceDashboard extends StatelessWidget {
  const RegulatoryComplianceDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clients = MockBankingData.enhancedClients;
    final expiringKYC = clients.where((c) =>
      c.kycExpiryDate.difference(DateTime.now()).inDays < 90
    ).length;
    final pendingReviews = clients.where((c) =>
      c.kycStatus == ComplianceStatus.inReview || c.kycStatus == ComplianceStatus.pending
    ).length;
    final highRiskClients = clients.where((c) => c.riskRating == RiskRating.high).length;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 12 : 24),
      child: Card(
        elevation: 6,
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 16 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(isMobile ? 6 : 8),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.shield, color: Colors.red, size: isMobile ? 18 : 20),
                  ),
                  SizedBox(width: isMobile ? 8 : 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Regulatory Compliance',
                          style: TextStyle(fontSize: isMobile ? 14 : 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'KYC tracking & risk monitoring',
                          style: TextStyle(fontSize: isMobile ? 9 : 10, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: isMobile ? 14 : 20),
              
              isMobile
                  ? Column(
                      children: [
                        _ComplianceMetric(
                          icon: Icons.warning_amber,
                          label: 'KYC Expiring (90d)',
                          value: '$expiringKYC',
                          color: Colors.orange,
                          actionLabel: 'Review',
                        ),
                        const SizedBox(height: 12),
                        _ComplianceMetric(
                          icon: Icons.pending_actions,
                          label: 'Pending Reviews',
                          value: '$pendingReviews',
                          color: Colors.blue,
                          actionLabel: 'Process',
                        ),
                        const SizedBox(height: 12),
                        _ComplianceMetric(
                          icon: Icons.error_outline,
                          label: 'High Risk',
                          value: '$highRiskClients',
                          color: Colors.red,
                          actionLabel: 'Monitor',
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: _ComplianceMetric(
                            icon: Icons.warning_amber,
                            label: 'KYC Expiring (90d)',
                            value: '$expiringKYC',
                            color: Colors.orange,
                            actionLabel: 'Review',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _ComplianceMetric(
                            icon: Icons.pending_actions,
                            label: 'Pending Reviews',
                            value: '$pendingReviews',
                            color: Colors.blue,
                            actionLabel: 'Process',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _ComplianceMetric(
                            icon: Icons.error_outline,
                            label: 'High Risk',
                            value: '$highRiskClients',
                            color: Colors.red,
                            actionLabel: 'Monitor',
                          ),
                        ),
                      ],
                    ),
              
              SizedBox(height: isMobile ? 14 : 16),
              const Divider(),
              SizedBox(height: isMobile ? 14 : 16),
              
              Text(
                'Recent Compliance Actions',
                style: TextStyle(fontSize: isMobile ? 11 : 12, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              
              ..._buildComplianceActions(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildComplianceActions() {
    return [
      _ComplianceActionTile(
        title: 'KYC Renewal Completed',
        client: 'Wellington Family Office',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        status: 'Approved',
        statusColor: Colors.green,
      ),
      _ComplianceActionTile(
        title: 'Enhanced Due Diligence',
        client: 'Horizon Logistics',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        status: 'In Progress',
        statusColor: Colors.blue,
      ),
      _ComplianceActionTile(
        title: 'Risk Rating Updated',
        client: 'SignalOps Cloud',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        status: 'Medium → Low',
        statusColor: Colors.green,
      ),
    ];
  }
}

class _ComplianceMetric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final String actionLabel;

  const _ComplianceMetric({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: isMobile ? 20 : 24),
          SizedBox(height: isMobile ? 6 : 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: isMobile ? 9 : 10),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 8 : 10),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              minimumSize: Size(double.infinity, isMobile ? 24 : 28),
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 6 : 8),
              foregroundColor: color,
              side: BorderSide(color: color),
            ),
            child: Text(actionLabel, style: TextStyle(fontSize: isMobile ? 9 : 10)),
          ),
        ],
      ),
    );
  }
}

class _ComplianceActionTile extends StatelessWidget {
  final String title;
  final String client;
  final DateTime timestamp;
  final String status;
  final Color statusColor;

  const _ComplianceActionTile({
    required this.title,
    required this.client,
    required this.timestamp,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 768;
    final timeAgo = _formatTimeAgo(timestamp);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 10 : 12),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.02),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    client,
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        timeAgo,
                        style: const TextStyle(fontSize: 9, color: Colors.grey),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 8,
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          client,
                          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          timeAgo,
                          style: const TextStyle(fontSize: 9, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 9,
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  String _formatTimeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

// 5. ROLE-BASED VIEW SELECTOR (Responsive) - Continued in main.dart integration
