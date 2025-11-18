import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Toggle button for switching between list and chart view
class ViewToggleButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const ViewToggleButton({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.white.withOpacity(0.9);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? textColor.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: isSelected ? textColor : textColor.withOpacity(0.5),
          size: 20,
        ),
      ),
    );
  }
}
