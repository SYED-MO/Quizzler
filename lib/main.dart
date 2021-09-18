import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
//import 'dart:developer';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

Widget placeHolder = SizedBox(
  height: 35.0,
);

List<Widget> scoreCard = [placeHolder];

Quizbrain quiz = Quizbrain();

void checkAns({bool choice, BuildContext context}) {
  if (quiz.isFinished() == true) {
    _onBasicAlertPressed(context);
    quiz.reset();
    scoreCard.clear();
    scoreCard = [placeHolder];

  }
  else {
    if (quiz.getQuestion().answer == choice) {
      scoreCard.add(Icon(
        Icons.check,
        color: Colors.green,
      ));
    } else {
      scoreCard.add(Icon(
        Icons.clear,
        color: Colors.red,
      ));
    }
    quiz.nextQue();
  }
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quiz.getQuestion().question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              color: Colors.green,
              child: TextButton(
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    checkAns(choice: true, context: context);
                  });
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              color: Colors.red,
              child: TextButton(
                child: Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    checkAns(choice: false, context: context);
                  });

                  //The user picked false.
                },
              ),
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Row(
          children: scoreCard
        ),
        SizedBox(height: 3.0,)
      ],
    );
  }
}

_onBasicAlertPressed(context) {
  Alert(
    context: context,
    title: 'HURRAY!!!',
    desc: "You've completed the quiz.",
  ).show();
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/