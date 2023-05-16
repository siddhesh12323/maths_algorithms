import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:numerical_methods_mathematics/screens/regula_falsi_info.dart';

class RegulaFalsi extends StatefulWidget {
  const RegulaFalsi({super.key});

  @override
  State<RegulaFalsi> createState() => _RegulaFalsiState();
}

class _RegulaFalsiState extends State<RegulaFalsi> {
  final _textController = TextEditingController();
  final _errorController = TextEditingController();
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  String output = 'Result will appear here';
  String iterations = 'No. of iterations will appear here';
  String timeTaken = "Algorithm's will appear here";

  List<double> bisection(String func, double a, double b,
      {int maxIterations = 1000, double tolerance = 1e-12}) {
    //final stopwatch = Stopwatch()..start();
    Parser p1 = Parser();
    Expression exp = p1.parse(func);
    ContextModel cm1 = ContextModel();
    ContextModel cm2 = ContextModel();
    ContextModel cm3 = ContextModel();
    ContextModel cm4 = ContextModel();
    cm3.bindVariableName('x', Number(a));
    cm4.bindVariableName('x', Number(b));
    double c = 0;
    int iter = 0;
    if (exp.evaluate(EvaluationType.REAL, cm3) *
            exp.evaluate(EvaluationType.REAL, cm4) <
        0) {
      while ((b - a).abs() > tolerance) {
        c = ((a * exp.evaluate(EvaluationType.REAL, cm4)) - (b * exp.evaluate(EvaluationType.REAL, cm3)))/(exp.evaluate(EvaluationType.REAL, cm4) - exp.evaluate(EvaluationType.REAL, cm3));
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
      //stopwatch.stop();
      return [c, iter.toDouble()];
    } else {
      //stopwatch.stop();
      return [-1, 0];
    }
  }

  List<double> ans = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Regula Falsi Method'),
        actions: [
          IconButton(
              onPressed: () {
                //Navigator.pushNamed(context, '/regula_falsi_info');
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: ((context, animation, secondaryAnimation) =>
                        const RegulaFalsiInfo()),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0, 1);
                      const end = Offset.zero;
                      var curve = Curves.easeIn;
                      var curveTween = CurveTween(curve: curve);
                      final tween =
                          Tween(begin: begin, end: end).chain(curveTween);
                      final offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    }));
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
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Enter a',
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
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                
                  hintText: 'Enter b',
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
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Enter the error factor',
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
                    ans = bisection(
                        _textController.text,
                        double.parse(_aController.text),
                        double.parse(_bController.text),
                        tolerance: double.parse(_errorController.text));
                    output = 'Result:- ${ans[0].toString()}';
                    iterations = 'Iterations:- ${ans[1].toInt().toString()}';
                    //timeTaken = 'Execution Time:- ${ans[2].toString()}';
                  } catch (e) {
                    output = "Please enter double values only";
                  }
                });
              },
              child: const Text('Solve the equation')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Center(
                  child: SelectableText(
                output,
                style: Theme.of(context).textTheme.headlineSmall,
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Center(
                  child: Text(
                iterations,
                style: Theme.of(context).textTheme.headlineSmall,
              )),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     child: Center(
          //         child: Text(
          //       timeTaken,
          //       style: Theme.of(context).textTheme.headlineSmall,
          //     )),
          //   ),
          // )
        ],
      ),
      //),
    );
  }
}
