import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ClockDesign extends StatefulWidget {
  final double size;
  const ClockDesign({Key? key, required this.size}) : super(key: key);
  @override
  _ClockDesignState createState() => _ClockDesignState();
}

class _ClockDesignState extends State<ClockDesign> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: widget.size,
        height: widget.size,

        //We Are Going To Use Transform Widget, Which Help To Rotate Our Clock In Anti-Clock Wise (90 Degree).
        // (That's Why We Use angle:-pi/2)
        child: Transform.rotate(
          angle: -pi / 2,
          //Its Important Part Of This App.
          // We Are Going To Use CustomPaint Widget For Our Clock.
          child: CustomPaint(
            painter: ClockPainter(),
          ),
        ),
      ),
    );
  }
}

//We Going To Make Custom Class For "ClockPainter"
// Which Is Extend From CustomPainter.
class ClockPainter extends CustomPainter {
  //This Variable Use For Which Gives Us A Actual Time.
  var dateTime = DateTime.now();

  // 60 sec / 360, It Takes 1 sec-6 Degree.

  //For Hour 12 Hours/360 , It Takes 1 Hours -30 degrees, For 1 min - 0.5 degrees.

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);

    // We Are Using Min,Which Gives Us Size.width/2 & Size.height/2.
    // Give Minimum Of Radius.
    var radius = min(centerX, centerY);

    //This Variable Use For Fill The Color In The Clock.
    var fillBrush = Paint()..color = Color(0xff8675A9);

    //This Variable Use For Outline(Border) Of The Clock.
    var outlineBrush = Paint()
      ..color = Color(0xffECB390)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 30;

    //This Variable Use For Center(Dot)Brush Of The Clock.
    var centerDotBrush = Paint()..color = Color(0xffECB390);

    //This Variable Use For Second Needle Brush Size Of The Clock.
    var secHandBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 45;

    //This Variable Use For Minutes Needle Brush Size Of The Clock.
    var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Colors.lightBlue, Colors.pink])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 30;

    //This Variable Use For Hours Needle Brush Size Of The Clock.
    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Colors.lightBlue, Colors.pink])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 25;

    //This Circle Use For The Clock.
    canvas.drawCircle(center, radius * 0.75, fillBrush);
    canvas.drawCircle(center, radius * 0.75, outlineBrush);

    //This Variable Use For Hours Needle Brush Of The Clock.
    var hourHandX = centerX +
        radius *
            0.5 *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        radius *
            0.5 *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    //This Variable Use For Minutes Needle Brush Of The Clock.
    var minHandX = centerX + radius * 0.7 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + radius * 0.7 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    //This Variable Use For Second Needle Brush Of The Clock.
    var secHandX = centerX + radius * 0.6 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + radius * 0.6 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, radius * 0.12, centerDotBrush);

    //This Variable Use For Inside Dash Or Number Of The Clock.
    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.2;

    var outerCircleRadius = radius;
    var innerCircleRadius = radius * 0.9;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
