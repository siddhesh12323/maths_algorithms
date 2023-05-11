import 'package:flutter/material.dart';

class BisectionInfo extends StatelessWidget {
  const BisectionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 34,
                )),
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 30, 0, 0),
                child: Text(
                  'About Bisection Method',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    //* App theme
                    ListTile(
                      title: const Text('Number 1'),
                      style: Theme.of(context).listTileTheme.style,
                    ),
                    //* App Font
                    ListTile(
                      title: const Text('App Font'),
                      style: Theme.of(context).listTileTheme.style,
                    ),
                    
                  ],
                ),
              )
            ]));
  }
}