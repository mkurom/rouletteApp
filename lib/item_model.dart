import 'package:charts_flutter/flutter.dart' as charts;

class Item {
  Item({
    required this.title,
    required this.ratio,
    required this.color,
  });

  final String title;
  final int ratio;
  final charts.Color color;
}
