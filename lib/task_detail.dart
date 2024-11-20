import 'package:flutter/material.dart';

class TaskDetailPage extends StatelessWidget {
  final Map<String, String> task;

  TaskDetailPage({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task['title'] ?? 'Detail Tugas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Catatan:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 5),
            Text(
              task['note'] ?? 'Tidak ada catatan',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Waktu:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 5),
            Text(
              '${task['time'] ?? 'Tidak tersedia'} | ${task['date'] ?? 'Tidak tersedia'}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
