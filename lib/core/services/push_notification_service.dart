// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mjk_apps/core/app_constants/app_constant.dart';
// import 'package:mjk_apps/core/services/notification_handler_service.dart';

// void _backgroundHandler(NotificationResponse response) {
//   print(response.payload);
// }

// final pushNotifService = Provider<PushNotificationService>(
//   (ref) => PushNotificationService(
//     ref.read(notifHandlerService).handleOnTapLocalNotification,
//   ),
// );

// class PushNotificationService {
//   PushNotificationService(
//     Future<dynamic> Function(String? payload)? onTapNotif,
//   ) : _onTapNotif = onTapNotif;

//   final FlutterLocalNotificationsPlugin _plugin =
//       FlutterLocalNotificationsPlugin();

//   final AndroidInitializationSettings _initializationSettingsAndroid =
//       const AndroidInitializationSettings('app_icon');

//   final DarwinInitializationSettings _initializationSettingsIOS =
//       const DarwinInitializationSettings(
//     requestAlertPermission: false,
//     requestBadgePermission: false,
//     requestSoundPermission: false,
//     defaultPresentAlert: true,
//     defaultPresentBadge: true,
//     defaultPresentSound: true,
//   );

//   final Map<String, String> defaultChannelAndroid = <String, String>{
//     'id': 'default',
//     'name': 'Notifications',
//     'description': '',
//   };

//   final Future<dynamic> Function(String? payload)? _onTapNotif;

//   int notifId = 0;

//   Future<bool?> initialize() async {
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: _initializationSettingsAndroid,
//       iOS: _initializationSettingsIOS,
//     );

//     final bool? initializationResult = await _plugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         _onTapNotif?.call(response.payload);
//       },
//       onDidReceiveBackgroundNotificationResponse: _backgroundHandler,
//     );

//     if (AppConstant.platform == AppConstant.iOSPlatform) {
//       return await _plugin
//           .resolvePlatformSpecificImplementation<
//               IOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(
//             alert: true,
//             badge: true,
//             sound: true,
//           );
//     }

//     return initializationResult;
//   }

//   Future<void> clearNotifications() async {
//     await _plugin.cancelAll();
//   }

//   Future<void> showSimpleNotif({
//     required String title,
//     required String body,
//     required String payload,
//     bool repeatId = false,
//   }) async {
//     final NotificationDetails notifDefails = NotificationDetails(
//       android: AndroidNotificationDetails(
//         defaultChannelAndroid['id']!,
//         defaultChannelAndroid['name']!,
//         channelDescription: defaultChannelAndroid['description'],
//         styleInformation: const BigTextStyleInformation(''),
//         //TODO: Need improve for notification using Picture
//       ),
//       iOS: const DarwinNotificationDetails(),
//     );

//     _plugin.show(
//       notifId,
//       title,
//       body,
//       notifDefails,
//       payload: payload,
//     );

//     if (!repeatId) notifId += 1;
//   }
// }

// class LocalPushNotifPayload {
//   const LocalPushNotifPayload(
//     this.title,
//     this.body,
//   );
//   final String title;
//   final String body;
// }
