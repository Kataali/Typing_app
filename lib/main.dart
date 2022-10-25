import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'How Fast can you Type?? 😈😈'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String currentWord = '';
  List<String> names = [
    "dan",
    "babs",
    "toufiq",
    "barry",
    "allen",
    "batman",
    "superman",
    "justice",
    "league",
    'lex',
    "luthor",
    "timer",
    "high",
    "score",
    "how",
    "fast",
    "can",
    "you",
    "type",
    "queen",
    "king",
    "english",
    "math",
    "science",
    "technical",
    "skills",
    "redundant",
    "words",
    "probable",
    "parole",
    "impossible"
  ];
  int i = 0;
  int wordCount = 0;
  int score = 0;
  // var timer;
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController text = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 100),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            // Container(
            //     height: 65,
            //     width: 105,
            //     color: Color.fromARGB(255, 187, 212, 187),
            //     child: Text(
            //       textAlign: TextAlign.center,
            //       "Timer:${timer}",
            //       style: TextStyle(fontSize: 20, color: Colors.black),
            //     )),
            Container(
                height: 65,
                width: 105,
                //color: Color.fromARGB(255, 187, 212, 187),
                child: Text(
                  textAlign: TextAlign.center,
                  "Score:\n${score}",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 187, 212, 187),
                    borderRadius: BorderRadius.circular(29))
                //BoxDecoration(borderRadius: BorderRadius.circular(29)),
                )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        timeElapsed();
                        i = 0;
                        score = 0;
                        currentWord = "start";
                        setState(() {
                          //TextFormField(focusNode: ,)
                        });
                      },
                      child: Text("Start"))
                ],
              ),
              Text(currentWord, style: TextStyle(fontSize: 22)),
              Container(
                color: Color.fromARGB(255, 0, 0, 0),
                height: 2,
                width: MediaQuery.of(context).size.width / 0.8,
              ),
              Center(
                  child: Container(
                margin: EdgeInsets.symmetric(vertical: 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 187, 212, 187),
                  borderRadius: BorderRadius.circular(29),
                ),
                child: Center(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: text,
                    onChanged: (value) {
                      String typed = value;
                      if (typed == currentWord.trim()) {
                        setState(() {
                          currentWord = names[i];
                          text.clear();
                          i++;
                          score = i;
                          if (i == names.length) {
                            i = 0;
                          }
                        });
                      }
                    },
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      hintText: "Tap to type in the word",
                      hintStyle: TextStyle(fontFamily: 'OpenSans'),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void timeElapsed() {
    Timer(Duration(seconds: 60), () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return (AlertDialog(
              title: Text(
                "Time Up!!!",
                style: TextStyle(color: Colors.red),
              ),
              content: Text(
                  "One minute has elapsed. Your word speed per minute is ${score}"),
            ));
          });
    });
    ;
  }
}
