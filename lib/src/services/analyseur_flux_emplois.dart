import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import '../models/offre_emploi.dart';

/// Service pour analyser les flux RSS d'offres d'emploi
/// 
/// Cette classe s'occupe de récupérer un flux RSS depuis internet
/// et de le transformer en liste d'objets OffreEmploi
class AnalyseurFluxEmplois {
  /// URL du flux RSS d'offres d'emploi à analyser
  /// 
  /// Exemple : 'https://example.com/jobs-feed.xml'
  /// Tu peux changer cette URL pour utiliser un vrai flux d'emploi
  static const String sourceFlux = 'https://example.com/jobs-feed.xml';

  /// Délai d'attente maximum pour récupérer le flux (en secondes)
  static const int delaiAttenteMaximal = 30;

  /// Analyser le flux RSS et retourner une liste d'offres d'emploi
  /// 
  /// Cette méthode fait tout le travail :
  /// 1. Télécharge le flux RSS depuis internet
  /// 2. Parse le contenu XML
  /// 3. Transforme chaque item en OffreEmploi
  /// 4. Retourne la liste complète
  Future<List<OffreEmploi>> analyserOffres() async {
    try {
      print('🔄 Récupération du flux RSS depuis : $sourceFlux');
      
      // Étape 1 : Télécharger le flux RSS
      final contenuFlux = await _telechargerFlux();
      
      // Étape 2 : Parser le contenu XML
      final fluxRss = await _parserFluxRss(contenuFlux);
      
      // Étape 3 : Transformer en liste d'OffreEmploi
      final offresEmploi = _transformerEnOffres(fluxRss);
      
      print('✅ ${offresEmploi.length} offres d\'emploi récupérées avec succès');
      return offresEmploi;
      
    } catch (erreur) {
      print('❌ Erreur lors de l\'analyse du flux : $erreur');
      // En cas d'erreur, on retourne une liste vide plutôt que de planter
      return [];
    }
  }

  /// Télécharge le contenu du flux RSS depuis internet
  Future<String> _telechargerFlux() async {
    final reponse = await http.get(
      Uri.parse(sourceFlux),
      headers: {
        'User-Agent': 'JobAlerte/1.0', // Identification de notre app
      },
    ).timeout(
      const Duration(seconds: delaiAttenteMaximal),
    );

    if (reponse.statusCode == 200) {
      // Conversion en UTF-8 pour gérer les caractères français
      return utf8.decode(reponse.bodyBytes);
    } else {
      throw Exception(
        'Impossible de récupérer le flux RSS (Code: ${reponse.statusCode})'
      );
    }
  }

  /// Parse le contenu XML du flux RSS
  Future<RssFeed> _parserFluxRss(String contenuXml) async {
    try {
      final flux = RssFeed.parse(contenuXml);
      return flux;
    } catch (erreur) {
      throw Exception('Erreur lors du parsing du flux RSS : $erreur');
    }
  }

  /// Transforme les items RSS en objets OffreEmploi
  List<OffreEmploi> _transformerEnOffres(RssFeed flux) {
    final offres = <OffreEmploi>[];
    
    // Vérifier qu'il y a bien des items dans le flux
    if (flux.items == null || flux.items!.isEmpty) {
      print('⚠️ Aucun item trouvé dans le flux RSS');
      return offres;
    }

    // Transformer chaque item RSS en OffreEmploi
    for (final item in flux.items!) {
      try {
        final offre = OffreEmploi.depuisRssItem(item);
        offres.add(offre);
      } catch (erreur) {
        print('⚠️ Erreur lors de la transformation d\'un item : $erreur');
        // On continue avec les autres items même si un pose problème
        continue;
      }
    }

    return offres;
  }

  /// Méthode pour tester avec une URL personnalisée
  /// 
  /// Utile pour tester avec différents flux RSS sans modifier le code
  Future<List<OffreEmploi>> analyserOffresDepuisUrl(String urlFlux) async {
    try {
      print('🔄 Récupération du flux RSS depuis : $urlFlux');
      
      final reponse = await http.get(
        Uri.parse(urlFlux),
        headers: {'User-Agent': 'JobAlerte/1.0'},
      ).timeout(const Duration(seconds: delaiAttenteMaximal));

      if (reponse.statusCode != 200) {
        throw Exception('Code de réponse HTTP : ${reponse.statusCode}');
      }

      final contenu = utf8.decode(reponse.bodyBytes);
      final flux = RssFeed.parse(contenu);
      final offres = _transformerEnOffres(flux);
      
      print('✅ ${offres.length} offres récupérées depuis $urlFlux');
      return offres;
      
    } catch (erreur) {
      print('❌ Erreur avec l\'URL $urlFlux : $erreur');
      return [];
    }
  }
} 