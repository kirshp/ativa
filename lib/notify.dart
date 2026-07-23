import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'store.dart';

final _plugin = FlutterLocalNotificationsPlugin();
bool _ready = false;

/// Reminder keys the user has set, so the UI can show the bell state.
final reminders = ValueNotifier<Set<String>>({});

Future<void> initNotify() async {
  reminders.value = (prefs.getStringList('reminders') ?? []).toSet();
  tzdata.initializeTimeZones();
  try {
    final info = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(info.identifier));
  } catch (_) {
    tz.setLocalLocation(tz.getLocation('Atlantic/Madeira'));
  }
  const android = AndroidInitializationSettings('@mipmap/ic_launcher');
  const ios = DarwinInitializationSettings();
  await _plugin.initialize(
      settings:
          const InitializationSettings(android: android, iOS: ios));
  _ready = true;
}

Future<bool> _ensurePermission() async {
  final ios = _plugin.resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin>();
  if (ios != null) {
    return await ios.requestPermissions(alert: true, badge: true, sound: true) ??
        false;
  }
  final android = _plugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();
  if (android != null) {
    return await android.requestNotificationsPermission() ?? true;
  }
  return true;
}

int _idFor(String key) => key.hashCode & 0x7fffffff;

bool hasReminder(String key) => reminders.value.contains(key);

/// Schedules a reminder for the day before [dateIso] (YYYY-MM-DD) at 18:00
/// local time. Returns false if permission was denied or the date already
/// passed. [key] uniquely identifies the event.
Future<bool> setReminder(
    String key, String title, String dateIso) async {
  if (!_ready) return false;
  if (!await _ensurePermission()) return false;
  final parts = dateIso.split('-');
  if (parts.length != 3) return false;
  final y = int.tryParse(parts[0]),
      m = int.tryParse(parts[1]),
      d = int.tryParse(parts[2]);
  if (y == null || m == null || d == null) return false;

  final when = tz.TZDateTime(tz.local, y, m, d, 18)
      .subtract(const Duration(days: 1));
  if (when.isBefore(tz.TZDateTime.now(tz.local))) return false;

  const details = NotificationDetails(
    android: AndroidNotificationDetails('events', 'Event reminders',
        channelDescription: 'Reminders for Madeira events you follow',
        importance: Importance.high),
    iOS: DarwinNotificationDetails(),
  );
  await _plugin.zonedSchedule(
    id: _idFor(key),
    title: 'Madeira Ativa',
    body: 'Tomorrow: $title',
    scheduledDate: when,
    notificationDetails: details,
    androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
  );
  final s = {...reminders.value, key};
  reminders.value = s;
  await prefs.setStringList('reminders', s.toList());
  return true;
}

Future<void> cancelReminder(String key) async {
  await _plugin.cancel(id: _idFor(key));
  final s = {...reminders.value}..remove(key);
  reminders.value = s;
  await prefs.setStringList('reminders', s.toList());
}

/// Immediate local notification (used for trail status changes).
Future<void> notifyNow(String title, String body) async {
  if (!_ready) return;
  const det = NotificationDetails(
    android: AndroidNotificationDetails('status', 'Trail status',
        channelDescription: 'Trail open/closed changes'),
    iOS: DarwinNotificationDetails(),
  );
  await _plugin.show(id: 777, title: title, body: body, notificationDetails: det);
}
