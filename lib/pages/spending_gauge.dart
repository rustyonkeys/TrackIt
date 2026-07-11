import 'package:flutter/material.dart';
import 'dart:math' as math;

class RotarySpendingGauge extends StatefulWidget {
  const RotarySpendingGauge({super.key});

  @override
  State<RotarySpendingGauge> createState() => _RotarySpendingGaugeState();
}

class _RotarySpendingGaugeState extends State<RotarySpendingGauge> {
  double totalRotation = 0.85;
  double previousAngle = 0.0;
  double spendingAmount = 2114.99;
  final double maxAmount = 5000.0;
  final TextEditingController _controller = TextEditingController(text: '2114');
  final TextEditingController _centsController = TextEditingController(
    text: '99',
  );

  // Design variations - switch between them
  int currentDesign = 1; // 1, 2, or 3

  @override
  void dispose() {
    _controller.dispose();
    _centsController.dispose();
    super.dispose();
  }

  void _updateAmount(double rotation) {
    setState(() {
      double percentage = (rotation / (1.5 * math.pi)).clamp(0.0, 1.0);
      spendingAmount = (percentage * maxAmount).clamp(0.0, maxAmount);

      int dollars = spendingAmount.floor();
      int cents = ((spendingAmount - dollars) * 100).round();

      _controller.text = dollars.toString();
      _centsController.text = cents.toString().padLeft(2, '0');
    });
  }

  void _onPanUpdate(DragUpdateDetails details, Offset center) {
    final touchPosition = details.localPosition;
    final angle = math.atan2(
      touchPosition.dy - center.dy,
      touchPosition.dx - center.dx,
    );

    setState(() {
      double delta = angle - previousAngle;

      if (delta > math.pi) {
        delta -= 2 * math.pi;
      } else if (delta < -math.pi) {
        delta += 2 * math.pi;
      }

      totalRotation += delta;
      totalRotation = totalRotation.clamp(0.0, 1.5 * math.pi);
      previousAngle = angle;

      _updateAmount(totalRotation);
    });
  }

  void _onPanStart(DragStartDetails details, Offset center) {
    final touchPosition = details.localPosition;
    previousAngle = math.atan2(
      touchPosition.dy - center.dy,
      touchPosition.dx - center.dx,
    );
  }

