// import 'dart:convert';
// import 'dart:developer';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import '../../firebase_options.dart';
// import '../Router/Router.dart';
// import '../Router/navigation_helper.dart';
// import 'utils.dart';

// class FBMessaging {
//   static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//   static FlutterLocalNotificationsPlugin? _notificationsPlugin;
//   static bool _isInitialized = false;

//   static const _androidChannel = AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     description: 'This channel is used for important notifications.',
//     importance: Importance.high,
//   );

//   @pragma('vm:entry-point')
//   static Future<void> firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     await Firebase.initializeApp(
//         options: DefaultFirebaseOptions.currentPlatform);
//     await _setNotificationPresentationOptions();
//   }

//   @pragma('vm:entry-point')
//   static Future<void> onBackgroundNotificationHandler(
//       NotificationResponse response) async {
//     if (response.payload != null) {
//       final data = json.decode(response.payload!);
//       final notification = FCMNotification.fromMap(data);
//       _handleNotificationOnClick(notification, appIsopened: false);
//     }
//   }

//   static Future<void> initialize() async {
//     if (_isInitialized) return;

//     await Firebase.initializeApp(
//         options: DefaultFirebaseOptions.currentPlatform);
//     await _setupNotificationChannels();
//     await _requestPermissions();
//     await _configureMessagingHandlers();
//     await _getToken();
//     await _messaging.subscribeToTopic("all");

//     _isInitialized = true;
//   }

//   static Future<void> _setupNotificationChannels() async {
//     _notificationsPlugin = FlutterLocalNotificationsPlugin();
//     await _notificationsPlugin
//         ?.resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(_androidChannel);

//     const androidSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     const iosSettings = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       defaultPresentSound: true,
//     );

//     await _notificationsPlugin?.initialize(
//       const InitializationSettings(android: androidSettings, iOS: iosSettings),
//       onDidReceiveNotificationResponse: onBackgroundNotificationHandler,
//     );
//   }

//   static Future<void> _requestPermissions() async {
//     await _messaging.requestPermission(
//       alert: false,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//     await _setNotificationPresentationOptions();
//   }

//   static Future<void> _setNotificationPresentationOptions() async {
//     await _messaging.setForegroundNotificationPresentationOptions(
//       alert: false, // We handle foreground notifications ourselves
//       badge: true,
//       sound: true,
//     );
//   }

//   static Future<void> _configureMessagingHandlers() async {
//     // Handle initial message when app is launched from terminated state
//     final initialMessage = await _messaging.getInitialMessage();
//     if (initialMessage != null) {
//       FCMNotification notification =
//           FCMNotification.fromMap(initialMessage.data);
//       _handleNotificationOnClick(
//         notification,
//         appIsopened: false,
//       );
//     }

//     // Handle messages when app is in foreground
//     FirebaseMessaging.onMessage.listen(
//         (message) => _processMessageInForeground(message, appIsOpened: true));

//     // Handle messages when app is in background but opened by user
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       FCMNotification notification = FCMNotification.fromMap(message.data);
//       _handleNotificationOnClick(
//         notification,
//         appIsopened: false,
//       );
//     });
//   }

//   static Future<void> _processMessageInForeground(RemoteMessage message,
//       {required bool appIsOpened, bool showNotification = true}) async {
//     log(message.data.toString(), name: "Message Data");
//     log(message.notification?.title ?? "No title", name: "Notification Title");
//     log(message.notification?.body ?? "No body", name: "Notification Body");

//     // Don't show notification if it's a chat message for the current room
//     if (_shouldSkipChatNotification(message)) {
//       return;
//     }

//     // Show the notification
//     if (showNotification) {
//       await _showNotification(message);
//     }
//   }

//   static bool _shouldSkipChatNotification(RemoteMessage message) {
//     return message.data['type'] == 'chat' &&
//         message.data['model_id']?.toString() == Utils.currentRoomId;
//   }

//   static Future<void> _showNotification(RemoteMessage message) async {
//     log(message.notification?.title ?? "No title",
//         name: "showNotification Title");
//     log(message.notification?.body ?? "No body", name: "showNotification Body");
//     log(message.data.toString(), name: "showNotification Data");
//     if (message.notification == null) return;

