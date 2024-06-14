// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sru/core/app_constants/app_constant.dart';
// import 'package:sru/core/app_constants/route.dart';
// import 'package:sru/core/models/inventory/dto/item_reorder_notifications_dto.dart';
// import 'package:sru/core/services/authentication_service.dart';
// import 'package:sru/core/services/navigation_service.dart';
// import 'package:sru/core/services/push_notification_service.dart';

// final notifHandlerService = Provider<NotificationHandlerService>(
//   (ref) => NotificationHandlerService(
//     authenticationService: ref.read(authProvider),
//     navigationService: ref.read(navigationProvider),
//   ),
// );

// class NotificationHandlerService {
//   NotificationHandlerService({
//     required NavigationService navigationService,
//     // required DeepLinkService deepLinkService,
//     required AuthenticationService authenticationService,
//   })  : _navigationService = navigationService,
//         // _deepLinkService = deepLinkService,
//         _authenticationService = authenticationService;

//   final NavigationService _navigationService;
//   // final DeepLinkService _deepLinkService;
//   final AuthenticationService _authenticationService;

//   Map<String, dynamic> extractDataFromFCM(Map<String, dynamic> message) {
//     if (Platform.isIOS) return Map<String, dynamic>.from(message);
//     return Map<String, dynamic>.from(message['data'] ?? {});
//   }

//   Map<String, dynamic> extractPayloadFromData(Map<String, dynamic>? data) {
//     if (data == null || data.isEmpty) {
//       return {};
//     }

//     return json.decode((data['payload'] ?? '{}'));
//   }

//   LocalPushNotifPayload? extractNotificationFromMessage(
//     Map<String, dynamic> message,
//   ) {
//     if (Platform.isIOS) {
//       Map<String, dynamic>? aps = Map<String, dynamic>.from(message['aps']);
//       if (aps.isEmpty || aps['alert'] == null) return null;

//       String title = aps['alert']?['title'];
//       String body = aps['alert']['title'];
//       if (title.isEmpty || body.isEmpty) return null;

//       return LocalPushNotifPayload(title, body);
//     }

//     Map<String, dynamic>? data = Map<String, dynamic>.from(message['data']);

//     if (data.containsKey('title') && data.containsKey('title')) {
//       return LocalPushNotifPayload(data['title'], data['body']);
//     }

//     return null;
//   }

//   Future<dynamic> handleOnTapLocalNotification(String? jsonPayload) async {
//     final Map<String, dynamic> payload = json.decode(jsonPayload!);
//     handleOnTapNotification(payload);
//   }

//   void handleOnTapNotification(Map<String, dynamic> data) {
//     final type = NotifMessageTypes.notifMessageTypes[data['type']];

//     final bool isNotificationFromQiscus = data.containsKey('chat_room_id');
//     if (isNotificationFromQiscus) {
//       final String? roomId = data['chat_room_id'];

//       if (roomId == null) {
//         return;
//       }

//       return;
//     }
//     final Map<String, dynamic> payload = json.decode(data['payload'] ?? '{}');

//     switch (type) {
//       case NotifMessageType.deeplink:
//         final String deeplinkString =
//             data['deeplink'] ?? payload['deeplink'] ?? '';

//         final Uri deepLink = Uri.parse(deeplinkString);
//         // _dynamicLinkService.handleDeepLink(deepLink);
//         break;
//       case NotifMessageType.reorderMinimumStock:
//         final itemReorderItemVariant = ItemReorderItemVariant.fromJson(payload);
//         _navigationService.navigateTo(
//           Routes.dashboardUsaha,
//           arguments: itemReorderItemVariant,
//         );
//         break;
//       default:
//         _navigationService.navigateTo(Routes.mainMenu);
//         break;
//     }
//   }
// }
