/// File: lib/features/home/presentation/widgets/app_loading_view.dart
/// Generated Documentation for app_loading_view.dart

import 'package:flutter/material.dart';

/// Class representing `AppLoadingView`.
/// Auto-generated class documentation.
class AppLoadingView extends StatelessWidget {
  final String? message;
  final bool showMessage;

  const AppLoadingView({super.key, this.message, this.showMessage = true});

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    final text = message ?? 'Loading...';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            if (showMessage) ...[
              const SizedBox(height: 12),
              Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
