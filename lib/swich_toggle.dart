import 'package:flutter/material.dart';

class SwitchToggle extends StatefulWidget {
  SwitchToggle({
    Key? key,
  }) : super(key: key);

  @override
  _SwitchToggleState createState() => _SwitchToggleState();
}

class _SwitchToggleState extends State<SwitchToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Alignment _alignment = Alignment.center;
  bool _isLeft = false;
  Color _color = Colors.red;
  double _position = -55;
  String _text = '内側';
  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(
        seconds: 1,
      ),
      vsync: this,
    );

    super.initState();
  }

  void onTapToggle() {
    _isLeft = !_isLeft;
    setState(() {
      _color = _isLeft ? Colors.red : Colors.blue;
      _position = _isLeft ? -55 : 55;
      _text = _isLeft ? '内側' : '外側';
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapToggle,
      customBorder: CircleBorder(),
      child: Stack(
        alignment: _alignment,
        children: [
          Container(
            width: 160,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(),
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(_text),
            ),
          ),
          AnimatedContainer(
            transform: Matrix4.translationValues(_position, 0, 0),
            alignment: Alignment.center,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _color,
              ),
            ),
            duration: Duration(
              milliseconds: 300,
            ),
            width: 160,
            height: 50,
          ),
        ],
      ),
    );
  }
}
