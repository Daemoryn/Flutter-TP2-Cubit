import 'package:flutter_firebase/models/emit_data.dart';
import 'package:flutter_firebase/widgets/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionCubit extends Cubit<EmitData<Question, int, int, int, int>> {
  var _score = 0;
  var _scorePrecedent = 0;
  var _tentatives = 0;
  var _index = 0;
  final List<Question> _questions = [
    Question(
        url: 'images/zidane.jpg',
        text: 'La France a gagner la coupe du Monde 98.',
        isCorrect: true),
    Question(
        url: 'images/miel.jpg',
        text: 'Seul un aliment ne se déteriore jamais : le miel.',
        isCorrect: true),
    Question(
        url: 'images/langue.jpg',
        text: 'Le muscle le plus puissant du corps est la langue.',
        isCorrect: false)
  ];

  QuestionCubit()
      : super(EmitData(
            Question(text: '', url: 'path', isCorrect: false), 0, 0, 0, 0)) {
    _sendQuestion();
  }

  void checkAnswer(bool userChoice, BuildContext context) {
    String text;
    bool flag;

    if (questions[index].isCorrect == userChoice) {
      text = 'Vous avez répondu juste !';
      flag = true;
    } else {
      text = 'Ce n\'est pas la bonne réponse :/';
      flag = false;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Center(child: Text(text, style: const TextStyle(fontSize: 20))),
        duration: const Duration(milliseconds: 1000)));

    nextQuestion(flag, context);
  }

  void nextQuestion(bool flag, BuildContext context) {
    if (flag) {
      _score++;
    }
    if (index < questions.length - 1) {
      _index++;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Center(
              child: Text(
                  "C'est la fin du Quiz, vous avez un score de : $score !",
                  style: const TextStyle(fontSize: 20))),
          duration: const Duration(milliseconds: 1000)));

      retry();
    }
    _sendQuestion();
  }

  void retry() {
    _index = 0;
    _scorePrecedent = _score;
    _score = 0;
    _tentatives++;
  }

  void _sendQuestion() {
    emit(EmitData(_questions[_index], _score, _index, _tentatives, _scorePrecedent));
  }

  get score => _score;

  get scorePrecedent => _scorePrecedent;

  get tentatives => _tentatives;

  get index => _index;

  List<Question> get questions => _questions;

  set score(value) {
    _score = value;
  }

  set scorePrecedent(value) {
    _scorePrecedent = value;
  }

  set tentatives(value) {
    _tentatives = value;
  }

  set index(value) {
    _index = value;
  }
}
