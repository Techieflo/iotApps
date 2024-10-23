import 'package:flutter/material.dart';

class RippleEffectScreen extends StatefulWidget {
  @override
  _RippleEffectScreenState createState() => _RippleEffectScreenState();
}

class _RippleEffectScreenState extends State<RippleEffectScreen>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ripple Effect Animation'),
      ),
      body: GestureDetector(
        onTap: _startAnimation,
        child: Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: screenWidth,
                height: screenHeight * 0.5 +
                    (screenHeight * 0.5 * _animation.value),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.blue.withOpacity(1.0 - _animation.value),
                      Colors.blueAccent
                          .withOpacity(0.8 - _animation.value * 0.8),
                    ],
                    stops: [0.0, _animation.value],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
