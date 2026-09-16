  import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

Future<void> launchWebsite(String url) async {
    final uri = Uri.parse(url.startsWith('http') ? url : 'https://$url');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      log('Could not launch $url');
    }
  }