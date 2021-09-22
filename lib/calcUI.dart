import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CalcUI extends StatefulWidget {
  @override
  _CalcUIState createState() => _CalcUIState();
}

class _CalcUIState extends State<CalcUI> {
  List<bool> mode = [false, true];
  bool enableDark = false;
  String val = '';
  String ans = '0';
  List button = [
    'AC',
    'DEL',
    '(',
    ')',

    '7',
    '8',
    '9',
    '÷',

    '4',
    '5',
    '6',
    '×',

    '1',
    '2',
    '3',
    '-',

    '0',

    '.',

    '=', //(-)
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    TextStyle textColor(Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed))
        return TextStyle(fontSize: 18);
      else
        return TextStyle(fontSize: 18);
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: enableDark
            ? Theme.of(context).accentColor
            : Theme.of(context).primaryColor,
        body: Column(
          children: [
            Container(
              width: w,
              height: h * 0.3,
              color: enableDark
                  ? Theme.of(context).accentColor
                  : Theme.of(context).primaryColor,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 5,
                      top: 10,
                      right: 5,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ToggleSwitch(
                                iconSize: 22,
                                initialLabelIndex: 0,
                                activeFgColor: enableDark
                                    ? Color(0xff6b6f77)
                                    : Theme.of(context).accentColor,
                                inactiveFgColor: enableDark
                                    ? Colors.white
//
                                    : Color(0xffdddddd),
                                inactiveBgColor: enableDark
                                    ? Color(0xff2A2D37)
                                    : Color(0xffF4F1F2),
                                activeBgColors: [
                                  [
                                    enableDark
                                        ? Color(0xff2A2D37)
                                        : Color(0xffF4F1F2),
                                  ],
                                  [
                                    enableDark
                                        ? Color(0xffF4F1F2)
                                        : Color(0xff2A2D37),
                                  ]
                                ],
                                minHeight: 30,
                                minWidth: 40,
                                totalSwitches: 2,
                                onToggle: (index) {
                                  setState(() {
                                    if (index == 0)
                                      enableDark = false;
                                    else
                                      enableDark = true;
                                  });
                                },
                                icons: [
                                  CupertinoIcons.sun_max,
                                  CupertinoIcons.moon,
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Text(
                            ' $val',
                            style: TextStyle(
                              color: enableDark
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).accentColor,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            '$ans',
                            style: TextStyle(
                              color: enableDark
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).accentColor,
                              fontSize: 30,
                            ),
                          ),
//                  SizedBox()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: enableDark ? Color(0xff2A2D37) : Color(0xffF4F1F2),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.all(8),
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 12,
                  children: [
                    for (String icon in button)
                      OutlinedButton(
                        onPressed: () {
                          valUpdate(icon);
                        },
                        style: ButtonStyle(
                          textStyle:
                              MaterialStateProperty.resolveWith<TextStyle>(
                                  textColor),
                          side: MaterialStateProperty.all(
                            BorderSide(
                              color: (icon == 'AC' || icon == 'DEL')
                                  ? Colors.redAccent
                                  : (icon == '+' ||
                                          icon == '-' ||
                                          icon == '×' ||
                                          icon == '÷' ||
                                          icon == '=')
                                      ? Colors.greenAccent
                                      : (icon == '(' || icon == ')')
                                          ? Colors.lightBlueAccent
                                          : enableDark
                                              ? Theme.of(context).primaryColor
                                              : Theme.of(context).accentColor,
                              width: 1,
                            ),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80),
                            ),
                          ),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return (icon == 'AC' || icon == 'DEL')
                                  ? Colors.redAccent
                                  : (icon == '+' ||
                                          icon == '-' ||
                                          icon == '×' ||
                                          icon == '÷' ||
                                          icon == '=')
                                      ? Colors.greenAccent
                                      : (icon == '(' || icon == ')')
                                          ? Colors.lightBlueAccent
                                          : enableDark
                                              ? Theme.of(context).primaryColor
                                              : Theme.of(context).accentColor;
                            } else
                              return Colors.yellowAccent;
                          }),
                          foregroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return enableDark
                                  ? Theme.of(context).accentColor
                                  : Theme.of(context).primaryColor;
                            else
                              return (icon == 'AC' || icon == 'DEL')
                                  ? Colors.redAccent
                                  : (icon == '+' ||
                                          icon == '-' ||
                                          icon == '×' ||
                                          icon == '÷' ||
                                          icon == '=')
                                      ? Colors.greenAccent.shade400
                                      : (icon == '(' || icon == ')')
                                          ? Colors.lightBlueAccent
                                          : enableDark
                                              ? Theme.of(context).primaryColor
                                              : Theme.of(context).accentColor;
                          }),
                        ),
                        child: Center(
                          child: Text(
                            icon,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void valUpdate(String s) {
    if (s == '0') val = val + s;
    if (s == '1') val = val + s;
    if (s == '2') val = val + s;
    if (s == '3') val = val + s;
    if (s == '4') val = val + s;
    if (s == '5') val = val + s;
    if (s == '6') val = val + s;
    if (s == '7') val = val + s;
    if (s == '8') val = val + s;
    if (s == '9') val = val + s;
    if (s == '+') val = val + s;
    if (s == '-') val = val + s;
    if (s == '×') val = val + '*';
    if (s == '÷') val = val + '/';
    if (s == '.') val = val + '.';
    if (s == 'AC') {
      val = '';
      ans = '0';
    }
    if (s == 'DEL') val = val.substring(0, val.length - 1);
    if (s == '(') val = val + '(';
    if (s == ')') val = val + ')';
    if (s == '=') ans = calc(val);
    setState(() {});
  }

  String calc(String v) {
    String modVal = v;
    Parser p = Parser();
    Expression e = p.parse(modVal);
    ContextModel cm = ContextModel();
    num eval = e.evaluate(EvaluationType.REAL, cm);
    String a = eval.toString();
    return a.length > 20 ? eval.toStringAsPrecision(16) : a;
  }
}
