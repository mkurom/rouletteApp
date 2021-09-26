import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math' as math;
import 'package:roulette/model/item_model.dart';
import 'package:roulette/pages/settings/setting_page.dart';
import 'package:roulette/sample_data.dart';

class RoulettePage extends StatefulWidget {
  RoulettePage({
    Key? key,
  }) : super(key: key);

  @override
  _RoulettePageState createState() => _RoulettePageState();
}

class _RoulettePageState extends State<RoulettePage>
    with SingleTickerProviderStateMixin {
  final List<charts.Series<Item, String>> _outData = [];
  final List<charts.Series<Item, String>> _inData = [];

  bool animate = false;
  double outAngle = 0;
  double inAngle = 0;

  late AnimationController controller;

  @override
  void initState() {
    _rouletteData();

    controller = AnimationController(
      duration: Duration(
        seconds: 1,
      ),
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ルーレット',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<Widget>(
                  builder: (_) => SettingPage(),
                ),
              );
            },
            icon: Icon(Icons.navigate_next),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                RotationTransition(
                  turns: Tween(begin: 0.0, end: 5.0).animate(controller),
                  child: Transform.rotate(
                    angle: outAngle,
                    child: Container(
                      width: 500,
                      height: 500,
                      child: charts.PieChart(
                        _outData,
                        animate: animate,
                      ),
                    ),
                  ),
                ),
                RotationTransition(
                  turns: Tween(begin: 5.0, end: 0.0).animate(controller),
                  child: Transform.rotate(
                    angle: inAngle,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: charts.PieChart(
                        _inData,
                        animate: animate,
                        layoutConfig: charts.LayoutConfig(
                          topMarginSpec: charts.MarginSpec.fixedPixel(0),
                          rightMarginSpec: charts.MarginSpec.fixedPixel(0),
                          bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
                          leftMarginSpec: charts.MarginSpec.fixedPixel(0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            rouletteButton(),
          ],
        ),
      ),
    );
  }

  Widget rouletteButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          child: Text('start'),
          onPressed: () => controller.repeat(),
        ),
        ElevatedButton(
          child: Text('stop'),
          onPressed: () {
            controller.reset();
            setState(() {
              outAngle = math.Random().nextInt(10).toDouble();
              inAngle = math.Random().nextInt(10).toDouble();
            });
          },
        ),
      ],
    );
  }

  void _rouletteData() {
    _outData.addAll(
      [
        charts.Series<Item, String>(
          id: 'outter',
          domainFn: (Item item, _) => item.title,
          measureFn: (Item item, _) => item.ratio,
          colorFn: (Item item, _) => item.color,
          data: [
            Item(
              title: sampleItems[0].title,
              ratio: sampleItems[0].ratio,
              color: sampleItems[0].color,
            ),
            Item(
              title: sampleItems[1].title,
              ratio: sampleItems[1].ratio,
              color: sampleItems[1].color,
            ),
            Item(
              title: sampleItems[2].title,
              ratio: sampleItems[2].ratio,
              color: sampleItems[2].color,
            ),
          ],
        ),
      ],
    );

    _inData.addAll(
      [
        charts.Series<Item, String>(
          id: 'outter',
          domainFn: (Item item, _) => item.title,
          measureFn: (Item item, _) => item.ratio,
          colorFn: (Item item, _) => item.color,
          data: [
            Item(
              title: sampleItems[1].title,
              ratio: sampleItems[1].ratio,
              color: sampleItems[1].color,
            ),
            Item(
              title: sampleItems[2].title,
              ratio: sampleItems[2].ratio,
              color: sampleItems[2].color,
            ),
            Item(
              title: sampleItems[0].title,
              ratio: sampleItems[0].ratio,
              color: sampleItems[0].color,
            ),
          ],
        ),
      ],
    );
  }
}
