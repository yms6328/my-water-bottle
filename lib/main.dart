import 'package:flutter/material.dart';
import 'package:widget_mask/widget_mask.dart';

void main() {
  runApp(const MyWaterBottle());
}

class MyWaterBottle extends StatelessWidget {
  const MyWaterBottle({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Water Bottle',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: const MainPage(title: 'My Water Bottle'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final double appbarHeight = 60.0;
  final GlobalKey _widgetKey = GlobalKey();
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _getWidgetInfo(_) {
    final RenderBox renderBox = _widgetKey.currentContext?.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appbarHeight),
        child: AppBar(
          title: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/logo.png',
                fit: BoxFit.contain,
                height: 40,
              ),
            ],
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text('Today: ', style: TextStyle(fontFamily: 'Jalnan')),
              SizedBox(height: 30),
              WidgetMask(
                key: _widgetKey,
                blendMode: BlendMode.srcATop,
                childSaveLayer: true,
                mask: CustomPaint(
                  painter: OpenPainter(),
                ),
                child: Center(
                  child: Image.asset(
                    'images/bottle.png',
                    fit: BoxFit.contain,
                    height: 550,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.settings),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff995588)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(100, 100) & const Size(200, 150), paint1);
  }
 
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}