import 'package:flutter_local_notifications/flutter_local_notifications.dart';
/*
class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        '0',
        'notif',

        importance: Importance.max
      ),
      iOS: IOSNotificationDetails(),
    );
  }


  static Future showNotification({
    int id  = 0 ,
    String? title,
    String? body,
    String? payload,
  }) async => _notifications.show(
    id,
    title,
    body,
    await _notificationDetails(),
    payload: payload,
  );

}

 */
class LocalNotificationService{
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@drawable_hdpi/voltix');

     IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          onDidReceiveLocalNotification: _onDidReceiveLocalNotification
        );

     final InitializationSettings settings = InitializationSettings(
       android: androidInitializationSettings,
       iOS: iosInitializationSettings,
     );

     await _localNotificationService.initialize(settings,
       onSelectNotification: onSelectedNotification, );
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'channel_id',
        'channel_name',
    channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );
    const IOSNotificationDetails iOSNotificationDetails =
    IOSNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );
  }

  Future<void> showNotification({
    required int id ,
    required String title,
    required String body,
}) async{
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }

  void _onDidReceiveLocalNotification(int id , String? title,String ? body ,String ? payload ){
    print('id $id ');
  }
  void onSelectedNotification(String ? payload ){
    print('payload $payload ');
  }

}