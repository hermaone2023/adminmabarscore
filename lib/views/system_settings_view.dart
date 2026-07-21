import 'package:flutter/material.dart';

class SystemSettingsView extends StatefulWidget {
  const SystemSettingsView({super.key});

  @override
  State<SystemSettingsView> createState() => _SystemSettingsViewState();
}

class _SystemSettingsViewState extends State<SystemSettingsView> {
  // Contoh state pengaturan sistem
  bool isMaintenanceMode = false;
  bool autoDisputeResolve = false;
  final TextEditingController _matchTimeController = TextEditingController(
    text: "15",
  );
  final TextEditingController _minCoinController = TextEditingController(
    text: "50",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "System Settings & Configurations",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            // Section 1: Pengaturan Turnamen
            const Text(
              "Konfigurasi Turnamen & Arena",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _minCoinController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Syarat Minimum Koin per Arena",
                      border: OutlineInputBorder(),
                      helperText:
                          "Standar aturan: 50 koin untuk masuk Fivehero Arena",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _matchTimeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Batas Waktu Tanding / Ready (Menit)",
                      border: OutlineInputBorder(),
                      helperText:
                          "Player dianggap gugur jika melewati batas waktu ini tanpa kesepakatan",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section 2: Kontrol Sistem & Keamanan
            const Text(
              "Kontrol Sistem & Wasit",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text("Maintenance Mode"),
                    subtitle: const Text(
                      "Tutup sementara akses aplikasi mobile untuk pemeliharaan sistem",
                    ),
                    value: isMaintenanceMode,
                    activeColor: const Color(0xFF031B19),
                    onChanged: (bool value) {
                      setState(() {
                        isMaintenanceMode = value;
                      });
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text("Auto-Resolve Dispute (Experimental)"),
                    subtitle: const Text(
                      "Sistem otomatis memvalidasi screenshot jika kecocokan AI mencapai 99%",
                    ),
                    value: autoDisputeResolve,
                    activeColor: const Color(0xFF031B19),
                    onChanged: (bool value) {
                      setState(() {
                        autoDisputeResolve = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Tombol Simpan
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF031B19),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Aksi menyimpan perubahan konfigurasi ke database
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Pengaturan sistem berhasil disimpan!"),
                    ),
                  );
                },
                child: const Text(
                  "Simpan Perubahan Pengaturan",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
