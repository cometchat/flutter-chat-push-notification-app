import 'package:flutter/material.dart';
import 'package:flutter_apns_only/flutter_apns_only.dart';
import 'package:flutter_pn/services/cometchat_service.dart';
import 'package:flutter_pn/services/navigation_service.dart';

class APNSService {
  final _connector = ApnsPushConnectorOnly();

  init() {
    _connector.configureApns(
      onBackgroundMessage: (message) async {
        debugPrint('onBackgroundMessage: ${message.toString()}');
      },
      onMessage: (message) async {
        debugPrint('onMessage: ${message.toString()}');
      },
      onLaunch: (message) async {
        debugPrint('onLaunch: ${message.toString()}');
        NavigationService.navigateToChat('onLaunch');
      },
      onResume: (message) async {
        debugPrint('onResume: ${message.toString()}');
        NavigationService.navigateToChat('onResume');
      },
    );

    _connector.token.addListener(() {
      String? token = _connector.token.value;
      debugPrint('Device token: ${token.toString()}');
      if (token != null) {
        CometChatService.registerToken(token, 'apns');
      }
    });

    _connector.requestNotificationPermissions().then((permission) =>
        debugPrint('requestNotificationPermissions: ${permission.toString()}'));
  }
}
