import 'package:flutter/material.dart';

class ShimmerBox extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const baseColor = Color(0xFFE7DCCB);
    const highlightColor = Color(0xFFF6EDE0);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final shimmerPosition = _controller.value * 2 - 1;
          return ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: const [baseColor, highlightColor, baseColor],
                stops: const [0.1, 0.5, 0.9],
                begin: Alignment(-1 - shimmerPosition, 0),
                end: Alignment(1 - shimmerPosition, 0),
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: child,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: widget.borderRadius,
          ),
        ),
      ),
    );
  }
}
