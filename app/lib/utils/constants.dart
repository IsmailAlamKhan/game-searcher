import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'logger.dart';

final DateFormat appDateFormat = DateFormat('dd MMM, yyyy');
const appName = 'GameHunter';

// RAWG API Attribution
const rawgApiName = 'RAWG';
const rawgApiUrl = 'https://rawg.io/';
const rawgApiAttribution = 'Powered by RAWG API';

Future<void> launchUrlWithLogging(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    appLogger.e('Could not launch $url');
  }
}

IconData getStoreIcon(String? storeName) {
  final name = (storeName ?? "").toLowerCase();
  if (name.contains('steam')) return FontAwesomeIcons.steam;
  if (name.contains('playstation')) return FontAwesomeIcons.playstation;
  if (name.contains('xbox')) return FontAwesomeIcons.xbox;
  // if (name.contains('epic')) return FontAwesomeIcons.epicGames;
  if (name.contains('apple') || name.contains('app store')) return FontAwesomeIcons.apple;
  if (name.contains('google') || name.contains('android')) return FontAwesomeIcons.googlePlay;
  if (name.contains('gog')) return FontAwesomeIcons.ghost;
  if (name.contains('itch')) return FontAwesomeIcons.itchIo;
  return FontAwesomeIcons.bagShopping;
}
