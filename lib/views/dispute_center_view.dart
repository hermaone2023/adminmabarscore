import 'package:flutter/material.dart';

class DisputeCenterView extends StatelessWidget {
  const DisputeCenterView({super.key});

  // Simulasi data sengketa
  final List<Map<String, dynamic>> disputeList = const [
    {
      "id": "DS-001",
      "arena": "Arena 05",
      "playerA": "Andi",
      "playerB": "Budi",
      "status": "Pending",
    },
    {
      "id": "DS-002",
      "arena": "Arena 12",
      "playerA": "Citra",
      "playerB": "Dedi",
      "status": "Pending",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Dispute Center (Wasit)",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: disputeList.length,
        itemBuilder: (context, index) {
          final dispute = disputeList[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.gavel, color: Colors.red),
              title: Text(
                "${dispute['arena']} | ${dispute['playerA']} vs ${dispute['playerB']}",
              ),
              subtitle: Text("ID Sengketa: ${dispute['id']}"),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF031B19),
                ),
                onPressed: () => _showReviewDialog(context, dispute),
                child: const Text(
                  "Review",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showReviewDialog(BuildContext context, Map<String, dynamic> dispute) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sengketa: ${dispute['arena']}"),
        content: SizedBox(
          width: 600,
          child: Row(
            children: [
              _buildScreenshotPanel(dispute['playerA'], Colors.blue),
              const SizedBox(width: 20),
              _buildScreenshotPanel(dispute['playerB'], Colors.green),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              // Logika update status sengketa ke database
              Navigator.pop(context);
            },
            child: const Text(
              "Tentukan Pemenang",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreenshotPanel(String playerName, Color color) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(playerName, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Container(
            height: 200,
            color: Colors.grey[300],
            child: const Center(child: Text("Screenshot Evidence")),
          ),
          const SizedBox(height: 10),
          RadioListTile(
            title: const Text("Menang"),
            value: true,
            groupValue: false,
            onChanged: (v) {},
          ),
        ],
      ),
    );
  }
}
