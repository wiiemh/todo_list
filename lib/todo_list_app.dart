import 'package:flutter/material.dart';
import 'screens/tasks_master.dart';
import 'screens/task_create.dart';
import 'models/task.dart';

class ToDoListApp extends StatefulWidget {
  const ToDoListApp({super.key});

  @override
  State<ToDoListApp> createState() => _ToDoListAppState();
}

class _ToDoListAppState extends State<ToDoListApp> {
  final _TasksMasterController _controller = _TasksMasterController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ToDo List'),
        ),
        body: TasksMaster(controller: _controller),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () async {
                final nextId = (_controller.taskCount ?? 0) + 1;

                final navigator = Navigator.of(context); // capture ici
                final newTask = await navigator.push<Task>(
                  MaterialPageRoute(builder: (_) => TaskCreate(nextId: nextId)),
                );

                if (!mounted) return; // gardé avant toute interaction avec State/context

                if (newTask != null && _controller.onAddTask != null) {
                  _controller.onAddTask!(newTask);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tâche créée'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}

class _TasksMasterController {
  Function(Task)? onAddTask;
  int? taskCount;
}