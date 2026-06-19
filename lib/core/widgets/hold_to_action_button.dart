/// File: lib/core/widgets/hold_to_action_button.dart
/// Generated Documentation for hold_to_action_button.dart

import 'dart:async';
import 'package:flutter/material.dart';

/// Class representing `HoldToActionButton`.
/// Auto-generated class documentation.
class HoldToActionButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final Duration duration;
  final String snackBarMessage;

  const HoldToActionButton({
    super.key,
    required this.child,
    required this.onTap,
    this.duration = const Duration(seconds: 3),
    this.snackBarMessage = 'tekan dan tahan selama 3 detik',
  });

  @override
  State<HoldToActionButton> createState() => _HoldToActionButtonState();
}

/// Class representing `_HoldToActionButtonState`.
/// Auto-generated class documentation.
class _HoldToActionButtonState extends State<HoldToActionButton> {
  Timer? _timer;
  DateTime? _pressStartTime;
  bool _actionTriggered = false;

  /// Method `_startTimer` returning `void`.
  /// Handles logic operations related to `_startTimer`.
  void _startTimer() {
    _pressStartTime = DateTime.now();
    _actionTriggered = false;
    _timer?.cancel();

    _timer = Timer(widget.duration, () {
      if (mounted && _pressStartTime != null && !_actionTriggered) {
        _actionTriggered = true;
        _timer = null;
        _pressStartTime = null;
        widget.onTap();
      }
    });
  }

  /// Method `_cancelTimer` returning `void`.
  /// Handles logic operations related to `_cancelTimer`.
  void _cancelTimer() {
    if (_pressStartTime == null) return;

    _timer?.cancel();
    _timer = null;

    if (!_actionTriggered) {
      _actionTriggered = true;
      _pressStartTime = null;

      // Show snackbar notifying the user to hold for 3 seconds
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.snackBarMessage),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  /// Method `dispose` returning `void`.
  /// Handles logic operations related to `dispose`.
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _startTimer(),
      onPointerUp: (_) => _cancelTimer(),
      onPointerCancel: (_) => _cancelTimer(),
      child: widget.child,
    );
  }
}
