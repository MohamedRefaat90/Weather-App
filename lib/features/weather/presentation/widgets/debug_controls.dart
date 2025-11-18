import 'package:flutter/material.dart';

/// Debug controls for testing weather gradients and animations
class DebugControls extends StatelessWidget {
  final bool debugMode;
  final int currentDebugIndex;
  final List<Map<String, dynamic>> debugWeatherCodes;
  final VoidCallback onToggleDebug;
  final VoidCallback onCycleWeather;

  const DebugControls({
    super.key,
    required this.debugMode,
    required this.currentDebugIndex,
    required this.debugWeatherCodes,
    required this.onToggleDebug,
    required this.onCycleWeather,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Debug toggle button in app bar
        if (debugMode)
          FloatingActionButton.extended(
            onPressed: onCycleWeather,
            icon: const Icon(Icons.navigate_next),
            label: Text(debugWeatherCodes[currentDebugIndex]['name']),
            backgroundColor: Colors.white.withOpacity(0.9),
            foregroundColor: Colors.black87,
          ),
      ],
    );
  }
}

/// Debug toggle button for app bar
class DebugToggleButton extends StatelessWidget {
  final bool debugMode;
  final VoidCallback onToggle;

  const DebugToggleButton({
    super.key,
    required this.debugMode,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(debugMode ? Icons.bug_report : Icons.bug_report_outlined),
      onPressed: onToggle,
      tooltip: 'Toggle Debug Mode',
    );
  }
}
