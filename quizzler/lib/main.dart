import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzler/model/question.model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> scoreKeeper = [];
  List<Question> questions = [];
  List<bool> scores = [];
  int selectedQuestion = 0;
  int finalScore = 0;

  @override
  void initState() {
    this.setQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: this.selectedQuestion < this.questions.length
              ? quizPage()
              : endQuiz(),
        ),
      ),
    );
  }

  Widget endQuiz() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sua pontuação final foi ${this.finalScore}!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.green,
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                scoreKeeper = [];
                scores = [];
                selectedQuestion = 0;
                finalScore = 0;
              });
            },
            child: Card(
              color: Colors.blue,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'Reiniciar',
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(
                      Icons.restore_outlined,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget quizPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                this.questions[this.selectedQuestion].text,
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
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'Verdadeiro',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                addScore(this.questions[this.selectedQuestion].answer);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'Falso',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                addScore(!this.questions[this.selectedQuestion].answer);
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: scoreKeeper,
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }

  void addScore(bool value) {
    if (value) {
      this.finalScore++;
    }
    setState(() {
      this.selectedQuestion++;
      this.scoreKeeper.add(
            Expanded(
              child: Icon(
                value ? Icons.check : Icons.close,
                color: value ? Colors.green : Colors.red,
              ),
            ),
          );
    });
  }

  void setQuestions() {
    this.questions.add(Question('O sol é uma estrela?', true));
    this.questions.add(Question('A terra é plana?', false));
    this.questions.add(Question('Vacinas causam autismo?', false));
    this.questions.add(Question('O bolsonaro é miliciano?', true));
    this
        .questions
        .add(Question('Haddad ou Bolsonaro é uma escolha difícil?', false));
    this.questions.add(Question('Bolsonaro mentiu hoje?', true));
    this.questions.add(Question('Imposto é roubo?', false));
    this.questions.add(Question('Liberalismo presta?', false));
    this.questions.add(Question('Covid é só uma gripezinha?', false));
    this.questions.add(Question('Você acordou triste hoje?', true));
    this.questions.add(Question('Carlos Bolsonaro tem probleminhas?', true));
    this.questions.add(Question('Bolsonaro curte golden shower?', true));
    this.questions.add(Question(
        'Papai te deu mansão de 6 milhões com dinheiro público?', true));
  }
}
