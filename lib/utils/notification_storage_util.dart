import 'package:bsccs/models/app_notification.dart';
import 'package:localstorage/localstorage.dart';

class NotificationStorageUtil {
  static LocalStorage? _storage;

  static LocalStorage _init() {
    _storage = LocalStorage("bsc_notifications.json");
    return _storage!;
  }

  static Future<void> saveNotification(AppNotification notification) {
    var storage = _init();
    return storage.setItem(notification.id, notification.toMap());
  }

  static AppNotification getNotification(String notificationId) {
    var storage = _init();
    return AppNotification.fromMap(storage.getItem(notificationId));
  }

  static Stream<Map<String, dynamic>> getNotificationsAsStream() {
    var storage = _init();
    return storage.stream;
  }

  static Future<bool> getIsReady() {
    var storage = _init();
    return storage.ready;
  }
}
