import 'package:flutter/material.dart';

class PlayerDataSource extends DataTableSource {
  final List<dynamic> _data;
  final Color Function(String status) _getStatusColorFunc;

  PlayerDataSource(this._data, this._getStatusColorFunc);

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) return null;
    final p = _data[index];

    return DataRow(
      color: WidgetStateProperty.all(Color(0xff212529)),
      cells: [
        DataCell(
          Text((index + 1).toString(), style: TextStyle(color: Colors.white)),
        ),
        DataCell(
          Text(p['google_id'] ?? '', style: TextStyle(color: Colors.white)),
        ),
        DataCell(
          Text(p['nama_player'] ?? '', style: TextStyle(color: Colors.white)),
        ),
        DataCell(
          Text(p['rank'].toString(), style: TextStyle(color: Colors.white)),
        ),
        DataCell(
          Text(p['arena_id'].toString(), style: TextStyle(color: Colors.white)),
        ),
        DataCell(
          Text(p['round'].toString(), style: TextStyle(color: Colors.white)),
        ),
        DataCell(
          Text(
            p['slot_number'].toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
        DataCell(
          Text(p['joined_at'] ?? '', style: TextStyle(color: Colors.white)),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getStatusColorFunc(p['status_player'] ?? ''),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              p['status_player'].toString().toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
