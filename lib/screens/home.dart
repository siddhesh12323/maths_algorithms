import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/about');
              },
              icon: const Icon(Icons.info_rounded))
        ],
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: Theme.of(context).textButtonTheme.style,
                    onPressed: () {
                      Navigator.pushNamed(context, '/bisection_method');
                    },
                    child: const Text('Bisection Method')),
                    
              ),
             Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: Theme.of(context).textButtonTheme.style,
                    onPressed: () {
                      Navigator.pushNamed(context, '/regula_falsi_method');
                    },
                    child: const Text('Regula Falsi Method')),
             ),
            ],
          ),
      ),
    );
  }
}
