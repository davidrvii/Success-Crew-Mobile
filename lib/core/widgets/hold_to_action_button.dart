import 'dart:async';
import 'package:flutter/material.dart';

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

class _HoldToActionButtonState extends State<HoldToActionButton> {
  Timer? _timer;
  DateTime? _pressStartTime;
  bool _actionTriggered = false;

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
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _startTimer(),
      onPointerUp: (_) => _cancelTimer(),
      onPointerCancel: (_) => _cancelTimer(),
      child: widget.child,
    );
  }
}
