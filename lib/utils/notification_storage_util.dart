import 'package:bsccs/models/app_notification.dart';
import 'package:localstorage/localstorage.dart';

class NotificationStorageUtil {
  static LocalStorage? _storage;
  static void Function(String id)? _listener;

  static LocalStorage _init() {
    _storage = LocalStorage("bsc_notifications.json");
    return _storage!;
  }

  static void saveNotification(AppNotification notification) async {
    var storage = _init();

    await storage.setItem(notification.id, notification.toMap());
    _listener?.call(notification.id);
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

  static closeStream() {
    var storage = _init();
    return storage.dispose();
  }

  static void clear() {
    var storage = _init();
    storage.clear();
  }

  static void registerListener(void Function(String id) onNotificationAdded) {
    NotificationStorageUtil._listener = onNotificationAdded;
  }

  static void unRegisterListener() {
    NotificationStorageUtil._listener = null;
  }
}
