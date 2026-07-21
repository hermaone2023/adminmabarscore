import 'package:adminmabarscore/views/arena_monitor_view.dart';
import 'package:adminmabarscore/views/dispute_center_view.dart';
import 'package:adminmabarscore/views/financial_logs_view.dart';
import 'package:adminmabarscore/views/system_settings_view.dart';
import 'package:adminmabarscore/views/tournament_bracket_view.dart';
import 'package:flutter/material.dart';
import 'views/dashboard_view.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  // Indeks untuk menentukan halaman mana yang sedang dibukas
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardView(),
    ArenaMonitorView(),
    const DisputeCenterView(),
    const TournamentBracketView(),
    const FinancialLogsView(),
    const SystemSettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // SIDEBAR (Background #031B19)
          Container(
            width: 250,
            color: const Color(0xFF343A40),
            child: Column(
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(color: Color(0xFF343A40)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/iconms.png',
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "MabarScore Admin",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Daftar Menu Sidebar menggunakan fungsi helper
                _buildSidebarItem(
                  index: 0,
                  icon: Icons.home,
                  title: "Dashboard",
                ),
                _buildSidebarItem(
                  index: 1,
                  icon: Icons.stadium_outlined,
                  title: "Arena Monitor",
                ),
                _buildSidebarItem(
                  index: 2,
                  icon: Icons.sports_outlined,
                  title: "Dispute Center",
                ),
                _buildSidebarItem(
                  index: 3,
                  icon: Icons.sports_esports_outlined,
                  title: "Tournament Bracket",
                ),
                _buildSidebarItem(
                  index: 4,
                  icon: Icons.payment_outlined,
                  title: "Financial Logs",
                ),
                _buildSidebarItem(
                  index: 5,
                  icon: Icons.admin_panel_settings_outlined,
                  title: "System Settings",
                ),
              ],
            ),
          ),
          // MAIN CONTENT
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }

  // Fungsi helper untuk membangun item sidebar dengan indikator aktif
  Widget _buildSidebarItem({
    required int index,
    required IconData icon,
    required String title,
  }) {
    bool isSelected = _selectedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        // Warna background berbeda jika menu sedang aktif
        color: isSelected ? Colors.white.withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.greenAccent : Colors.white,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () => setState(() => _selectedIndex = index),
      ),
    );
  }
}
