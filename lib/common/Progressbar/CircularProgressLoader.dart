import 'dart:math';
import 'package:flutter/material.dart';

const double _doublePi = 2 * pi;

const double _piDiv180 = pi / 180;

double _degToRad(double degree) {
  return degree * _piDiv180;
}

typedef OnGetCenterText = Text Function(double);

class CircularProgressLoader extends StatefulWidget {
  final double size;

  final double maxValue;

  final double startAngle;

  final double progressStrokeWidth;

  final double backStrokeWidth;

  final List<Color> progressColors;

  final Color? fullProgressColor;

  final Color backColor;

  final int animationDuration;

  final bool mergeMode;

  final ValueNotifier<double>? valueNotifier;

  final OnGetCenterText? onGetText;

  const CircularProgressLoader({
    Key? key,
    this.size = 100,
    this.maxValue = 100,
    this.startAngle = 0,
    this.progressStrokeWidth = 15,
    this.backStrokeWidth = 15,
    this.progressColors = const [Colors.blueAccent, Colors.greenAccent],
    this.fullProgressColor,
    this.backColor = const Color(0xFF16262D),
    this.animationDuration = 6,
    this.mergeMode = false,
    this.valueNotifier,
    this.onGetText,
  }) : super(key: key);

  @override
  _CircularProgressLoaderState createState() => _CircularProgressLoaderState();
}

