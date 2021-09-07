import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math' as math;
import 'package:roulette/item_model.dart';
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
  final List<charts.Series<Item, String>> _series = [];

  bool animate = false;
  double angle = 0;

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
      ),
      body: Container(
        child: Column(
          children: [
            RotationTransition(
              turns: Tween(begin: 0.0, end: 10.0).animate(controller),
              child: Transform.rotate(
                angle: angle,
                child: Container(
                  width: 500,
                  height: 500,
                  child: Center(
                    child: charts.PieChart(
                      _series,
                      animate: animate,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: Text("go"),
                  onPressed: () => controller.repeat(),
                ),
                ElevatedButton(
                  child: Text("stop"),
                  onPressed: () {
                    controller.reset();
                    setState(() {
                      angle = math.Random().nextInt(10).toDouble();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _rouletteData() {
    _series.addAll(
      [
        charts.Series<Item, String>(
          id: 'BudgetChart',
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
            )
          ],
        ),
      ],
    );
  }
}
