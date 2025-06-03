import 'package:flutter/material.dart';
import 'couleurs_application.dart';

/// Styles de texte utilisés dans l'application
class StylesTexteApplication {
  StylesTexteApplication._();

  /// Style pour les titres principaux
  static const TextStyle titrePrincipal = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: CouleursApplication.textePrincipal,
  );

  /// Style pour les sous-titres
  static const TextStyle sousTitre = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: CouleursApplication.textePrincipal,
  );

  /// Style pour le texte du corps
  static const TextStyle corpsTexte = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: CouleursApplication.textePrincipal,
  );

  /// Style pour le texte secondaire
  static const TextStyle texteSecondaire = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: CouleursApplication.texteSecondaire,
  );

  /// Style pour les légendes
  static const TextStyle legende = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: CouleursApplication.texteSecondaire,
  );

  /// Style pour les boutons
  static const TextStyle boutton = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: CouleursApplication.texteSurFondSombre,
  );

  /// Style pour les liens
  static const TextStyle lien = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: CouleursApplication.primaire,
    decoration: TextDecoration.underline,
  );

  /// Style pour les messages d'erreur
  static const TextStyle erreur = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: CouleursApplication.erreur,
  );
} 