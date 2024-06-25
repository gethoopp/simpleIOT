import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationLoc {
  static ReceivedAction? initialize;

  static Future<void> initializenotif() async {
    await AwesomeNotifications().initialize(
        // Set icon jika ingin mengirim dengan icon aplikasi
        null,
        [
          NotificationChannel(
              channelGroupKey: 'alerts',
              channelKey: 'alerts',
              channelName: 'Alerts user ',
              channelDescription: 'Notification channel for alerts user',
              defaultColor: const Color(0xFF9D50DD),
              ledColor: Colors.white)
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'alerts', channelGroupName: 'alerts user')
        ],
        debug: true);

    //initialGet = await AwesomeNotifications().getInitialNotificationAction(removeFromActionEvents: false);
  }

  static Future<void> notificationListener() async {
    await AwesomeNotifications().setListeners(
        onActionReceivedMethod: onRecieveMessageAction,
        onNotificationDisplayedMethod: onDisplayMessage,
        onDismissActionReceivedMethod: onDismissMessage,
        onNotificationCreatedMethod: onMessageCreated);
  }

  @pragma("vm:entry-point")
  static Future<void> onRecieveMessageAction(
      ReceivedNotification receivedNotification) async {
    if (receivedNotification.actionType == ActionType.SilentAction ||
        receivedNotification.actionType == ActionType.SilentBackgroundAction) {
    } else {
      Get.offAllNamed('/home');
    }
  }

  @pragma("vm:entry-point")
  static Future<void> onDisplayMessage(
      ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onDismissMessage(
      ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onMessageCreated(
      ReceivedNotification receivedNotification) async {}

  static Future<bool> createPermissions(BuildContext context) async {
    bool userAuthorized = false;

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              children: [
                TextButton(
                    onPressed: () async {
                      userAuthorized = true;
                      Navigator.of(context).pop(context);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [Text('Allowed'), Icon(Icons.done)],
                    )),
                TextButton(
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [Text('Cancel'), Icon(Icons.close)],
                    ))
              ],
            ),
          );
        });

    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  static Future<void> createNotification(BuildContext context) async {
    bool allowed =
        await AwesomeNotifications().requestPermissionToSendNotifications();
    // ignore: use_build_context_synchronously
    if (!allowed) allowed = await NotificationLoc.createPermissions(context);
    if (!allowed) return;
  }
}
