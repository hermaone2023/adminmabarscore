import 'package:flutter/material.dart';

class ArenaMonitorView extends StatelessWidget {
  ArenaMonitorView({super.key});

  // Contoh data: Nanti ini bisa kamu hubungkan dengan real-time database
  final List<Map<String, dynamic>> arenaList = List.generate(50, (index) {
    return {
      "id": index + 1,
      "status": index % 5 == 0
          ? "Dispute"
          : (index % 3 == 0 ? "Ongoing" : "Available"),
      "players": index % 5 + 1,
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Fivehero Arena Monitor",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                5, // 5 kolom agar terlihat seperti dashboard monitoring
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: arenaList.length,
          itemBuilder: (context, index) {
            final arena = arenaList[index];
            return _buildArenaCard(arena);
          },
        ),
      ),
    );
  }

  Widget _buildArenaCard(Map<String, dynamic> arena) {
    Color statusColor;
    switch (arena['status']) {
      case "Dispute":
        statusColor = Colors.red;
        break;
      case "Ongoing":
        statusColor = Colors.blue;
        break;
      default:
        statusColor = Colors.green;
    }

    return Card(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Arena ${arena['id']}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              arena['status'],
              style: TextStyle(color: statusColor, fontSize: 12),
            ),
          ),
          Text(
            "${arena['players']}/5 Players",
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
