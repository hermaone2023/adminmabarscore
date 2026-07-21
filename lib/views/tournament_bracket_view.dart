import 'package:flutter/material.dart';

class TournamentBracketView extends StatelessWidget {
  const TournamentBracketView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Tournament Bracket Progress",
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
            // Info Header
            const Text(
              "Fase Pengerucutan Turnamen MabarScore",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Pantau progres dari 250 player di 50 Fivehero Arena hingga babak final.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Visualisasi Tahapan (Horizontal Flow / Tree Simulation)
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildStageCard(
                    "Babak 1: Penyisihan Arena",
                    "50 Fivehero Arena",
                    "250 Player Terdaftar",
                    "Status: Berlangsung / Semi-Auto",
                    Colors.blue,
                  ),
                  const SizedBox(width: 16),
                  _buildConnectingArrow(),
                  const SizedBox(width: 16),
                  _buildStageCard(
                    "Babak 2: Pengerucutan",
                    "10 Fivehero Arena",
                    "50 Player Tersisa",
                    "Status: Menunggu Selesai Babak 1",
                    Colors.orange,
                  ),
                  const SizedBox(width: 16),
                  _buildConnectingArrow(),
                  const SizedBox(width: 16),
                  _buildStageCard(
                    "Babak 3: Semifinal",
                    "2 Fivehero Arena",
                    "10 Player Tersisa",
                    "Status: Belum Mulai",
                    Colors.purple,
                  ),
                  const SizedBox(width: 16),
                  _buildConnectingArrow(),
                  const SizedBox(width: 16),
                  _buildStageCard(
                    "Babak Final",
                    "1 Arena Utama",
                    "2 Player (Juara 1 & 2)",
                    "Status: Belum Mulai",
                    Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan card setiap tahapan turnamen
  Widget _buildStageCard(
    String title,
    String arenas,
    String players,
    String status,
    Color accentColor,
  ) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              title,
              style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.gamepad, size: 20, color: Colors.grey),
              const SizedBox(width: 8),
              Text(arenas, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.people, size: 20, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                players,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const Spacer(),
          const Divider(),
          const SizedBox(height: 8),
          Text(
            status,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // Widget garis penghubung antar tahapan
  Widget _buildConnectingArrow() {
    return const Center(
      child: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 24),
    );
  }
}
