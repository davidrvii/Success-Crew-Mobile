import 'package:flutter/material.dart';

class AppEmptyView extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  final VoidCallback? onAction;
  final String actionText;

  const AppEmptyView({
    super.key,
    this.title = 'No Data',
    this.message = 'There is no data to present.',
    this.icon = Icons.inbox_outlined,
    this.onAction,
    this.actionText = 'Reload',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 44),
            const SizedBox(height: 10),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (onAction != null) ...[
              const SizedBox(height: 14),
              OutlinedButton(onPressed: onAction, child: Text(actionText)),
            ],
          ],
        ),
      ),
    );
  }
}