  void _onTextFieldChanged() {
    final dollars = double.tryParse(_controller.text) ?? 0;
    final cents = double.tryParse(_centsController.text) ?? 0;
    final newAmount = dollars + (cents / 100);

    if (newAmount >= 0 && newAmount <= maxAmount) {
      setState(() {
        spendingAmount = newAmount;
        totalRotation = (spendingAmount / maxAmount) * 1.5 * math.pi;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: _getBackgroundGradient()),
        child: SafeArea(
          child: Stack(
            children: [
              // Circular gauge
              Positioned.fill(
                child: GestureDetector(
                  onPanStart: (details) {
                    final center = Offset(size.width / 2, size.height * 0.32);
                    _onPanStart(details, center);
                  },
                  onPanUpdate: (details) {
                    final center = Offset(size.width / 2, size.height * 0.32);
                    _onPanUpdate(details, center);
                  },
                  child: CustomPaint(
                    painter: RotaryGaugePainter(
                      rotation: totalRotation,
                      maxRotation: 1.5 * math.pi,
                      screenHeight: size.height,
                      designType: currentDesign,
                    ),
                  ),
                ),
              ),

              // Amount display
              Positioned(
                top: size.height * 0.24,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    // Amount with better alignment
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Text(
                            '\$',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w300,
                              color: _getTextColor().withValues(alpha: 0.6),
                              height: 1.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        IntrinsicWidth(
                          child: TextField(
                            controller: _controller,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 72,
                              fontWeight: FontWeight.w200,
                              color: _getTextColor(),
                              height: 1.0,
                              letterSpacing: -3,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              hintText: '0',
                              hintStyle: TextStyle(
                                color: _getTextColor().withValues(alpha: 0.3),
                              ),
                            ),
                            onChanged: (value) => _onTextFieldChanged(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Text(
                            '.',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w300,
                              color: _getTextColor().withValues(alpha: 0.6),
                              height: 1.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: TextField(
                            controller: _centsController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w300,
                              color: _getTextColor().withValues(alpha: 0.6),
                              height: 1.0,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.only(top: 12),
                              hintText: '00',
                              hintStyle: TextStyle(
                                color: _getTextColor().withValues(alpha: 0.3),
                              ),
                            ),
                            onChanged: (value) => _onTextFieldChanged(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Monthly spending',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: _getTextColor().withValues(alpha: 0.5),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Design selector (for demo - remove in production)
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDesignButton(1, 'Gradient'),
                    SizedBox(width: 12),
                    _buildDesignButton(2, 'Neon'),
                    SizedBox(width: 12),
                    _buildDesignButton(3, 'Minimal'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesignButton(int design, String label) {
    final isSelected = currentDesign == design;
    return GestureDetector(
      onTap: () => setState(() => currentDesign = design),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color:
              isSelected
                   ? Colors.white.withValues(alpha: 0.9)
                   : Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
             color: Colors.white.withValues(alpha: isSelected ? 0.5 : 0.3),
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color:
                isSelected ? Colors.black87 : Colors.white.withValues(alpha: 0.8),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  LinearGradient _getBackgroundGradient() {
    switch (currentDesign) {
      case 1: // Gradient (original)
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE8F4F4), Color(0xFFB8D8DC), Color(0xFF8AB4BA)],
        );
      case 2: // Neon dark
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1a1a2e), Color(0xFF16213e), Color(0xFF0f3460)],
        );
      case 3: // Minimal light
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF8F9FA), Color(0xFFE9ECEF), Color(0xFFDEE2E6)],
        );
      default:
        return LinearGradient(colors: [Colors.white, Colors.white]);
    }
  }

  Color _getTextColor() {
    return currentDesign == 2 ? Colors.white : Colors.black87;
  }
}

class RotaryGaugePainter extends CustomPainter {
  final double rotation;
  final double maxRotation;
  final double screenHeight;
  final int designType;

  RotaryGaugePainter({
    required this.rotation,
    required this.maxRotation,
    required this.screenHeight,
    required this.designType,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, screenHeight * 0.32);
    final radius = size.width * 0.35;
    final numberOfBars = 36;
    final sweepAngle = 270.0;
    final startAngle = 135.0;

    final percentage = (rotation / maxRotation).clamp(0.0, 1.0);
    final activeBars = (numberOfBars * percentage).ceil();

    switch (designType) {
      case 1:
        _paintGradientDesign(
          canvas,
          center,
          radius,
          numberOfBars,
          sweepAngle,
          startAngle,
          activeBars,
          percentage,
        );
        break;
      case 2:
        _paintNeonDesign(
          canvas,
          center,
          radius,
          numberOfBars,
          sweepAngle,
          startAngle,
          activeBars,
          percentage,
        );
        break;
      case 3:
        _paintMinimalDesign(
          canvas,
          center,
          radius,
          numberOfBars,
          sweepAngle,
          startAngle,
          activeBars,
          percentage,
        );
        break;
    }
  }

  void _paintGradientDesign(
    Canvas canvas,
    Offset center,
    double radius,
    int numberOfBars,
    double sweepAngle,
    double startAngle,
    int activeBars,
    double percentage,
  ) {
    for (int i = 0; i < numberOfBars; i++) {
      final angle = startAngle + (sweepAngle / (numberOfBars - 1)) * i;
      final radians = angle * math.pi / 180;

      final x = center.dx + radius * math.cos(radians);
      final y = center.dy + radius * math.sin(radians);

      Color barColor;
      double barOpacity = 1.0;

      if (i < activeBars) {
        final progress = i / numberOfBars;
        if (progress < 0.33) {
          barColor =
              Color.lerp(Color(0xFFD5CBF0), Color(0xFF9BADD8), progress * 3)!;
        } else if (progress < 0.66) {
          barColor =
              Color.lerp(
                Color(0xFF9BADD8),
                Color(0xFF5A8FA8),
                (progress - 0.33) * 3,
              )!;
        } else {
          barColor =
              Color.lerp(
                Color(0xFF5A8FA8),
                Color(0xFF3D6B7D),
                (progress - 0.66) * 3,
              )!;
        }
      } else {
        barColor = Colors.white;
        barOpacity = 0.35;
      }

      final barWidth = 5.0 + (i / numberOfBars) * 4.0;
      final barPaint =
          Paint()
            ..color = barColor.withValues(alpha: barOpacity)
            ..strokeWidth = barWidth
            ..strokeCap = StrokeCap.round;

      final barLength = 28.0 + (i / numberOfBars) * 14.0;
      final outerX = center.dx + (radius + barLength) * math.cos(radians);
      final outerY = center.dy + (radius + barLength) * math.sin(radians);

      canvas.drawLine(Offset(x, y), Offset(outerX, outerY), barPaint);
    }
  }

  void _paintNeonDesign(
    Canvas canvas,
    Offset center,
    double radius,
    int numberOfBars,
    double sweepAngle,
    double startAngle,
    int activeBars,
    double percentage,
  ) {
    // Draw glow effect first
    for (int i = 0; i < activeBars; i++) {
      final angle = startAngle + (sweepAngle / (numberOfBars - 1)) * i;
      final radians = angle * math.pi / 180;

      final x = center.dx + radius * math.cos(radians);
      final y = center.dy + radius * math.sin(radians);

      final progress = i / numberOfBars;
      Color glowColor;
      if (progress < 0.5) {
        glowColor =
            Color.lerp(Color(0xFFFF006E), Color(0xFF8338EC), progress * 2)!;
      } else {
        glowColor =
            Color.lerp(
              Color(0xFF8338EC),
              Color(0xFF3A86FF),
              (progress - 0.5) * 2,
            )!;
      }

      final barWidth = 6.0 + (i / numberOfBars) * 5.0;
      final glowPaint =
          Paint()
            ..color = glowColor.withValues(alpha: 0.4)
            ..strokeWidth = barWidth + 8
            ..strokeCap = StrokeCap.round
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8);

      final barLength = 30.0 + (i / numberOfBars) * 16.0;
      final outerX = center.dx + (radius + barLength) * math.cos(radians);
      final outerY = center.dy + (radius + barLength) * math.sin(radians);

      canvas.drawLine(Offset(x, y), Offset(outerX, outerY), glowPaint);
    }

    // Draw main bars
    for (int i = 0; i < numberOfBars; i++) {
      final angle = startAngle + (sweepAngle / (numberOfBars - 1)) * i;
      final radians = angle * math.pi / 180;

      final x = center.dx + radius * math.cos(radians);
      final y = center.dy + radius * math.sin(radians);

      Color barColor;
      double barOpacity = 1.0;

      if (i < activeBars) {
        final progress = i / numberOfBars;
        if (progress < 0.5) {
          barColor =
              Color.lerp(Color(0xFFFF006E), Color(0xFF8338EC), progress * 2)!;
        } else {
          barColor =
              Color.lerp(
                Color(0xFF8338EC),
                Color(0xFF3A86FF),
                (progress - 0.5) * 2,
              )!;
        }
      } else {
        barColor = Colors.white;
        barOpacity = 0.15;
      }

      final barWidth = 6.0 + (i / numberOfBars) * 5.0;
      final barPaint =
          Paint()
            ..color = barColor.withValues(alpha: barOpacity)
            ..strokeWidth = barWidth
            ..strokeCap = StrokeCap.round;

      final barLength = 30.0 + (i / numberOfBars) * 16.0;
      final outerX = center.dx + (radius + barLength) * math.cos(radians);
      final outerY = center.dy + (radius + barLength) * math.sin(radians);

      canvas.drawLine(Offset(x, y), Offset(outerX, outerY), barPaint);
    }
  }

  void _paintMinimalDesign(
    Canvas canvas,
    Offset center,
    double radius,
    int numberOfBars,
    double sweepAngle,
    double startAngle,
    int activeBars,
    double percentage,
  ) {
    for (int i = 0; i < numberOfBars; i++) {
      final angle = startAngle + (sweepAngle / (numberOfBars - 1)) * i;
      final radians = angle * math.pi / 180;

      final x = center.dx + radius * math.cos(radians);
      final y = center.dy + radius * math.sin(radians);

      Color barColor;
      double barOpacity = 1.0;

      if (i < activeBars) {
        barColor = Color(0xFF2D3436);
      } else {
        barColor = Color(0xFFDFE6E9);
        barOpacity = 1.0;
      }

      final barWidth = 4.0 + (i / numberOfBars) * 3.0;
      final barPaint =
          Paint()
            ..color = barColor.withValues(alpha: barOpacity)
            ..strokeWidth = barWidth
            ..strokeCap = StrokeCap.round;

      final barLength = 26.0 + (i / numberOfBars) * 12.0;
      final outerX = center.dx + (radius + barLength) * math.cos(radians);
      final outerY = center.dy + (radius + barLength) * math.sin(radians);

      canvas.drawLine(Offset(x, y), Offset(outerX, outerY), barPaint);
    }
  }

  @override
  bool shouldRepaint(RotaryGaugePainter oldDelegate) {
    return oldDelegate.rotation != rotation ||
        oldDelegate.designType != designType;
  }
}