//     await _notificationsPlugin?.show(
//       message.hashCode,
//       message.notification?.title,
//       message.notification?.body,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'high_importance_channel',
//           'High Importance Notifications',
//           channelDescription:
//               'This channel is used for important notifications.',
//         ),
//         iOS: DarwinNotificationDetails(),
//       ),
//       payload: jsonEncode(message.data),
//     );
//   }

//   static Future<void> _getToken() async {
//     final token = await _messaging.getToken();
//     log(token ?? "No FCM token", name: "Firebase Token");
//     Utils.FCMToken = token ?? '';
//   }

//   static Future<void> subscribeToClient() async {
//     await _messaging.subscribeToTopic("all");
//     await _messaging.subscribeToTopic("client");
//     log("Subscribed to client topics");
//   }

//   static Future<void> unsubscribeFromClient() async {
//     await _messaging.unsubscribeFromTopic("all");
//     await _messaging.unsubscribeFromTopic("client");
//     log("Unsubscribed from client topics");
//   }

//   static Future<void> subscribeToProvider() async {
//     await _messaging.subscribeToTopic("all");
//     await _messaging.subscribeToTopic("provider");
//     log("Subscribed to provider topics");
//   }

//   static Future<void> unsubscribeFromProvider() async {
//     await _messaging.unsubscribeFromTopic("all");
//     await _messaging.unsubscribeFromTopic("provider");
//     log("Unsubscribed from provider topics");
//   }

//   static Future<void> revokeToken() async {
//     await _messaging.deleteToken();
//     Utils.FCMToken = "";
//     log("FCM token revoked", name: "Firebase Token");
//   }

//   static _handleNotificationOnClick(FCMNotification notification,
//       {bool appIsopened = false}) {
//     log(notification.type.toString(), name: "Notification Typemm");
//     log(notification.modelId.toString(), name: "Notification ModelId");
//     if (notification.type == "service" && notification.modelId != null) {
//       print("client: ${Utils.isClient}");
//       /*   if (appIsopened) {
//         Future.delayed(
//             const Duration(
//               milliseconds: 500,
//             ), () {
//           if (Utils.isClient) {
//             RouteHelper.pushNamed(Routes.orderDetailsScreen, arguments: {
//               "serviceOrderId": notification.modelId.toString(),
//               "serviceOrder": null,
//             });
//           } else {
//             RouteHelper.pushNamed(Routes.technicalOrderDetailsScreen,
//                 arguments: notification.modelId.toString());
//           }
//         });
//       } else {
//         if (Utils.isClient) {
//           RouteHelper.pushNamed(Routes.orderDetailsScreen, arguments: {
//             "serviceOrderId": notification.modelId.toString(),
//             "serviceOrder": null,
//           });
//         } else {
//           RouteHelper.pushNamed(Routes.technicalOrderDetailsScreen,
//               arguments: notification.modelId.toString());
//         }
//       } */
//     }
//     if (notification.type == "chat" &&
//         notification.modelId != null &&
//         notification.modelId!.isNotEmpty &&
//         notification.modelId != Utils.currentRoomId) {
//       if (appIsopened) {
//         if (RouteGenerator.currentRoute == Routes.chatScreen &&
//             Utils.currentRoomId != notification.modelId.toString()) {
//           Utils.currentRoomId = "";

//           // Navigator.pop(Utils.navigatorKey().currentState!.context);
//           Future.delayed(
//               const Duration(
//                 milliseconds: 600,
//               ),
//               () => RouteHelper.pushNamed(Routes.chatScreen,
//                   arguments: notification.modelId.toString()));
//         } else {
//           RouteHelper.pushNamed(Routes.chatScreen,
//               arguments: notification.modelId.toString());
//         }
//       } else {
//         //   RouteHelper.pushNamedReplaceAll(Routes.allUserLayoutscreen);
//         RouteHelper.pushNamed(Routes.chatScreen,
//             arguments: notification.modelId.toString());
//       }
//     } else if (notification.type == "ad") {}
//   }
// }

// class FCMNotification {
//   final String? title;
//   final String? message;
//   final String? type;
//   final String? modelId;

//   FCMNotification({
//     this.title,
//     this.message,
//     this.type,
//     this.modelId,
//   });

//   factory FCMNotification.fromMap(Map<String, dynamic> map) {
//     return FCMNotification(
//       title: map["title"],
//       message: map["message"],
//       type: map["type"],
//       modelId: map["model_id"]?.toString(),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       "title": title,
//       "message": message,
//       "type": type,
//       "model_id": modelId,
//     };
//   }
// }
