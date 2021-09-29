import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:roulette/pages/settings/setting_page.dart';

class SwitchToggle extends StatefulWidget {
  const SwitchToggle({
    Key? key,
    required this.index,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  final int index;
  final SampleItem item;
  final VoidCallback onTap;

  @override
  _SwitchToggleState createState() => _SwitchToggleState();
}

class _SwitchToggleState extends State<SwitchToggle>
    with SingleTickerProviderStateMixin {
  var _alignment = Alignment.center;
  var _isInner = true;
  var _color = Colors.red;

  final double range = 150;
  final double height = 50;
  late double _switchPosition;
  late double pos = 50;
  final double circleSize = 40;
  var _text = '内側';

  late TextEditingController controller;

  void onTapToggle() {
    setState(() {
      _isInner = !_isInner;
      _color = _isInner ? Colors.red : Colors.blue;
      _switchPosition = _isInner ? -pos : pos;
      _text = _isInner ? '内側' : '外側';
    });
    final type = _isInner ? 0 : 1;
    widget.item.chaneType(type);
  }

  void init() {
    _isInner = (widget.item.type == 0) ? true : false;
    _switchPosition = (widget.item.type == 0) ? -pos : pos;
    _color = (widget.item.type == 0) ? Colors.red : Colors.blue;
    _switchPosition = (widget.item.type == 0) ? -pos : pos;
    _text = (widget.item.type == 0) ? '内側' : '外側';

    controller = TextEditingController(text: widget.item.title);
  }

  @override
  Widget build(BuildContext context) {
    init();
    final screenSize = MediaQuery.of(context).size;

    return Slidable(
      actionPane: SlidableScrollActionPane(),
      secondaryActions: [
        deleteButton(),
      ],
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            toggle(),
            itemField(screenSize),
            Spacer(),
            colorPicker(),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget toggle() {
    return InkWell(
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
    );
  }

  Widget itemField(Size screenSize) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
      ),
      width: screenSize.width / 3,
      height: height,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value == null) {
            return '入力してください。';
          }
          return null;
        },
        onChanged: (String value) {
          widget.item.chaneTitle(value);
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(color: Colors.black, width: 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget deleteButton() {
    return IconSlideAction(
      caption: '削除',
      color: Colors.red,
      icon: Icons.delete,
      onTap: () {
        widget.onTap();
      },
    );
  }

  Widget colorPicker() {
    return InkWell(
      onTap: () {
        //
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        width: circleSize,
        height: circleSize,
        decoration: BoxDecoration(
          border: Border.all(),
          color: widget.item.color,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
