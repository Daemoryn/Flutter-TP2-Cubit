import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/widgets/choix.dart';
import 'package:quiz/widgets/question.dart';
import 'package:quiz/widgets/score.dart';
import 'cubits/question_cubit.dart';
import 'models/emit_data.dart';

void main() => runApp(Quiz());

class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Questions/Réponses',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => QuestionCubit(),
        child: QuizPage(),
      ),
    );
  }
}

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<QuestionCubit>(context);

    return Scaffold(
      appBar:
          AppBar(title: const Text('Questions/Réponses'), centerTitle: true),
      backgroundColor: Colors.black87,
      body: BlocBuilder<QuestionCubit, EmitData<Question, int, int, int, int>>(
        builder: (context, pair) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Wrap(
                children: [
                  Score(
                      text: 'Tentatives : ',
                      textColor: Colors.yellow,
                      number: bloc.tentatives),
                  Score(
                      text: 'Score : ',
                      textColor: Colors.white,
                      number: bloc.score),
                  Score(
                      text: 'Ancien score : ',
                      textColor: Colors.white60,
                      number: bloc.scorePrecedent),
                ],
              ),
              pair.question,
              FadeInUp(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Choix(
                        text: 'Vrai',
                        primary: Colors.green,
                        function: () {
                          bloc.checkAnswer(true, context);
                        }),
                    Choix(
                        text: 'Faux',
                        primary: Colors.red,
                        function: () {
                          bloc.checkAnswer(false, context);
                        }),
                    Choix(
                        text: 'Passer',
                        primary: Colors.white24,
                        function: () {
                          bloc.nextQuestion(false, context);
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
