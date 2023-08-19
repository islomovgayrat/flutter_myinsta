import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static Future deviceParams() async {
    Map<String, String> params = {};
    var deviceInfoPlugin = DeviceInfoPlugin();
    String fcmToken = '';
    String identifier;

    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      identifier = build.id;
      params.addAll({
        'deviceId': identifier,
        'deviceType': 'A',
        'deviceToken': fcmToken,
      }); // Android
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      identifier = data.identifierForVendor.toString();
      params.addAll({
        'deviceId': identifier,
        'deviceType': 'I',
        'deviceToken': fcmToken,
      });
    }

    return params;
  }

  static String currentDate() {
    DateTime now = DateTime.now();

    String convertedDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString()}:${now.minute.toString()}";
    return convertedDateTime;
  }

  static Future<bool> dialogCommon(
      BuildContext context, String title, String message, bool isSingle) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              !isSingle
                  ? MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text('Cancel'),
                    )
                  : const SizedBox.shrink(),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Confirm'),
              ),
            ],
          );
        });
  }
}
