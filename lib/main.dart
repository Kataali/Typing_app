import 'dart:math';
import 'package:flutter/material.dart';
// A package that gives us access to the circular countdown timer
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
// A package that gives us access to the top 5000 words in the English Language
import 'package:english_words/english_words.dart';
import 'package:scrum_app/levels.dart';

void main() => runApp(const MyApp());

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
      home: const Levels(),
      // home: const MyHomePage(title: 'How Fast can you Type?? 😈😈'),
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
  //Variables
  // Initial value of the word the user should type
  String currentWord = '         ';
  // Time user is given
  int time = 5;
  // A global variable to access our list of words,
  // which is provided by the english_words package.
  // Initialised to 0
  int i = 0;
  // Variable to keep track of score
  int score = 0;
  // Controller for the circular countdown timer
  final CountDownController _controller = CountDownController();
  // Visibility of start button. Not implemented
  bool startButtonActivate = true;
  // Variable control the node of the text form field
  late FocusNode textFieldFocus;
  @override
  void initState() {
    super.initState();
    textFieldFocus = FocusNode();
  }

  List<int> typedIndex = [];
  //int num = 0;
  // var timer;

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
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              height: 75,
              width: 105,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(29)),
              child: CircularCountDownTimer(
                duration: time,
                width: 30,
                height: 30,
                autoStart: false,
                controller: _controller,
                isReverse: true,
                fillColor: Colors.green,
                ringColor: Colors.red,
                onComplete: (){
                  // After the set time, ie. one minute, a dialog box pops up showing the user their WPM
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return (AlertDialog(
                          title: const Text(
                            "Time Up!!!",
                            style: TextStyle(color: Colors.red),
                          ),
                          content: Text(
                              "One minute has elapsed. Your word speed per minute is $score"),
                          icon: const Icon(Icons.access_time_filled_outlined),
                        ));
                      });
                  setState(() {
                    textFieldFocus.unfocus();
                    currentWord = '      ';
                  });
                },
              ),
            ),
            Container(
                height: 65,
                width: 105,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 187, 212, 187),
                    borderRadius: BorderRadius.circular(29)),
                child: Text(
                  textAlign: TextAlign.center,
                  "Score:\n$score",
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[


                //To show user the text to type
                Text(currentWord, style: const TextStyle(fontSize: 22)),
                Center(
                  child: Container(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    height: 2,
                    width: MediaQuery.of(context).size.width / 0.5,
                  ),
                ),

                //Separate where the text appears from the text form field
                const SizedBox(height: 40),


                Center(
                    child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 187, 212, 187),
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: Center(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: text,
                      onChanged: (value) {
                        difficultyLogic(value, text);
                      },
                      cursorColor: Colors.black,
                      focusNode: textFieldFocus,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.bolt),
                        hintText: "Type in the word",
                        hintStyle: TextStyle(fontFamily: 'OpenSans'),
                        //border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                )),

                //Separate Text form field from Button
                const SizedBox(height: 40,),

                //Start Button
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                        onPressed: startButtonActivate
                            ? () {
                          i = 0;
                          score = 0;
                          _controller.start();
                          currentWord = "start";
                          setState(() {
                            textFieldFocus.requestFocus();
                            // deactivate the start button after user taps on it
                            startButtonActivate = false;
                          });
                        }
                            : null,
                        child: const Text("Start"),
                      ),
                  ),
                ),
              ]),
        ),
      ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // Function for difficulty level of user
  void difficultyLogic(value, text){
    String typed = value;
    if (level == 1){
      //Check whether typed word is correct or not
      if (typed == currentWord.trim()) {
        setState(() {
          // Add the index to the indices of typed words
          typedIndex.add(i);
          // while the typed word is in our list of typed words or its length is greater than 4, use a different word
          while (typedIndex.contains(i) || all[i].length > 3) {
            i = Random().nextInt(all.length);
          }
          // When the loop breaks, set current word to the random word
          currentWord = all[i];
          // Clear the text form field for user to type in next word
          text.clear();
          // Increase score by one
          score++;
          // If the random number is the end of our list of words, set i to 0. ie. An empty string
          if (i == all.length) {
            i = 0;
          }
        });
      }
    }
    else if (level == 2){
      //Check whether typed word is correct or not
      if (typed == currentWord.trim()) {
        setState(() {
          // Add the index to the indices of typed words
          typedIndex.add(i);
          // while the typed word is in our list of typed words or its length is greater than 6, use a different word
          while (typedIndex.contains(i) || all[i].length > 6) {
            i = Random().nextInt(all.length);
          }
          // When the loop breaks, set current word to the random word
          currentWord = all[i];
          // Clear the text form field for user to type in next word
          text.clear();
          // Increase score by one
          score++;
          // If the random number is the end of our list of words, set i to 0. ie. An empty string
          if (i == all.length) {
            i = 0;
          }
        });
      }
    }
    else{
      //Check whether typed word is correct or not
      if (typed == currentWord.trim()) {
        setState(() {
          // Add the index to the indices of typed words
          typedIndex.add(i);
          // while the typed word is in our list of typed words or length of word is less than 7, use a different word
          while (typedIndex.contains(i) || all[i].length < 7) {
            i = Random().nextInt(all.length);
          }
          // When the loop breaks, set current word to the random word
          currentWord = all[i];
          // Clear the text form field for user to type in next word
          text.clear();
          // Increase score by one
          score++;
          // If the random number is the end of our list of words, set i to 0. ie. An empty string
          if (i == all.length) {
            i = 0;
          }
        });
      }
    }
  }
}
