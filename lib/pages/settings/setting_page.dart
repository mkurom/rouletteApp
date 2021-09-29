import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:roulette/pages/settings/widgets/swich_toggle.dart';

class SettingPage extends StatefulWidget {
  SettingPage({
    Key? key,
  }) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
  }

  // state
  final key = GlobalKey();
  final List<SampleItem> _items = [];
  final ScrollController controller = ScrollController();

  // controller
  void addItem() {
    final item = SampleItem(color: setColor());

    setState(() {
      _items.add(item);
    });
  }

  void removeItem(SampleItem item) {
    _items.remove(item);
    setState(() {});
  }

  Color setColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1);
  }

  // ui
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '設定',
        ),
        actions: [
          IconButton(
            onPressed: addItem,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode currentScope = FocusScope.of(context);
          if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: Stack(
          children: [
            if (_items.isNotEmpty)
              ListView.builder(
                key: key,
                controller: controller,
                padding: const EdgeInsets.only(
                  bottom: 100,
                ),
                itemCount: _items.length,
                itemBuilder: (BuildContext context, int index) {
                  return SwitchToggle(
                    index: index,
                    item: _items[index],
                    onTap: () {
                      removeItem(_items[index]);
                    },
                  );

                  // return Slidable(
                  //   actionPane: SlidableScrollActionPane(),
                  //   secondaryActions: [
                  //     IconSlideAction(
                  //       caption: '削除',
                  //       color: Colors.red,
                  //       icon: Icons.delete,
                  //       onTap: () {
                  //         removeItem(_items[index]);
                  //       },
                  //     ),
                  //   ],
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(10),
                  //     child: Row(
                  //       children: [
                  //         Text(_items[index].color.toString()),
                  //       ],
                  //     ),
                  //   ),
                  // );
                },
              ),
            buttons(),
          ],
        ),
      ),
    );
  }

  Widget buttons() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 140,
              child: ElevatedButton(
                onPressed: () {
                  for (var i = 0; i < _items.length; i++) {
                    print(_items[i].title);
                  }
                },
                child: const Text('テンプレート'),
              ),
            ),
            SizedBox(
              width: 140,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('保存'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SampleItem {
  SampleItem({
    this.title = 'item',
    this.type = 0,
    required this.color,
  });

  String title;
  // 0: 内側　1:外側
  int type;
  Color color;

  void chaneTitle(String title) {
    this.title = title;
  }

  void chaneType(int type) {
    this.type = type;
  }

  void chaneColor(Color color) {
    this.color = color;
  }
}
