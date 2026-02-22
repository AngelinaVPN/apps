import 'dart:io';
import 'package:flutter/services.dart';

class StatusBarManager {
  static const MethodChannel _channel = MethodChannel('status_bar_icon');

  static Future<void> updateIcon({required bool isConnected}) async {
    if (!Platform.isMacOS) return;

    try {
      await _channel.invokeMethod('updateIcon', {
        'isConnected': isConnected,
      });
    } catch (e) {
      // silent
    }
  }

  static Future<bool> getTrayMode() async {
    if (!Platform.isMacOS) return false;
    try {
      final value = await _channel.invokeMethod<bool>('getTrayMode');
      return value ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> setTrayMode(bool enabled) async {
    if (!Platform.isMacOS) return false;
    try {
      final value = await _channel.invokeMethod<bool>('setTrayMode', {
        'enabled': enabled,
      });
      return value ?? false;
    } catch (_) {
      return false;
    }
  }
}
