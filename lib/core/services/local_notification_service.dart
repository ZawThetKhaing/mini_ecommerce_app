import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:mini_ecommerce_app_assignment/core/services/local_notification_controller.dart';

class LocalNotification {
  final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
  Future<void> initLocalNotification() async {
    await awesomeNotifications.initialize("resource://mipmap/ic_launcher", [
      NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: 'basic channel',
        channelName: 'Basic Notification',
        channelDescription: 'basic notifications channel',
      ),
    ], channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: "basic_channel_group",
          channelGroupName: "Basic Group")
    ]);
    final noti = await AwesomeNotifications().isNotificationAllowed();

    if (!noti) {
      awesomeNotifications.requestPermissionToSendNotifications();
    }

    awesomeNotifications.setListeners(
      onActionReceivedMethod:
          LocalNotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          LocalNotificationController.onNotificationCreatedMethod,
      onDismissActionReceivedMethod:
          LocalNotificationController.onDismissActionReceivedMethod,
      onNotificationDisplayedMethod:
          LocalNotificationController.onNotificationDisplayedMethod,
    );
  }

  Future<bool> createNotification(
    String? title,
    String? body, [
    Map<String, String?>? payload,
  ]) async {
    return awesomeNotifications.createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: "basic channel",
        title: title,
        body: body,
        payload: payload,
      ),
    );
  }
}
