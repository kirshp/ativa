import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

/// User's favorite items, keyed as `event:NAME|DATE` or `levada:CODE`.
final favorites = ValueNotifier<Set<String>>({});

Future<void> initStore() async {
  prefs = await SharedPreferences.getInstance();
  favorites.value = (prefs.getStringList('favorites') ?? []).toSet();
}

/// Network-first JSON fetch with a local cache fallback. On success the raw
/// body is cached; if the network fails, the last cached body is returned so
/// the app still works offline / with a weak signal in the mountains.
Future<dynamic> cachedJson(String url) async {
  try {
    final r =
        await http.get(Uri.parse(url)).timeout(const Duration(seconds: 15));
    final body = utf8.decode(r.bodyBytes);
    await prefs.setString('cache:$url', body);
    return jsonDecode(body);
  } catch (e) {
    final c = prefs.getString('cache:$url');
    if (c != null) return jsonDecode(c);
    rethrow;
  }
}

bool isFav(String key) => favorites.value.contains(key);

void toggleFav(String key) {
  final s = {...favorites.value};
  s.contains(key) ? s.remove(key) : s.add(key);
  favorites.value = s;
  prefs.setStringList('favorites', s.toList());
}
