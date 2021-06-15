import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:g60/widgets/Timer/timer_colors.dart';


class TimerWidget extends StatefulWidget {

  final Color timerTextColor;
  final int timerValue;
  final int timerDuration;
  final AnimationController animationController;

  TimerWidget({
    required this.timerValue,
    required this.timerDuration,
    required this.animationController,
    required this.timerTextColor,

  });


  @override
  TimerWidgetState createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: widget.animationController,
                    builder: (BuildContext context, Widget? child) {
                      return CustomPaint(
                          painter: TimerPainter(
                            animation: widget.animationController,
                            backgroundColor: timerBackgroundColor(),
                            color: timerProgressColor(),
                          ));
                    },
                  ),
                ),
                Align(
                  alignment: FractionalOffset.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      AnimatedBuilder(
                          animation: widget.animationController,
                          builder: (BuildContext context, Widget? child) {
                            return Text(
                              widget.timerValue == 0 ? widget.timerDuration.toString() : widget.timerValue.toString(),
                              style: themeData.textTheme.headline2!.copyWith(color: widget.timerTextColor),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}