import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import '../services/api_service.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Todo>> _todosFuture;

  // Filter state
  String _filter = 'Semua'; // 'Semua', 'Selesai', 'Belum'

  @override
  void initState() {
    super.initState();
    _todosFuture = _apiService.fetchTodos();
  }

  List<Todo> _applyFilter(List<Todo> todos) {
    if (_filter == 'Selesai') return todos.where((t) => t.completed).toList();
    if (_filter == 'Belum') return todos.where((t) => !t.completed).toList();
    return todos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F46E5),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Todo List',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              'jsonplaceholder.typicode.com',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () {
              setState(() {
                _todosFuture = _apiService.fetchTodos();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            color: const Color(0xFF4F46E5),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              children: ['Semua', 'Selesai', 'Belum'].map((label) {
                final isSelected = _filter == label;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(label),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _filter = label),
                    backgroundColor: Colors.white24,
                    selectedColor: const Color.fromARGB(255, 255, 255, 255),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? const Color(0xFF4F46E5)
                          : const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    checkmarkColor: const Color(0xFF4F46E5),
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                  ),
                );
              }).toList(),
            ),
          ),

          // Content
          Expanded(
            child: FutureBuilder<List<Todo>>(
              future: _todosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Color(0xFF4F46E5),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Memuat data...',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.wifi_off_rounded,
                            size: 64,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Koneksi Gagal',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${snapshot.error}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                _todosFuture = _apiService.fetchTodos();
                              });
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Coba Lagi'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4F46E5),
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final allTodos = snapshot.data!;
                final todos = _applyFilter(allTodos);

                // Stats bar
                final selesai = allTodos.where((t) => t.completed).length;
                final belum = allTodos.length - selesai;

                return Column(
                  children: [
                    // Stats
                    Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStat('Total', allTodos.length, Colors.indigo),
                          _buildDivider(),
                          _buildStat('Selesai', selesai, Colors.green),
                          _buildDivider(),
                          _buildStat('Belum', belum, Colors.orange),
                        ],
                      ),
                    ),

                    // List
                    Expanded(
                      child: todos.isEmpty
                          ? const Center(
                              child: Text(
                                'Tidak ada data.',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                              itemCount: todos.length,
                              itemBuilder: (context, index) {
                                return _buildTodoCard(todos[index]);
                              },
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          '$value',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(height: 32, width: 1, color: Colors.grey.shade200);
  }

  Widget _buildTodoCard(Todo todo) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: todo.completed ? Colors.green : Colors.orange,
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: CircleAvatar(
          radius: 16,
          backgroundColor: todo.completed
              ? Colors.green.shade50
              : Colors.orange.shade50,
          child: Icon(
            todo.completed ? Icons.check_circle : Icons.radio_button_unchecked,
            color: todo.completed ? Colors.green : Colors.orange,
            size: 20,
          ),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            decoration:
                todo.completed ? TextDecoration.lineThrough : null,
            color: todo.completed ? Colors.grey : Colors.black87,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '#${todo.id}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'User ${todo.userId}',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}