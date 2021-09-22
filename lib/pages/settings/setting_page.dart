import 'package:flutter/material.dart';
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

  final List<Widget> _items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '設定',
        ),
        actions: [
          IconButton(
            onPressed: () {
              final switchToggle = SwitchToggle();
              _items.add(switchToggle);
              setState(() {});
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Stack(
        children: [
          if (_items.isNotEmpty)
            Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ..._items,
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            bottom: 0,
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
                      onPressed: () {},
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
          ),
        ],
      ),
    );
  }
}
