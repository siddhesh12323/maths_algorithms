import 'package:flutter/material.dart';

class Bisection extends StatefulWidget {
  const Bisection({super.key});

  @override
  State<Bisection> createState() => _BisectionState();
}

class _BisectionState extends State<Bisection> {
  final _textController = TextEditingController();
  String input = 'Result will appear here';
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
      body:Column(
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
            TextButton(
                style: Theme.of(context).textButtonTheme.style,
                onPressed: () {
                  setState(() {
                    input = _textController.text;
                  });
                },
                child: const Text('Solve the equation')),
            Container(
              child: Center(child: Text(input)),
            )
          ],
        ),
      //),
    );
  }
}
