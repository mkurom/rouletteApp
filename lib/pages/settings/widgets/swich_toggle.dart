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
  var _alignment = Alignment.center;
  var _isLeft = true;
  var _color = Colors.red;

  final double range = 150;
  final double height = 50;
  late double _switchPosition;
  late double pos = 50;
  final double circleSize = 40;
  var _text = '内側';

  final controller = TextEditingController();

  @override
  void initState() {
    _switchPosition = -pos;
    super.initState();
  }

  void onTapToggle() {
    setState(() {
      _isLeft = !_isLeft;
      _color = _isLeft ? Colors.red : Colors.blue;
      _switchPosition = _isLeft ? -pos : pos;
      _text = _isLeft ? '内側' : '外側';
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          InkWell(
            onTap: onTapToggle,
            customBorder: CircleBorder(),
            child: Stack(
              alignment: _alignment,
              children: [
                Container(
                  width: range,
                  height: height,
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
                  transform: Matrix4.translationValues(_switchPosition, 0, 0),
                  alignment: Alignment.center,
                  child: Container(
                    width: circleSize,
                    height: circleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _color,
                    ),
                  ),
                  duration: Duration(
                    milliseconds: 300,
                  ),
                  width: range,
                  height: height,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10,
            ),
            width: screenSize.width / 3,
            child: TextFormField(
              onTap: () {},
              controller: controller,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null) {
                  return '入力してください。';
                }
                return null;
              },
              decoration: const InputDecoration(),
            ),
          ),
        ],
      ),
    );
  }
}
