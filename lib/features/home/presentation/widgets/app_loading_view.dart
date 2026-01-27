import 'package:flutter/material.dart';

class AppLoadingView extends StatelessWidget {
  final String? message;
  final bool showMessage;

  const AppLoadingView({super.key, this.message, this.showMessage = true});

  @override
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
