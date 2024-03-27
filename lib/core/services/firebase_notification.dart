import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mini_ecommerce_app_assignment/core/services/local_notification_service.dart';

class FireBaseNotification {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> createCampange() async {}

  Future<void> initMessaging() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print(await messaging.getToken());

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          if (message.notification != null) {
            LocalNotification().createNotification(
                message.notification?.title, message.notification?.body);
          }
        },
      );
    }
  }
}
