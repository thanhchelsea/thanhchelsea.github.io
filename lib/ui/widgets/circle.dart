import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SpritePainter extends CustomPainter  {
  final Animation<double> _animation;

  SpritePainter(this._animation) : super(repaint: _animation);

  void circle(Canvas canvas, Rect rect, double value) {
    double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    Color color = new Color.fromRGBO(0, 117, 194, opacity);

    double size = rect.width / 2;
    double area = size * size;
    double radius = sqrt(area * value / 4);

    final Paint paint = new Paint()..color = color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = new Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(SpritePainter oldDelegate) {
    return true;
  }
}

class SpriteDemo extends StatefulWidget {
  @override
  SpriteDemoState createState() => new SpriteDemoState();
}

class SpriteDemoState extends State<SpriteDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
    );
    //_startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.stop();
    _controller.reset();
    _controller.repeat(
      period: Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new CustomPaint(
        painter: new SpritePainter(_controller),
        child: Container(
          width: 100,height: 100,
        )
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _startAnimation,
        child: new Icon(Icons.play_arrow),
      ),
    );
  }
}
