import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Bisection extends StatefulWidget {
  const Bisection({super.key});

  @override
  State<Bisection> createState() => _BisectionState();
}

class _BisectionState extends State<Bisection> {
  final _textController = TextEditingController();
  final _errorController = TextEditingController();
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  String output = 'Result will appear here';
  String iterations = 'Number of iterations will appear here';

  // String calculate(String func, double a, double b, double errorFactor) {
  //   try {
  //     // Take input from the user
  //     //String input = '2 * x + 3';

  //     // Create a parser
  //     Parser p1 = Parser();

  //     // Parse the input string into a mathematical expression
  //     Expression exp = p1.parse(func);

  //     // Create a context containing the variable 'x'
  //     ContextModel cm1 = ContextModel();
  //     ContextModel cm2 = ContextModel();
  //     cm1.bindVariableName('x', Number(a));
  //     cm2.bindVariableName('x', Number(b));

  //     // Evaluate the expression for x = 2
  //     double resultA = exp.evaluate(EvaluationType.REAL, cm1);
  //     double resultB = exp.evaluate(EvaluationType.REAL, cm2);

  //     // Print the result
  //     if ((resultA * resultB) < 0) {
  //       ContextModel cm3 = ContextModel();
  //       double c = (a + b) / 2;
  //       cm3.bindVariableName('x', Number(c));
  //       double resultC = exp.evaluate(EvaluationType.REAL, cm3);
  //       if (resultC == 0) {
  //         return c.toString();
  //       } else {
  //         if (resultC.sign == resultA.sign && (b - a).abs() > errorFactor) {
  //           a = c;
  //           calculate(func, c, b, errorFactor);
  //         } else if (resultC.sign == resultB.sign &&
  //             (b - a).abs() > errorFactor) {
  //           b = c;
  //           calculate(func, a, c, errorFactor);
  //         }
  //       }
  //       return c.toString();
  //     } else {
  //       return "Invalid a and b";
  //     }
  //   } catch (e) {
  //     return "Something went wrong :(";
  //   }
  // }

  List<double> bisection(String func, double a, double b,
      {int maxIterations = 1000, double tolerance = 1e-12}) {
    Parser p1 = Parser();
    Expression exp = p1.parse(func);
    ContextModel cm1 = ContextModel();
    ContextModel cm2 = ContextModel();
    double c = 0;
    int iter = 0;
    while ((b - a).abs() > tolerance) {
      c = (a + b) / 2;
      cm1.bindVariableName('x', Number(c));
      if (exp.evaluate(EvaluationType.REAL, cm1).abs() < tolerance) {
        return [c, iter.toDouble()];
      }
      cm2.bindVariableName('x', Number(a));
      if (exp.evaluate(EvaluationType.REAL, cm1) *
              exp.evaluate(EvaluationType.REAL, cm2) <
          0) {
        b = c;
      } else {
        a = c;
      }
      iter++;
    }
    return [c, iter.toDouble()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bisection Method'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/bisection_info');
              },
              icon: const Icon(Icons.info_rounded))
        ],
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Enter the equation',
                  //hintText: 'e.g. John Doe',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: () {
                        _textController.clear();
                      },
                      icon: const Icon(Icons.clear))),
              controller: _textController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Enter a',
                  //hintText: 'e.g. John Doe',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: () {
                        _aController.clear();
                      },
                      icon: const Icon(Icons.clear))),
              controller: _aController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Enter b',
                  //hintText: 'e.g. John Doe',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: () {
                        _bController.clear();
                      },
                      icon: const Icon(Icons.clear))),
              controller: _bController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Enter the error factor',
                  //hintText: 'e.g. John Doe',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: () {
                        _errorController.clear();
                      },
                      icon: const Icon(Icons.clear))),
              controller: _errorController,
            ),
          ),
          TextButton(
              style: Theme.of(context).textButtonTheme.style,
              onPressed: () {
                setState(() {
                  try {
                    // output = calculate(
                    //     _textController.text,
                    //     double.parse(_aController.text),
                    //     double.parse(_bController.text),
                    //     double.parse(_errorController.text));
                    List<double> ans = [];
                    ans = bisection(
                        _textController.text,
                        double.parse(_aController.text),
                        double.parse(_bController.text),
                        tolerance: double.parse(_errorController.text));
                    output = 'Result:- ${ans[0].toString()}';
                    iterations = 'Iterations:- ${ans[1].toInt().toString()}';
                    //0.000000000000001
                  } catch (e) {
                    output = "Please enter double values only";
                  }
                });
              },
              child: const Text('Solve the equation')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Center(child: Text(output)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Center(child: Text(iterations)),
            ),
          )
        ],
      ),
      //),
    );
  }
}
