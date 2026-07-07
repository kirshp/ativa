import 'package:latlong2/latlong.dart';

/// Static gazetteer of Madeira place names → coordinates, used to place event
/// locations (plain text in the feed) on the map without a geocoding service.
/// Keys are lowercased, accent-stripped; longer (more specific) keys win.
const _places = <String, (double, double)>{
  // Municipalities and common localities
  'funchal': (32.6669, -16.9241),
  'camara de lobos': (32.6500, -16.9770),
  'curral das freiras': (32.7200, -16.9640),
  'santa cruz': (32.6883, -16.7930),
  'camacha': (32.6790, -16.8480),
  'machico': (32.7176, -16.7690),
  'porto da cruz': (32.7710, -16.8300),
  'santana': (32.8010, -16.8880),
  'sao vicente': (32.7970, -17.0440),
  'seixal': (32.8250, -17.1030),
  'porto moniz': (32.8660, -17.1670),
  'fanal': (32.8140, -17.1360),
  'calheta': (32.7180, -17.1770),
  'ponta do sol': (32.6810, -17.1010),
  'ribeira brava': (32.6740, -17.0620),
  'porto santo': (33.0700, -16.3400),
  // Peaks / trailheads / venues
  'pico do arieiro': (32.7357, -16.9285),
  'pico ruivo': (32.7586, -16.9419),
  'monte': (32.6720, -16.9000),
  'estadio dos barreiros': (32.6452, -16.9250),
  'parque de santa catarina': (32.6460, -16.9180),
  'praca do povo': (32.6440, -16.9080),
  'estadio do maritimo': (32.6470, -16.9350),
};

String _norm(String s) {
  s = s.toLowerCase();
  const from = 'áàâãäéèêëíìîïóòôõöúùûüç';
  const to = 'aaaaaeeeeiiiiooooouuuuc';
  final b = StringBuffer();
  for (final ch in s.split('')) {
    final i = from.indexOf(ch);
    b.write(i >= 0 ? to[i] : ch);
  }
  return b.toString();
}

/// Returns coordinates for a free-text location, or null if only a generic
/// island-wide name (e.g. "Madeira") or no known place is found.
LatLng? geocode(String location) {
  final n = _norm(location);
  String? best;
  for (final key in _places.keys) {
    if (n.contains(key) && (best == null || key.length > best.length)) {
      best = key;
    }
  }
  if (best == null) return null;
  final c = _places[best]!;
  return LatLng(c.$1, c.$2);
}
