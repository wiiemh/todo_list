import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_preview.dart';
import 'tasks_details.dart';

class TasksMaster extends StatefulWidget {
  final dynamic controller;

  const TasksMaster({super.key, this.controller});

  @override
  State<TasksMaster> createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {
  late List<Task> _tasks = [];
  bool _isLoading = true;

  int get taskCount => _tasks.length;

  void addTask(Task newTask) {
    setState(() {
      _tasks.add(newTask);
      // Mettre à jour le contrôleur
      if (widget.controller != null) {
        widget.controller.taskCount = _tasks.length;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadTasks();
    
    // Configurer le contrôleur
    if (widget.controller != null) {
      widget.controller.taskCount = taskCount;
      widget.controller.onAddTask = addTask;
    }
  }

  Future<void> _loadTasks() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final faker = Faker();

    setState(() {
      _tasks = List.generate(100, (index) {
        final bool isCompleted = faker.randomGenerator.boolean();

        return Task(
          id: index + 1,
          title: 'Tâche ${index + 1}',
          content: faker.lorem.sentence(),
          completed: isCompleted,
        );
      });
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return _tasks.isEmpty
        ? const Center(
            child: Text('Aucune tâche. Créez-en une !'),
          )
        : ListView.builder(
            itemCount: _tasks.length,
            itemBuilder: (context, index) {
              return TaskPreview(
                task: _tasks[index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetails(task: _tasks[index]),
                    ),
                  );
                },
              );
            },
          );
  }
}