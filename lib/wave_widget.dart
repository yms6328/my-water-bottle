import 'dart:math';
import 'package:flutter/material.dart';

class WaveWidget extends StatefulWidget {
  WaveWidget({required this.rate});
  double rate;

  @override
  _WaveWidgetState createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 7000));
    _animation = Tween<double>(begin: 0, end:2*pi).animate(_animationController);

    _animationController.addListener(() {
      setState(() {

      });
    });
    _animationController.repeat();
    super.initState();
  }

  final double waveHeight = 1000;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: waveHeight,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
                child: ClipPath(
                  clipper: WaveClipper(_animation.value, widget.rate),
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path>{
  WaveClipper(this.animationValue, this.rate);
  final double animationValue;
  final double rate;

  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double rate = this.rate;
    var p = Path();
    var points = <Offset>[];
    for(var x = 0; x < size.width; x++)
      points.add(Offset(x.toDouble(), WaveClipper.getYWithX(x, animationValue, rate)));

    p.moveTo(0, WaveClipper.getYWithX(0, animationValue, rate));
    p.addPolygon(points, false);
    p.lineTo(size.width, size.height);
    p.lineTo(0, size.height);
    return p;
  }

  static const double waveHeight = 30;
  static const double waveDouble = 0.02;
  static const double bottleSize = 850;

  static double getYWithX(int x, double animationValue, double rate){ // 0 ~ 2pi
    double topMargin = bottleSize * rate;
    var y = ((sin(animationValue + x * waveDouble) + 1 ) / 2) * waveHeight + topMargin;// 0 ~ 1
    return y - 193;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}
