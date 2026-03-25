import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskPreview extends StatelessWidget {
  final Task task;

  const TaskPreview({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Icon(
          task.completed ? Icons.check_circle : Icons.radio_button_unchecked,
          color: task.completed ? Colors.green : Colors.orange,
        ),
        title: Text(task.title ?? 'Sans titre'),
        subtitle: Text(task.content),
        trailing: Text(
          task.completed ? 'Terminée' : 'En cours',
          style: TextStyle(
            color: task.completed ? Colors.green : Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}