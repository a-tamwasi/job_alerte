import 'package:flutter/material.dart';
import 'src/constants/couleurs_application.dart';

void main() => runApp(const MonApp());

/// Application principale
class MonApp extends StatelessWidget {
  const MonApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Projet',
      theme: ThemeData(primarySwatch: CouleursApplication.primaire),
      home: const Accueil(),
    );
  }
}

/// Page d'accueil vierge
class Accueil extends StatelessWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Bienvenue')));
  }
}
