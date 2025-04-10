import 'package:url_launcher/url_launcher.dart';

Future<void> openMapLocation({required double lat,required double lng}) async {
  final uri = Uri.parse("geo:$lat,$lng?q=$lat,$lng");
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    // fallback to browser if app isn't installed
    final browserUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");
    await launchUrl(browserUrl, mode: LaunchMode.externalApplication);
  }
}
