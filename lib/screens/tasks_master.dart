import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_preview.dart';
import 'tasks_details.dart';

class TasksMaster extends StatefulWidget {
  const TasksMaster({super.key});

  @override
  State<TasksMaster> createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {
  Future<List<Task>> _fetchTasks() async {
    await Future.delayed(const Duration(seconds: 1));

    final faker = Faker();

    return List.generate(100, (index) {
      final bool isCompleted = faker.randomGenerator.boolean();

      return Task(
        id: index + 1,
        title: 'Tâche ${index + 1}',
        content: faker.lorem.sentence(),
        completed: isCompleted,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: _fetchTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Erreur lors du chargement des tâches'),
          );
        }

        final tasks = snapshot.data ?? [];

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return TaskPreview(
              task: tasks[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetails(task: tasks[index]),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}