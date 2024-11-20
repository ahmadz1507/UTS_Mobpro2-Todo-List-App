import 'package:flutter/material.dart';
import 'add_task.dart';
import 'task_detail.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<Map<String, String>> tasks = [
    {'title': 'Tugas 1', 'note': 'Catatan tugas 1', 'time': '08:00', 'date': '2024-11-19'},
    {'title': 'Tugas 2', 'note': 'Catatan tugas 2', 'time': '10:00', 'date': '2024-11-20'},
    {'title': 'Tugas 3', 'note': 'Catatan tugas 3', 'time': '14:00', 'date': '2024-11-19'},
  ];

  String _selectedDate = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  List<Map<String, String>> _getFilteredTasks() {
    return tasks
        .where((task) => _selectedDate.isEmpty || task['date'] == _selectedDate)
        .toList();
  }

  void _addTask(Map<String, String> newTask) {
    setState(() {
      tasks.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredTasks = _getFilteredTasks();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // tombol back tidak aktif
        title: Text(
          'Tugas Anda',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final newTask = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTaskPage()),
              );
              if (newTask != null && newTask['title']!.isNotEmpty) {
                _addTask(newTask);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.blue[800]),
                    SizedBox(width: 10),
                    Text(
                      _selectedDate.isEmpty ? 'Pilih Tanggal' : _selectedDate,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue[800],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: filteredTasks.isEmpty
                  ? Center(
                      child: Text(
                        'Tidak ada tugas untuk ditampilkan.',
                        style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 232, 232, 232)),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredTasks.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            filteredTasks[index]['title'] ?? 'Tugas',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                              '${filteredTasks[index]['time']} | ${filteredTasks[index]['date']}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TaskDetailPage(task: filteredTasks[index]),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}