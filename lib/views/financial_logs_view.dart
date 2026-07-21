import 'package:flutter/material.dart';

class FinancialLogsView extends StatelessWidget {
  const FinancialLogsView({super.key});

  // Contoh data log transaksi topup/koin
  final List<Map<String, dynamic>> financialList = const [
    {
      "id": "TRX-901",
      "player": "Andi",
      "nominal": "Rp 50.000",
      "coins": "+50 Koin",
      "status": "Success",
      "date": "2026-06-06 10:15",
    },
    {
      "id": "TRX-902",
      "player": "Budi",
      "nominal": "Rp 50.000",
      "coins": "+50 Koin",
      "status": "Pending",
      "date": "2026-06-06 10:20",
    },
    {
      "id": "TRX-903",
      "player": "Citra",
      "nominal": "Rp 100.000",
      "coins": "+100 Koin",
      "status": "Success",
      "date": "2026-06-06 09:45",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Financial & Top-up Logs",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ringkasan Keuangan Singkat
            Row(
              children: [
                _buildSummaryCard(
                  "Total Pendapatan Hari Ini",
                  "Rp 200.000",
                  Icons.monetization_on,
                  Colors.green,
                ),
                _buildSummaryCard(
                  "Total Koin Beredar",
                  "1.250 Koin",
                  Icons.toll,
                  Colors.blue,
                ),
                _buildSummaryCard(
                  "Pending Validasi",
                  "1 Transaksi",
                  Icons.hourglass_top,
                  Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Tabel Riwayat Transaksi
            const Text(
              "Riwayat Transaksi Terbaru",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ListView.separated(
                  itemCount: financialList.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = financialList[index];
                    bool isPending = item['status'] == "Pending";

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isPending
                            ? Colors.orange.shade100
                            : Colors.green.shade100,
                        child: Icon(
                          isPending
                              ? Icons.pending_actions
                              : Icons.check_circle,
                          color: isPending ? Colors.orange : Colors.green,
                        ),
                      ),
                      title: Text(
                        "Player: ${item['player']} (${item['id']})",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Waktu: ${item['date']}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                item['nominal'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                item['coins'],
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          if (isPending)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                              ),
                              onPressed: () {
                                // Aksi validasi top-up manual jika diperlukan
                              },
                              child: const Text(
                                "Validasi",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          else
                            Chip(
                              label: const Text(
                                "Success",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                ),
                              ),
                              backgroundColor: Colors
                                  .green[50], // Diperbaiki dari Colors.green50
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 36, color: color),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
}
