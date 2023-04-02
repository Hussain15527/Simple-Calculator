import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  // Color appbarColor=Color(0x18122B);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calcultor',
      // theme: ThemeData(primarySwatch: app),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  buttonPressed(String buttontext) {
    setState(() {
      if (buttontext == "c") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = "0";
        result = "0";
      } else if (buttontext == "⊲") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") equation = "0";
      } else if (buttontext == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        expression.replaceAll('×', '*');
        expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          result = eval.toString();
        } catch (e) {
          result = "error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0")
          equation = buttontext;
        else
          equation = equation + buttontext;
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        padding: EdgeInsets.all(16),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff393053),
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Color(0xff18122B),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("c", 1, Colors.red),
                        buildButton("⊲", 1, Color(0xff18122B)),
                        buildButton("/", 1, Color(0xff18122B))
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.black54),
                        buildButton("8", 1, Colors.black54),
                        buildButton("9", 1, Colors.black54)
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.black54),
                        buildButton("5", 1, Colors.black54),
                        buildButton("6", 1, Colors.black54)
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.black54),
                        buildButton("2", 1, Colors.black54),
                        buildButton("3", 1, Colors.black54)
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(".", 1, Colors.black54),
                        buildButton("0", 1, Colors.black54),
                        buildButton("00", 1, Colors.black54)
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("*", 1, Color(0xff18122B)),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Color(0xff18122B)),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Color(0xff18122B)),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Color(0xff18122B)),
                    ]),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
