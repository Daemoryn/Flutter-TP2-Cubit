import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/widgets/choix.dart';
import 'package:flutter_firebase/widgets/question.dart';
import 'package:flutter_firebase/widgets/score.dart';

import 'cubits/question_cubit.dart';
import 'models/emit_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Quiz());
}

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  // FirebaseFirestore db = FirebaseFirestore.instance;
  // CollectionReference users = FirebaseFirestore.instance.collection('users');

  // DocumentReference alovelaceDocumentRef =
  //     db.collection("users").doc("alovelace");

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Text("Error");
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Questions/Réponses',
            debugShowCheckedModeBanner: false,
            home: BlocProvider(
              create: (_) => QuestionCubit(),
              child: QuizPage(),
            ),
          );
        }
        return const Text("Loading");
      },
    );
  }
}

class QuizPage extends StatelessWidget {
  QuizPage({Key? key}) : super(key: key);

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
                  // Text(alovelaceDocumentRef.toString()),
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

/*

return MaterialApp(
      title: 'Questions/Réponses',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => QuestionCubit(),
        child: FutureBuilder(
          // Initialize Firebase:
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return Container();
            }
            // Once complete, show your application
            // if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                  title: const Text('Questions/Réponses'), centerTitle: true),
              backgroundColor: Colors.black87,
              body: BlocBuilder<QuestionCubit,
                  EmitData<Question, int, int, int, int>>(
                builder: (context, pair) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Wrap(
                        children: [
                          // Text(alovelaceDocumentRef.toString()),
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
          },
        ),
      ),
    );
 */
