import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  const PostButton({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
            child: Icon(
          Icons.done,
          color: Theme.of(context).colorScheme.primary,
        )),
      ),
    );
  }
}
