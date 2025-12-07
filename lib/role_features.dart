import 'package:flutter/material.dart';
import 'segment_features.dart';

// ============================================================================
// ROLE-BASED VIEW SELECTOR (FULLY RESPONSIVE)
// ============================================================================

class RoleBasedViewSelector extends StatefulWidget {
  const RoleBasedViewSelector({Key? key}) : super(key: key);

  @override
  State<RoleBasedViewSelector> createState() => _RoleBasedViewSelectorState();
}

class _RoleBasedViewSelectorState extends State<RoleBasedViewSelector> {
  UserRole _currentRole = UserRole.relationshipManager;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 12 : 24),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 12 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, size: isMobile ? 16 : 18),
                      SizedBox(width: isMobile ? 6 : 8),
                      Text(
                        'Role-Based View',
                        style: TextStyle(fontSize: isMobile ? 12 : 13, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 10 : 12),
                  isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: UserRole.values.map((role) {
                            final isSelected = _currentRole == role;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: OutlinedButton.icon(
                                onPressed: () => setState(() => _currentRole = role),
                                icon: Icon(_getRoleIcon(role), size: 16),
                                label: Text(_getRoleLabel(role)),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: isSelected
                                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                                      : null,
                                  foregroundColor: isSelected
                                      ? Theme.of(context).primaryColor
                                      : null,
                                ),
                              ),
                            );
                          }).toList(),
                        )
                      : SegmentedButton<UserRole>(
                          segments: [
                            ButtonSegment(
                              value: UserRole.relationshipManager,
                              label: const Text('RM', style: TextStyle(fontSize: 10)),
                              icon: const Icon(Icons.account_circle, size: 14),
                            ),
                            ButtonSegment(
                              value: UserRole.coverageHead,
                              label: const Text('Coverage', style: TextStyle(fontSize: 10)),
                              icon: const Icon(Icons.supervised_user_circle, size: 14),
                            ),
                            ButtonSegment(
                              value: UserRole.productSpecialist,
                              label: const Text('Product', style: TextStyle(fontSize: 10)),
                              icon: const Icon(Icons.inventory, size: 14),
                            ),
                            ButtonSegment(
                              value: UserRole.complianceOfficer,
                              label: const Text('Compliance', style: TextStyle(fontSize: 10)),
                              icon: const Icon(Icons.shield, size: 14),
                            ),
                          ],
                          selected: {_currentRole},
                          onSelectionChanged: (Set<UserRole> newSelection) {
                            setState(() {
                              _currentRole = newSelection.first;
                            });
                          },
                        ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildRoleSpecificView(_currentRole),
        ],
      ),
    );
  }

  IconData _getRoleIcon(UserRole role) {
    switch (role) {
      case UserRole.relationshipManager:
        return Icons.account_circle;
      case UserRole.coverageHead:
        return Icons.supervised_user_circle;
      case UserRole.productSpecialist:
        return Icons.inventory;
      case UserRole.complianceOfficer:
        return Icons.shield;
    }
  }

  String _getRoleLabel(UserRole role) {
    switch (role) {
      case UserRole.relationshipManager:
        return 'Relationship Manager';
      case UserRole.coverageHead:
        return 'Coverage Head';
      case UserRole.productSpecialist:
        return 'Product Specialist';
      case UserRole.complianceOfficer:
        return 'Compliance Officer';
    }
  }

  Widget _buildRoleSpecificView(UserRole role) {
    switch (role) {
      case UserRole.relationshipManager:
        return _buildRMView();
      case UserRole.coverageHead:
        return _buildCoverageView();
      case UserRole.productSpecialist:
        return _buildProductView();
      case UserRole.complianceOfficer:
        return _buildComplianceView();
    }
  }

  Widget _buildRMView() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.account_circle, color: Colors.blue, size: isMobile ? 18 : 20),
                SizedBox(width: isMobile ? 6 : 8),
                Expanded(
                  child: Text(
                    'Relationship Manager Dashboard',
                    style: TextStyle(fontSize: isMobile ? 13 : 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 12 : 16),
            Text(
              'Your Focus Areas:',
              style: TextStyle(fontSize: isMobile ? 10 : 11, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: isMobile ? 8 : 10),
            _buildFocusItem(Icons.check_circle, 'Next Best Actions', '8 high-priority tasks', Colors.blue),
            _buildFocusItem(Icons.event, 'Today\'s Meetings', '3 client touchpoints prepped', Colors.green),
            _buildFocusItem(Icons.trending_up, 'Churn Alerts', '2 clients need attention', Colors.orange),
            _buildFocusItem(Icons.email, 'Email Drafts', '5 AI-generated ready to send', Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverageView() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.supervised_user_circle, color: Colors.green, size: isMobile ? 18 : 20),
                SizedBox(width: isMobile ? 6 : 8),
                Expanded(
                  child: Text(
                    'Coverage Head Dashboard',
                    style: TextStyle(fontSize: isMobile ? 13 : 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 12 : 16),
            Text(
              'Team Performance:',
              style: TextStyle(fontSize: isMobile ? 10 : 11, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: isMobile ? 8 : 10),
            _buildFocusItem(Icons.groups, 'Team Pipeline', '\$450M active opportunities', Colors.green),
            _buildFocusItem(Icons.stars, 'Top Performers', '3 RMs exceeding targets', Colors.amber),
            _buildFocusItem(Icons.warning, 'Risk Concentration', '2 sectors over 25% exposure', Colors.red),
            _buildFocusItem(Icons.analytics, 'Wallet Share', '68% avg penetration (+5% QoQ)', Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildProductView() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.inventory, color: Colors.purple, size: isMobile ? 18 : 20),
                SizedBox(width: isMobile ? 6 : 8),
                Expanded(
                  child: Text(
                    'Product Specialist Dashboard',
                    style: TextStyle(fontSize: isMobile ? 13 : 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 12 : 16),
            Text(
              'Product Opportunities:',
              style: TextStyle(fontSize: isMobile ? 10 : 11, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: isMobile ? 8 : 10),
            _buildFocusItem(Icons.account_balance_wallet, 'Trust Services', '12 families ready for upsell', Colors.purple),
            _buildFocusItem(Icons.credit_card, 'Trade Finance', '\$85M underutilized capacity', Colors.blue),
            _buildFocusItem(Icons.show_chart, 'Structured Products', '8 institutional prospects', Colors.green),
            _buildFocusItem(Icons.security, 'ESG Funds', '15 clients matching criteria', Colors.teal),
          ],
        ),
      ),
    );
  }

  Widget _buildComplianceView() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.shield, color: Colors.red, size: isMobile ? 18 : 20),
                SizedBox(width: isMobile ? 6 : 8),
                Expanded(
                  child: Text(
                    'Compliance Officer Dashboard',
                    style: TextStyle(fontSize: isMobile ? 13 : 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 12 : 16),
            Text(
              'Compliance Status:',
              style: TextStyle(fontSize: isMobile ? 10 : 11, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: isMobile ? 8 : 10),
            _buildFocusItem(Icons.error, 'Urgent KYC Renewals', '4 expiring within 30 days', Colors.red),
            _buildFocusItem(Icons.pending, 'Pending Reviews', '7 awaiting approval', Colors.orange),
            _buildFocusItem(Icons.trending_up, 'Risk Rating Changes', '3 upgrades, 1 downgrade', Colors.blue),
            _buildFocusItem(Icons.verified, 'Audit Trail', 'All interactions logged - compliant', Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildFocusItem(IconData icon, String title, String detail, Color color) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 8 : 10),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(isMobile ? 5 : 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: isMobile ? 14 : 16, color: color),
          ),
          SizedBox(width: isMobile ? 10 : 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: isMobile ? 10 : 11, fontWeight: FontWeight.w600),
                ),
                Text(
                  detail,
                  style: TextStyle(fontSize: isMobile ? 8 : 9, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
