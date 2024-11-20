import 'package:flutter/material.dart';

class CompletedTasksPage extends StatelessWidget {
  final List<Map<String, String>> completedTasks = [
    {'title': 'Tugas 3', 'note': 'Catatan tugas 3', 'status': 'Selesai'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hilangkan tombol back <
        title: Text(
          'Tugas Selesai',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: completedTasks.isEmpty
            ? Center(
                child: Text(
                  'Belum ada tugas yang selesai.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: completedTasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(
                        completedTasks[index]['title']!,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(completedTasks[index]['note']!),
                      trailing: Icon(Icons.check_circle, color: Colors.green),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
