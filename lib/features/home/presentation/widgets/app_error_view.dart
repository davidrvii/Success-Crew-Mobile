/// File: lib/features/home/presentation/widgets/app_error_view.dart
/// Generated Documentation for app_error_view.dart

import 'package:flutter/material.dart';

/// Class representing `AppErrorView`.
/// Auto-generated class documentation.
class AppErrorView extends StatelessWidget {
  final String title;
  final String message;

  final Future<void> Function()? onRetry;

  final String retryText;
  final IconData icon;

  const AppErrorView({
    super.key,
    this.title = 'Somthing went wrong',
    required this.message,
    this.onRetry,
    this.retryText = 'Retry',
    this.icon = Icons.error_outline_rounded,
  });

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 42),
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
            if (onRetry != null) ...[
              const SizedBox(height: 14),
              ElevatedButton(
                onPressed: () => onRetry!(),
                child: Text(retryText),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
