import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum AppButtonVariant { primary, success, danger, outline, ghost }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool fullWidth;
  final AppButtonVariant variant;
  final IconData? icon;
  final double height;
  final double radius;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.fullWidth = true,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.height = 52,
    this.radius = 16,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;

    final Widget child = Row(
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              valueColor: AlwaysStoppedAnimation<Color>(
                _foregroundColor(context),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ] else if (icon != null) ...[
          Icon(icon, size: 20, color: _foregroundColor(context)),
          const SizedBox(width: 10),
        ],
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: _foregroundColor(context),
          ),
        ),
      ],
    );

    final btn = switch (variant) {
      AppButtonVariant.primary => ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: _elevatedStyle(context, background: AppTheme.primary),
        child: child,
      ),
      AppButtonVariant.success => ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: _elevatedStyle(context, background: AppTheme.success),
        child: child,
      ),
      AppButtonVariant.danger => ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: _elevatedStyle(context, background: AppTheme.error),
        child: child,
      ),
      AppButtonVariant.outline => OutlinedButton(
        onPressed: enabled ? onPressed : null,
        style: _outlinedStyle(context),
        child: child,
      ),
      AppButtonVariant.ghost => TextButton(
        onPressed: enabled ? onPressed : null,
        style: _textStyle(context),
        child: child,
      ),
    };

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: height,
      child: btn,
    );
  }

  Color _foregroundColor(BuildContext context) {
    return switch (variant) {
      AppButtonVariant.outline => AppTheme.primary,
      AppButtonVariant.ghost => AppTheme.primary,
      _ => Colors.white,
    };
  }

  ButtonStyle _elevatedStyle(
    BuildContext context, {
    required Color background,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: background,
      foregroundColor: Colors.white,
      disabledBackgroundColor: background.withValues(alpha: 0.45),
      disabledForegroundColor: Colors.white.withValues(alpha: 0.9),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  ButtonStyle _outlinedStyle(BuildContext context) {
    return OutlinedButton.styleFrom(
      foregroundColor: AppTheme.primary,
      side: const BorderSide(color: AppTheme.primary, width: 1.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  ButtonStyle _textStyle(BuildContext context) {
    return TextButton.styleFrom(
      foregroundColor: AppTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
    );
  }
}

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final double radius;
  final Color? backgroundColor;
  final Color? iconColor;

  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 44,
    this.radius = 14,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppTheme.primary.withValues(alpha: 0.12);
    final ic = iconColor ?? AppTheme.primary;

    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onPressed,
          child: Icon(icon, color: ic, size: 22),
        ),
      ),
    );
  }
}
