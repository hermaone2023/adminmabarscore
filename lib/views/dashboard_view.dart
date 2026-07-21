import 'package:adminmabarscore/services/api_service.dart';
import 'package:adminmabarscore/datasources/player_data_source.dart'; // Sesuaikan path import foldermu
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  String totalPlayers = "...";
  String activeArenas = "48";
  String disputeCount = "3";
  String pendingTopups = "2";
  bool isLoading = true;

  // State untuk kontrol tabel detail player
  bool showPlayerTable = false;
  bool isLoadingTable = false;
  List<dynamic> playerList = [];

  // State untuk Filter & Pencarian Tabel
  String searchQuery = "";
  String selectedStatusFilter = "SEMUA";

  // Inisialisasi DataSource untuk PaginatedDataTable
  late PlayerDataSource _playerDataSource;

  @override
  void initState() {
    super.initState();
    _playerDataSource = PlayerDataSource([], _getStatusColor);
    _loadData();
  }

  List<dynamic> get _filteredPlayerList {
    return playerList.where((p) {
      final name = (p['nama_player'] ?? '').toString().toLowerCase();
      final googleId = (p['google_id'] ?? '').toString().toLowerCase();
      final status = (p['status_player'] ?? '').toString().toUpperCase();

      // Filter berdasarkan teks (Nama atau Google ID)
      final matchesSearch =
          name.contains(searchQuery.toLowerCase()) ||
          googleId.contains(searchQuery.toLowerCase());

      // Filter berdasarkan Dropdown Status
      final matchesStatus =
          selectedStatusFilter == "SEMUA" || status == selectedStatusFilter;

      return matchesSearch && matchesStatus;
    }).toList();
  }

  Future<void> _loadData() async {
    try {
      final data = await ApiService.fetchDashboardStats();
      setState(() {
        totalPlayers = data['total_players'].toString();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        totalPlayers = "0";
        isLoading = false;
      });
    }
  }

  Future<void> _togglePlayerDetailTable() async {
    setState(() {
      showPlayerTable = !showPlayerTable;
    });

    if (showPlayerTable && playerList.isEmpty) {
      setState(() => isLoadingTable = true);
      try {
        final data = await ApiService.fetchActivePlayersDetail();
        setState(() {
          playerList = data;
          // Update data source ketika data API berhasil ditarik
          _playerDataSource = PlayerDataSource(
            _filteredPlayerList,
            _getStatusColor,
          );
          isLoadingTable = false;
        });
      } catch (e) {
        setState(() => isLoadingTable = false);
      }
    }
  }

  void _applyFilter() {
    setState(() {
      _playerDataSource = PlayerDataSource(
        _filteredPlayerList,
        _getStatusColor,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2B3035),
      appBar: AppBar(
        title: const Text(
          "Dashboard Overview",
          style: TextStyle(color: Color(0xffDEE2E6)),
        ),
        backgroundColor: Color(0xFF343A40),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Quick Stats
            Row(
              children: [
                _buildStatCardWithDetail(
                  title: "Total Players",
                  value: totalPlayers,
                  icon: Icons.people,
                  color: Colors.blue,
                  onDetailPressed: _togglePlayerDetailTable,
                  isExpandedActive: showPlayerTable,
                ),
                _buildStatCard(
                  "Active Arenas",
                  activeArenas,
                  Icons.gamepad,
                  Colors.green,
                ),
                _buildStatCard(
                  "Dispute Count",
                  disputeCount,
                  Icons.gavel,
                  Colors.red,
                ),
                _buildStatCard(
                  "Pending Top-ups",
                  pendingTopups,
                  Icons.wallet,
                  Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 2. Detail Tabel Partisipan dengan PaginatedDataTable2 & Filter
            if (showPlayerTable) ...[
              Card(
                color: Color(0xff212529),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Detail Partisipan Batch Aktif",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffDEE2E6),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () =>
                                setState(() => showPlayerTable = false),
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(height: 10),

                      // Baris Kontrol Filter & Pencarian
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: "Cari Nama atau Google ID...",
                                hintStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(Icons.search, size: 20),
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              onChanged: (value) {
                                searchQuery = value;
                                _applyFilter();
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 1,
                            child: DropdownButtonFormField<String>(
                              value: selectedStatusFilter,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: "SEMUA",
                                  child: Text(
                                    "Semua Status",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "TERDAFTAR",
                                  child: Text(
                                    "Terdaftar",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "BERTANDING",
                                  child: Text(
                                    "Bertanding",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "LOLOS",
                                  child: Text(
                                    "Lolos",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "GUGUR",
                                  child: Text(
                                    "Gugur",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  selectedStatusFilter = value;
                                  _applyFilter();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      isLoadingTable
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : playerList.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Text("Tidak ada data partisipan."),
                              ),
                            )
                          : SizedBox(
                              height: 400,
                              child: Theme(
                                data: ThemeData.dark().copyWith(
                                  cardColor: const Color(
                                    0xff212529,
                                  ), // Sesuaikan warna latar footer/tabel
                                  dividerColor: Colors.grey[800],
                                ),
                                child: PaginatedDataTable2(
                                  headingRowColor: WidgetStateProperty.all(
                                    Color(0xff212529),
                                  ),
                                  rowsPerPage: 5,
                                  availableRowsPerPage: const [5, 10, 20, 50],
                                  columnSpacing: 12,
                                  horizontalMargin: 12,
                                  minWidth: 1200,
                                  columns: const [
                                    DataColumn2(
                                      label: Text(
                                        'NO',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      size: ColumnSize.S,
                                    ),
                                    DataColumn2(
                                      label: Text(
                                        'Google ID',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      size: ColumnSize.M,
                                    ),
                                    DataColumn2(
                                      label: Text(
                                        'Nama Player',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      size: ColumnSize.L,
                                    ),
                                    DataColumn2(
                                      label: Text(
                                        'Rank',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      size: ColumnSize.S,
                                    ),
                                    DataColumn2(
                                      label: Text(
                                        'Arena ID',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      size: ColumnSize.S,
                                    ),
                                    DataColumn2(
                                      label: Text(
                                        'Round',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      size: ColumnSize.S,
                                    ),
                                    DataColumn2(
                                      label: Text(
                                        'Slot Number',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      size: ColumnSize.S,
                                    ),
                                    DataColumn2(
                                      label: Text(
                                        'Joined At',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      size: ColumnSize.M,
                                    ),
                                    DataColumn2(
                                      label: Text(
                                        'Status Player',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      size: ColumnSize.M,
                                    ),
                                  ],
                                  source: _playerDataSource,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 50,
              color: Colors.amber,
              child: Text('data'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        color: color, // Menggunakan warna solid penuh sebagai background
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              // 1. Watermark Ikon Transparan Besar di Latar Belakang Kanan
              Positioned(
                right: -15,
                bottom: -15,
                child: Icon(
                  icon,
                  size: 100,
                  color: Colors.white.withOpacity(0.15),
                ),
              ),
              // 2. Konten Utama Kartu
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                value,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                        const SizedBox(height: 4),
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // 3. Footer Bawah (More Info)
                  Container(
                    color: Colors.black.withOpacity(0.15),
                    child: InkWell(
                      onTap: () {
                        // Tambahkan aksi ketika footer diklik jika diperlukan
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "More info",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward,
                              size: 14,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCardWithDetail({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required VoidCallback onDetailPressed,
    required bool isExpandedActive,
  }) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        color: color, // Warna solid latar belakang
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              // 1. Watermark Ikon Transparan Besar di Latar Belakang Kanan
              Positioned(
                right: -15,
                bottom: -15,
                child: Icon(
                  icon,
                  size: 100,
                  color: Colors.white.withOpacity(0.15),
                ),
              ),
              // 2. Konten Utama Kartu
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                value,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                        const SizedBox(height: 4),
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // 3. Footer Bawah (Tombol Detail / Tutup Tabel)
                  Container(
                    color: Colors.black.withOpacity(0.15),
                    child: InkWell(
                      onTap: onDetailPressed,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isExpandedActive ? "Tutup Detail" : "More info",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              isExpandedActive
                                  ? Icons.arrow_upward
                                  : Icons.arrow_forward,
                              size: 14,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'terdaftar':
        return Colors.blue;
      case 'bertanding':
        return Colors.orange;
      case 'lolos':
        return Colors.green;
      case 'gugur':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
