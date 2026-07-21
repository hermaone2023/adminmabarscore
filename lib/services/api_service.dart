import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  // Ganti dengan URL dasar (base URL) dari backend PHP kamu
  // Contoh jika di lokal: 'http://10.0.2.2/dbmabarscore_api/' atau 'http://localhost/dbmabarscore_api/'
  // Contoh jika sudah online: 'https://api.mabarscore.com/'
  static const String baseUrl = 'https://donorta.tech/apimabarscore/apiadmin/';

  // 1. Mengambil Statistik Dashboard (Termasuk Total Players batch aktif)
  static Future<Map<String, dynamic>> fetchDashboardStats() async {
    try {
      final response = await http.get(
        Uri.parse('${baseUrl}dashboard_stats.php'),
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        // Pastikan format balasan dari PHP berupa JSON, misal: {"success": true, "total_players": 245, ...}
        if (decoded['success'] == true) {
          return decoded;
        } else {
          throw Exception(
            decoded['message'] ?? 'Gagal memuat data dari server.',
          );
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      // Return nilai fallback atau throw error agar bisa ditangkap di UI
      throw Exception('Terjadi kesalahan koneksi: $e');
    }
  }

  // Tambahkan di dalam kelas ApiService
  static Future<List<dynamic>> fetchActivePlayersDetail() async {
    try {
      final response = await http.get(
        Uri.parse('${baseUrl}get_players_detail.php'),
      );
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded['success'] == true) {
          return decoded['data'];
        }
      }
      throw Exception('Gagal memuat detail pemain.');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Kamu bisa menambahkan method API PHP lainnya di sini nanti, contoh:
  // static Future<List<dynamic>> fetchArenas() async { ... }
  // static Future<List<dynamic>> fetchDisputes() async { ... }
}
