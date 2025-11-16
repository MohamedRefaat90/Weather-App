import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Glassmorphism container with blur effect
class GlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<Color>? gradientColors;
  final double blurStrength;
  final double opacity;

  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.padding,
    this.margin,
    this.gradientColors,
    this.blurStrength = 10,
    this.opacity = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    final defaultGradient = [
      Colors.white.withOpacity(0.2),
      Colors.white.withOpacity(0.1),
    ];

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors ?? defaultGradient,
            ),
          ),
          padding: padding ?? const EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }
}

/// Animated gradient card
class GradientCard extends StatelessWidget {
  final Widget child;
  final List<Color> gradientColors;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const GradientCard({
    super.key,
    required this.child,
    required this.gradientColors,
    this.borderRadius = 20,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: padding ?? const EdgeInsets.all(20),
      child: child,
    );
  }
}

/// Particle effect background
class ParticleBackground extends StatelessWidget {
  final Widget child;
  final Color particleColor;

  const ParticleBackground({
    super.key,
    required this.child,
    this.particleColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Particle layer (placeholder - can be enhanced with custom painter)
        Positioned.fill(
          child: CustomPaint(
            painter: ParticlePainter(color: particleColor),
          ),
        ),
        child,
      ],
    );
  }
}

class ParticlePainter extends CustomPainter {
  final Color color;

  ParticlePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Draw simple particles
    for (var i = 0; i < 20; i++) {
      final x = (i * 50.0) % size.width;
      final y = (i * 37.0) % size.height;
      canvas.drawCircle(Offset(x, y), 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Pulsing dot indicator
class PulsingDot extends StatelessWidget {
  final Color color;
  final double size;

  const PulsingDot({
    super.key,
    required this.color,
    this.size = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .scale(begin: const Offset(1, 1), end: const Offset(1.3, 1.3))
        .then()
        .scale(begin: const Offset(1.3, 1.3), end: const Offset(1, 1));
  }
}

/// Shimmer loading placeholder that mimics weather card
class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final shimmerBase = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final shimmerHighlight = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Main card shimmer
          GlassCard(
            child: Column(
              children: [
                // Location shimmer
                _ShimmerBox(
                  width: 200,
                  height: 24,
                  color: shimmerBase,
                  highlightColor: shimmerHighlight,
                ),
                const SizedBox(height: 32),
                // Weather icon placeholder
                _ShimmerBox(
                  width: 150,
                  height: 150,
                  color: shimmerBase,
                  highlightColor: shimmerHighlight,
                  isCircle: true,
                ),
                const SizedBox(height: 24),
                // Temperature shimmer
                _ShimmerBox(
                  width: 120,
                  height: 72,
                  color: shimmerBase,
                  highlightColor: shimmerHighlight,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Hourly forecast shimmer
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GlassCard(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      _ShimmerBox(
                        width: 60,
                        height: 16,
                        color: shimmerBase,
                        highlightColor: shimmerHighlight,
                      ),
                      const SizedBox(height: 12),
                      _ShimmerBox(
                        width: 40,
                        height: 40,
                        color: shimmerBase,
                        highlightColor: shimmerHighlight,
                        isCircle: true,
                      ),
                      const SizedBox(height: 12),
                      _ShimmerBox(
                        width: 40,
                        height: 20,
                        color: shimmerBase,
                        highlightColor: shimmerHighlight,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated temperature display
class TemperatureDisplay extends StatelessWidget {
  final double temperature;
  final bool isCelsius;

  const TemperatureDisplay({
    super.key,
    required this.temperature,
    this.isCelsius = true,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${temperature.round()}°${isCelsius ? 'C' : 'F'}',
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 80,
          ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .scale(begin: const Offset(0.5, 0.5), duration: 400.ms);
  }
}

/// Animated weather icon container
class WeatherIconContainer extends StatelessWidget {
  final String assetPath;
  final double size;

  const WeatherIconContainer({
    super.key,
    required this.assetPath,
    this.size = 150,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(assetPath)
          .animate()
          .fadeIn(duration: 600.ms)
          .scale(begin: const Offset(0.8, 0.8), duration: 400.ms)
          .then()
          .shimmer(duration: 2000.ms, delay: 1000.ms),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Color highlightColor;
  final bool isCircle;

  const _ShimmerBox({
    required this.width,
    required this.height,
    required this.color,
    required this.highlightColor,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: isCircle ? null : BorderRadius.circular(8),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
    ).animate(onPlay: (controller) => controller.repeat()).shimmer(
          duration: 1500.ms,
          color: highlightColor,
        );
  }
}
