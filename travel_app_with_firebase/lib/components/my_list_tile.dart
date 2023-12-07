import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({Key? key, required this.title, required this.onDelete})
      : super(key: key);

  final String title;

  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(title),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}
