// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:collection/collection.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:mjk_apps/core/app_constants/app_constant.dart';
// import 'package:mjk_apps/core/models/authentication/login.dart';
// import 'package:mjk_apps/core/models/fcm_token.dart';
// import 'package:mjk_apps/core/network/notification_network.dart';
// import 'package:mjk_apps/core/services/notification_handler_service.dart';
// import 'package:mjk_apps/core/services/push_notification_service.dart';
// import 'package:mjk_apps/core/services/shared_preferences_service.dart';

// class FCMService {
//   FCMService({
//     required SharedPreferencesService sharedPreferencesService,
//     required PushNotificationService pushNotificationService,
//     required NotificationHandlerService notificationHandlerService,
//     required NotificationApiService notificationApiService,
//   })  : _sharedPreferencesService = sharedPreferencesService,
//         _pushNotificationService = pushNotificationService,
//         _notificationHandlerService = notificationHandlerService,
//         _notificationApiService = notificationApiService;

//   final SharedPreferencesService _sharedPreferencesService;
//   final PushNotificationService _pushNotificationService;
//   final NotificationHandlerService _notificationHandlerService;
//   final NotificationApiService _notificationApiService;

//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   bool _isInitialized = false;
//   String? _lastMessage;

//   Future<void> initialize() async {
//     final FCMToken? savedToken = await _sharedPreferencesService.get(
//       SharedPrefKeys.fcmToken,
//     );
//     if (savedToken == null) {
//       await _fetchToken();
//     }
//     await _registerDeviceToNotificationService();

//     if (_isInitialized) {
//       return;
//     }

//     final bool isPermissionGranted =
//         (await _pushNotificationService.initialize() ?? false) &&
//             await _requestPermission();

//     if (isPermissionGranted) {
//       final RemoteMessage? initialMsg =
//           await FirebaseMessaging.instance.getInitialMessage();

//       if (initialMsg != null) {
//         final Map<String, dynamic> data = initialMsg.data;
//         _notificationHandlerService.handleOnTapNotification(data);
//       }

//       FirebaseMessaging.onMessage.listen(
//         (RemoteMessage message) async {
//           if (message.notification == null || Platform.isIOS) return;

//           LocalPushNotifPayload notification = LocalPushNotifPayload(
//             message.notification?.title ?? '',
//             message.notification?.body ?? '',
//           );

//           final Map<String, dynamic> data = message.data;
//           final bool isNotificationFromQiscus =
//               data.containsKey('chat_room_id');

//           if (isNotificationFromQiscus) {
//             data['click_action'] = 'FLUTTER_NOTIFICATION_CLICK';

//             return _pushNotificationService.showSimpleNotif(
//               title: notification.title,
//               body: notification.body,
//               payload: json.encode(data),
//             );
//           }

//           if (data.containsKey('click_action')) {
//             data.remove('click_action');
//           }

//           if (_lastMessage != null) {
//             final Map<String, dynamic> mappedLastMessage =
//                 json.decode(_lastMessage!);
//             final bool messageIsSameAsLast = const DeepCollectionEquality()
//                 .equals(mappedLastMessage, message);

//             if (messageIsSameAsLast) {
//               return;
//             }
//           }

//           _pushNotificationService.showSimpleNotif(
//             title: notification.title,
//             body: notification.body,
//             payload: json.encode(data),
//           );

//           _lastMessage = json.encode(message.data);
//         },
//       );
//       FirebaseMessaging.onMessageOpenedApp.listen(
//         (RemoteMessage message) async {
//           final Map<String, dynamic> data = message.data;
//           _notificationHandlerService.handleOnTapNotification(data);
//         },
//       );

//       await FirebaseMessaging.instance
//           .setForegroundNotificationPresentationOptions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//       _isInitialized = true;
//     }
//   }

//   Future<bool> _requestPermission() async {
//     if (AppConstant.platform == AppConstant.androidPlatform) return true;

//     await _firebaseMessaging.requestPermission(
//       sound: true,
//       badge: true,
//       alert: true,
//       provisional: true,
//     );
//     return true;
//   }

//   Future<void> _fetchToken() async {
//     final String? token = await _firebaseMessaging.getToken();
//     if (token != null && token.isNotEmpty) {
//       await _tokenHandler(token);
//     }
//   }

//   Future<void> _tokenHandler(String token) async {
//     final FCMToken? savedToken = await _sharedPreferencesService.get(
//       SharedPrefKeys.fcmToken,
//     );

//     if (savedToken == null || savedToken.fcmToken != token) {
//       final FCMToken fcmToken = FCMToken(
//         fcmToken: token,
//       );
//       await _sharedPreferencesService.set(
//         SharedPrefKeys.fcmToken,
//         jsonEncode(fcmToken.toJson()),
//       );
//     }
//   }

//   Future<void> _registerDeviceToNotificationService() async {
//     final FCMToken? token = await _sharedPreferencesService.get(
//       SharedPrefKeys.fcmToken,
//     );
//     final userCredential = await _sharedPreferencesService.get(
//       SharedPrefKeys.userCredential,
//     );
//     final bool tokenIsValid = token != null && token.fcmID != null;
//     log('[TOKEN] ${token?.fcmToken}');
//     final bool accountInfoIsValid = userCredential != null;

//     if (tokenIsValid && accountInfoIsValid) return;

//     final String deviceType = AppConstant.platform!;

//     final String deviceToken = '${deviceType}_${token?.fcmToken}';

//     token?.fcmID = deviceToken;
//     await _sharedPreferencesService.set(
//       SharedPrefKeys.fcmToken,
//       jsonEncode(token?.toJson()),
//     );
//   }
// }