class _CircularProgressLoaderState extends State<CircularProgressLoader>
    with SingleTickerProviderStateMixin {
  final double minSweepAngle = 0.015;

  late double circleLength;
  late double maxValue;
  late double widgetSize;

  late double startAngle;
  late double correctAngle;
  late SweepGradient sweepGradient;

  late AnimationController animationController;

  late Color fullProgressColor;

  late ValueNotifier<double> valueNotifier;
  late ValueNotifier<double>? defaultValueNotifier;

  @override
  void initState() {
    super.initState();

    widgetSize = (widget.size <= 0) ? 100.0 : widget.size;
    maxValue = (widget.maxValue <= 0) ? 100.0 : widget.maxValue;

    if (widget.valueNotifier != null) {
      defaultValueNotifier = null;
      valueNotifier = widget.valueNotifier!;
    } else {
      defaultValueNotifier = ValueNotifier(widget.maxValue);
      valueNotifier = defaultValueNotifier!;
    }

    circleLength = pi * widgetSize;
    final k = _doublePi / circleLength;

    correctAngle = widget.progressStrokeWidth * k;
    startAngle = (correctAngle / 2);

    final List<Color> progressColors = [];
    if (widget.progressColors.isEmpty) {
      progressColors.add(Colors.blueAccent);
      progressColors.add(Colors.greenAccent);
    } else if (widget.progressColors.length == 1) {
      progressColors.add(widget.progressColors[0]);
      progressColors.add(widget.progressColors[0]);
    } else {
      progressColors.addAll(widget.progressColors);
    }

    sweepGradient = SweepGradient(
      tileMode: TileMode.decal,
      colors: progressColors,
    );

    fullProgressColor =
        (widget.fullProgressColor == null)
            ? progressColors.last
            : widget.fullProgressColor!;

    final animationDuration =
        (widget.animationDuration < 0) ? 0 : widget.animationDuration;

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: animationDuration),
      value: 0.0,
      upperBound: maxValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (BuildContext context, double value, Widget? child) {
        if (value > maxValue) {
          value = maxValue;
        } else if (value < 0) {
          value = 0;
        }

        if (value < animationController.value) {
          animationController.forward();
        } else {
          animationController.animateTo(value);
        }

        return AnimatedBuilder(
          animation: animationController,
          builder: (context, snapshot) {
            if ((value != animationController.upperBound) &&
                (animationController.value >= animationController.upperBound)) {
              animationController.reset();
              animationController.animateTo(value);
            }

            double sweepAngle;

            final reducedValue = animationController.value / maxValue;

            if (animationController.value == 0) {
              sweepAngle = 0;
            } else {
              sweepAngle = (_doublePi * reducedValue) - correctAngle;

              if (sweepAngle <= 0) {
                sweepAngle = minSweepAngle;
              }
            }

            final currentLength = reducedValue * circleLength;

            final isFullProgress =
                widget.mergeMode &
                (animationController.value == animationController.upperBound);

            Widget centerTextWidget;
            if (widget.onGetText != null) {
              centerTextWidget = widget.onGetText!(animationController.value);
            } else {
              centerTextWidget = const SizedBox.shrink();
            }

            return Stack(
              alignment: Alignment.center,
              children: [
                centerTextWidget,
                Transform.rotate(
                  angle: _degToRad(widget.startAngle - 90),
                  child: CustomPaint(
                    size: Size(widgetSize, widgetSize),
                    painter: _CircularProgressLoaderPainter(
                      progressStrokeWidth: widget.progressStrokeWidth,
                      backStrokeWidth: widget.backStrokeWidth,
                      startAngle: startAngle,
                      sweepAngle: sweepAngle,
                      currentLength: currentLength,
                      frontGradient: sweepGradient,
                      backColor: widget.backColor,
                      fullProgressColor: fullProgressColor,
                      isFullProgress: isFullProgress,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();

    if (defaultValueNotifier != null) {
      defaultValueNotifier!.dispose();
    }

    super.dispose();
  }
}

class _CircularProgressLoaderPainter extends CustomPainter {
  final double progressStrokeWidth;
  final double backStrokeWidth;
  final double startAngle;
  final double sweepAngle;
  final double currentLength;
  final SweepGradient frontGradient;
  final Color backColor;
  final Color fullProgressColor;
  final bool isFullProgress;

  _CircularProgressLoaderPainter({
    required this.progressStrokeWidth,
    required this.backStrokeWidth,
    required this.startAngle,
    required this.sweepAngle,
    required this.currentLength,
    required this.frontGradient,
    required this.backColor,
    required this.fullProgressColor,
    required this.isFullProgress,
  });

  void _drawBack(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = backColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = backStrokeWidth;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
  }

  void _drawLessArcPart(Canvas canvas, Size size) {
    double angle = 0;
    double height = 0;

    if (currentLength < progressStrokeWidth / 2) {
      angle = 180;
      height = progressStrokeWidth - currentLength * 2;
    } else if (currentLength < progressStrokeWidth) {
      angle = 0;
      height = currentLength * 2 - progressStrokeWidth;
    } else {
      return;
    }

    final Paint pathPaint =
        Paint()
          ..shader = frontGradient.createShader(Offset.zero & size)
          ..style = PaintingStyle.fill;

    final Offset circleOffset = Offset(
      (size.width / 2) * cos(startAngle) + size.center(Offset.zero).dx,
      (size.width / 2) * sin(startAngle) + size.center(Offset.zero).dy,
    );

    canvas.drawPath(
      Path.combine(
        PathOperation.xor,
        Path()..addArc(
          Rect.fromLTWH(
            circleOffset.dx - progressStrokeWidth / 2,
            circleOffset.dy - progressStrokeWidth / 2,
            progressStrokeWidth,
            progressStrokeWidth,
          ),
          _degToRad(180),
          _degToRad(180),
        ),
        Path()..addArc(
          Rect.fromCenter(
            center: circleOffset,
            width: progressStrokeWidth,
            height: height,
          ),
          _degToRad(angle),
          _degToRad(180),
        ),
      ),
      pathPaint,
    );
  }

  void _drawArcPart(Canvas canvas, Size size) {
    final Rect arcRect = Offset.zero & size;

    final Paint arcPaint =
        Paint()
          ..shader = frontGradient.createShader(arcRect)
          ..strokeWidth = progressStrokeWidth
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

    canvas.drawArc(arcRect, startAngle, sweepAngle, false, arcPaint);
  }

  void _drawFullProgress(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = fullProgressColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = progressStrokeWidth;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (isFullProgress && (progressStrokeWidth > 0)) {
      _drawFullProgress(canvas, size);
      return;
    }

    if (backStrokeWidth > 0) {
      _drawBack(canvas, size);
    }

    if (progressStrokeWidth <= 0) {
      return;
    } else if (progressStrokeWidth >= currentLength) {
      _drawLessArcPart(canvas, size);
    } else {
      _drawArcPart(canvas, size);
    }
  }

  @override
  bool shouldRepaint(_CircularProgressLoaderPainter oldDelegate) {
    return oldDelegate.currentLength != currentLength;
  }
}
