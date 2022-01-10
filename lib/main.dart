import 'package:flutter/material.dart';
import 'package:my_water_bottle/wave_widget.dart';
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
  double _rate = 0.9;

  void _incrementCounter() {
    setState(() {
      _rate = _rate - 0.1;
    });
  }

  void _decrementCounter() {
    setState(() {
      _rate = _rate + 0.1;
    });
  }

  void _getWidgetInfo() {
    final RenderBox renderBox = _widgetKey.currentContext?.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    print("offset: $offset");
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
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            WidgetMask(
              blendMode: BlendMode.srcATop,
              mask: WaveWidget(rate: _rate),
              childSaveLayer: true,
              child: Center(
                child: Image.asset(
                  'images/bottle.png',
                  fit: BoxFit.contain,
                  height: 550,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: _decrementCounter,
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
