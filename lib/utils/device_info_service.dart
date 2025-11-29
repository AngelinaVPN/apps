import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flclashx/common/common.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win32_registry/win32_registry.dart';

class DeviceDetails {

  DeviceDetails({
    this.hwid,
    this.os,
    this.osVersion,
    this.model,
    this.appVersion,
  });
  final String? hwid;
  final String? os;
  final String? osVersion;
  final String? model;
  final String? appVersion;
}

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static const String _hwidStorageKey = 'app_persistent_hwid';

  String _generateCompact16CharId(String fullId) {
    final bytes = utf8.encode(fullId);
    final hash = sha256.convert(bytes);
    final hashHex = hash.toString();
    return hashHex.substring(0, 16).toUpperCase();
  }

  Future<String?> _getWindowsMachineGuid() async {
    try {
      const keyPath = r'SOFTWARE\Microsoft\Cryptography';
      const valueName = 'MachineGuid';
      
      final key = Registry.openPath(RegistryHive.localMachine, path: keyPath);
      final data = key.getValue(valueName);
      key.close();
      
      final value = data?.toString();
      
      return value;
    } catch (e) {
      commonPrint.log("Failed to get Windows MachineGuid: $e");
      return null;
    }
  }

  Future<String?> _getPlatformDeviceId() async {
    try {
      if (Platform.isWindows) {
        final machineGuid = await _getWindowsMachineGuid();
        if (machineGuid != null && machineGuid.isNotEmpty) {
          commonPrint.log("Windows MachineGuid: $machineGuid");
          return machineGuid;
        }
        
        final info = await _deviceInfoPlugin.windowsInfo;
        final fallback = '${info.computerName}-${info.deviceId}-${info.productId}';
        commonPrint.log("Windows fallback ID: $fallback");
        return fallback;
      } else if (Platform.isAndroid) {
        final info = await _deviceInfoPlugin.androidInfo;
        final combined = '${info.brand}-${info.device}-${info.hardware}-${info.id}';
        commonPrint.log("Android Device ID: $combined");
        return combined;
      } else if (Platform.isLinux) {
        final info = await _deviceInfoPlugin.linuxInfo;
        final combined = info.machineId ?? '${info.id}-${info.name}';
        commonPrint.log("Linux Device ID: $combined");
        return combined;
      } else if (Platform.isMacOS) {
        final info = await _deviceInfoPlugin.macOsInfo;
        final combined = info.systemGUID ?? '${info.model}-${info.computerName}';
        commonPrint.log("macOS Device ID: $combined");
        return combined;
      }
      return null;
    } catch (e) {
      commonPrint.log("Failed to get platform device ID: $e");
      return null;
    }
  }

  Future<String?> _getOrCreatePersistentHwid() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      final storedHwid = prefs.getString(_hwidStorageKey);
      if (storedHwid != null && storedHwid.length == 16) {
        commonPrint.log("Using stored HWID: $storedHwid");
        return storedHwid;
      }
      
      final deviceId = await _getPlatformDeviceId();
      
      if (deviceId == null || deviceId.isEmpty) {
        commonPrint.log("ERROR: Device ID is null or empty");
        return null;
      }
      
      final newHwid = _generateCompact16CharId(deviceId);
      await prefs.setString(_hwidStorageKey, newHwid);
      commonPrint.log("Generated new HWID: $newHwid from Device ID: $deviceId");
      
      return newHwid;
    } catch (e) {
      commonPrint.log("ERROR getting HWID: $e");
      return null;
    }
  }

  Future<DeviceDetails> getDeviceDetails() async {
    String? hwid, os, osVersion, model;
    final packageInfo = await PackageInfo.fromPlatform();
    final appVersion = packageInfo.version;

    try {
      hwid = await _getOrCreatePersistentHwid();

      if (Platform.isWindows) {
        final info = await _deviceInfoPlugin.windowsInfo;
        os = 'Windows';
        osVersion = info.displayVersion;
        model = info.productName;
      } else if (Platform.isAndroid) {
        final info = await _deviceInfoPlugin.androidInfo;
        os = 'Android';
        osVersion = info.version.release;
        model = '${info.manufacturer} ${info.model}';
      } else if (Platform.isLinux) {
        final info = await _deviceInfoPlugin.linuxInfo;
        os = 'Linux';
        osVersion = info.versionId;
        model = info.name;
      } else if (Platform.isMacOS) {
        final info = await _deviceInfoPlugin.macOsInfo;
        os = 'macOS';
        osVersion = info.osRelease;
        model = info.model;
      }
    } catch (e) {
      // Silently handle errors in device info retrieval
    }

    return DeviceDetails(
      hwid: hwid,
      os: os,
      osVersion: osVersion,
      model: model,
      appVersion: appVersion,
    );
  }
}