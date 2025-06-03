import 'package:webfeed/domain/rss_item.dart';

/// Modèle représentant une offre d'emploi
/// 
/// Cette classe contient toutes les informations importantes
/// d'une offre d'emploi récupérée depuis un flux RSS
class OffreEmploi {
  /// Titre de l'offre d'emploi
  final String titreOffre;
  
  /// Description détaillée de l'offre
  final String descriptionOffre;
  
  /// Date de publication de l'offre
  final DateTime datePublication;
  
  /// Lien pour consulter l'offre complète
  final String lienOffre;
  
  /// URL du logo de l'entreprise (peut être vide)
  final String urlLogoEntreprise;

  /// Constructeur principal
  const OffreEmploi({
    required this.titreOffre,
    required this.descriptionOffre,
    required this.datePublication,
    required this.lienOffre,
    this.urlLogoEntreprise = '',
  });

  /// Créer une OffreEmploi à partir d'un élément RSS
  /// 
  /// Cette méthode transforme un RssItem du package webfeed
  /// en objet OffreEmploi utilisable dans notre application
  factory OffreEmploi.depuisRssItem(RssItem item) {
    return OffreEmploi(
      titreOffre: item.title?.trim() ?? 'Titre non disponible',
      descriptionOffre: _nettoyerDescription(item.description ?? ''),
      datePublication: item.pubDate ?? DateTime.now(),
      lienOffre: item.link?.trim() ?? '',
      urlLogoEntreprise: _extraireUrlLogo(item),
    );
  }

  /// Nettoie la description en supprimant les balises HTML
  static String _nettoyerDescription(String description) {
    // Supprime les balises HTML basiques
    String descriptionPropre = description
        .replaceAll(RegExp(r'<[^>]*>'), '') // Supprime toutes les balises HTML
        .replaceAll('&nbsp;', ' ') // Remplace les espaces insécables
        .replaceAll('&amp;', '&') // Remplace les caractères échappés
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .trim();
    
    return descriptionPropre.isEmpty ? 'Description non disponible' : descriptionPropre;
  }

  /// Essaye d'extraire l'URL du logo depuis les métadonnées de l'item RSS
  static String _extraireUrlLogo(RssItem item) {
    // Dans un vrai flux RSS d'emploi, le logo pourrait être dans :
    // - item.enclosure?.url (pour les images jointes)
    // - Une balise custom dans item.content
    // Pour l'instant, on retourne une chaîne vide
    return item.enclosure?.url ?? '';
  }

  /// Représentation textuelle pour le débogage
  @override
  String toString() {
    return 'OffreEmploi(titre: $titreOffre, date: $datePublication)';
  }
} 