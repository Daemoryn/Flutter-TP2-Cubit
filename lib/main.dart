import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/widgets/choix.dart';
import 'package:flutter_firebase/widgets/question.dart';
import 'package:flutter_firebase/widgets/score.dart';
import 'dart:ui' as ui;

import 'cubits/question_cubit.dart';
import 'models/emit_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MediaQuery(
      data: MediaQueryData.fromWindow(ui.window),
      child: Directionality(textDirection: TextDirection.rtl, child: Quiz())));
}

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await users.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(allData);
  }

  DocumentReference alovelaceDocumentRef =
      FirebaseFirestore.instance.collection("users").doc("alovelace");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Center(child: Text("Error"));
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
        return const Center(child: Text("Loading"));
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
                  // Text(
                  //   FirebaseFirestore.instance
                  //       .collection("users")
                  //       .doc("alovelace").get().toString(),
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: MediaQuery.of(context).size.width * 0.10,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
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
                        primary: Colors.green.withOpacity(0.8),
                        function: () {
                          bloc.checkAnswer(true, context);
                        }),
                    Choix(
                        text: 'Faux',
                        primary: Colors.red.withOpacity(0.8),
                        function: () {
                          bloc.checkAnswer(false, context);
                        }),
                    Choix(
                        text: 'Passer',
                        primary: Colors.black,
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
