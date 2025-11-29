// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(
      _current != null,
      'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) => Localizations.of<AppLocalizations>(context, AppLocalizations);

  /// `By rule`
  String get rule => Intl.message('By rule', name: 'rule', desc: '', args: []);

  /// `Global`
  String get global => Intl.message('Global', name: 'global', desc: '', args: []);

  /// `Direct`
  String get direct => Intl.message('Direct', name: 'direct', desc: '', args: []);

  /// `Dashboard`
  String get dashboard => Intl.message('Dashboard', name: 'dashboard', desc: '', args: []);

  /// `Proxies`
  String get proxies => Intl.message('Proxies', name: 'proxies', desc: '', args: []);

  /// `Profile`
  String get profile => Intl.message('Profile', name: 'profile', desc: '', args: []);

  /// `Profiles`
  String get profiles => Intl.message('Profiles', name: 'profiles', desc: '', args: []);

  /// `Settings`
  String get tools => Intl.message('Settings', name: 'tools', desc: '', args: []);

  /// `Logs`
  String get logs => Intl.message('Logs', name: 'logs', desc: '', args: []);

  /// `Log capture records`
  String get logsDesc => Intl.message(
      'Log capture records',
      name: 'logsDesc',
      desc: '',
      args: [],
    );

  /// `Resources`
  String get resources => Intl.message('Resources', name: 'resources', desc: '', args: []);

  /// `External resource related info`
  String get resourcesDesc => Intl.message(
      'External resource related info',
      name: 'resourcesDesc',
      desc: '',
      args: [],
    );

  /// `Update All Geo Files`
  String get updateAllGeoData => Intl.message(
      'Update All Geo Files',
      name: 'updateAllGeoData',
      desc: '',
      args: [],
    );

  /// `Traffic usage`
  String get trafficUsage => Intl.message(
      'Traffic usage',
      name: 'trafficUsage',
      desc: '',
      args: [],
    );

  /// `Core info`
  String get coreInfo => Intl.message('Core info', name: 'coreInfo', desc: '', args: []);

  /// `Network speed`
  String get networkSpeed => Intl.message(
      'Network speed',
      name: 'networkSpeed',
      desc: '',
      args: [],
    );

  /// `Outbound mode`
  String get outboundMode => Intl.message(
      'Outbound mode',
      name: 'outboundMode',
      desc: '',
      args: [],
    );

  /// `Your IP Address`
  String get networkDetection => Intl.message(
      'Your IP Address',
      name: 'networkDetection',
      desc: '',
      args: [],
    );

  /// `Upload`
  String get upload => Intl.message('Upload', name: 'upload', desc: '', args: []);

  /// `Download`
  String get download => Intl.message('Download', name: 'download', desc: '', args: []);

  /// `No proxy`
  String get noProxy => Intl.message('No proxy', name: 'noProxy', desc: '', args: []);

  /// `Please create a profile or add a valid profile`
  String get noProxyDesc => Intl.message(
      'Please create a profile or add a valid profile',
      name: 'noProxyDesc',
      desc: '',
      args: [],
    );

  /// `No profile, Please add a profile`
  String get nullProfileDesc => Intl.message(
      'No profile, Please add a profile',
      name: 'nullProfileDesc',
      desc: '',
      args: [],
    );

  /// `Settings`
  String get settings => Intl.message('Settings', name: 'settings', desc: '', args: []);

  /// `Language`
  String get language => Intl.message('Language', name: 'language', desc: '', args: []);

  /// `Default`
  String get defaultText => Intl.message('Default', name: 'defaultText', desc: '', args: []);

  /// `More`
  String get more => Intl.message('More', name: 'more', desc: '', args: []);

  /// `Other`
  String get other => Intl.message('Other', name: 'other', desc: '', args: []);

  /// `About`
  String get about => Intl.message('About', name: 'about', desc: '', args: []);

  /// `English`
  String get en => Intl.message('English', name: 'en', desc: '', args: []);

  /// `Japanese`
  String get ja => Intl.message('Japanese', name: 'ja', desc: '', args: []);

  /// `Russian`
  String get ru => Intl.message('Russian', name: 'ru', desc: '', args: []);

  /// `Simplified Chinese`
  String get zh_CN => Intl.message(
      'Simplified Chinese',
      name: 'zh_CN',
      desc: '',
      args: [],
    );

  /// `Theme`
  String get theme => Intl.message('Theme', name: 'theme', desc: '', args: []);

  /// `Set dark mode,adjust the color`
  String get themeDesc => Intl.message(
      'Set dark mode,adjust the color',
      name: 'themeDesc',
      desc: '',
      args: [],
    );

  /// `Override`
  String get override => Intl.message('Override', name: 'override', desc: '', args: []);

  /// `Override Proxy related config`
  String get overrideDesc => Intl.message(
      'Override Proxy related config',
      name: 'overrideDesc',
      desc: '',
      args: [],
    );

  /// `AllowLan`
  String get allowLan => Intl.message('AllowLan', name: 'allowLan', desc: '', args: []);

  /// `Allow access proxy through the LAN`
  String get allowLanDesc => Intl.message(
      'Allow access proxy through the LAN',
      name: 'allowLanDesc',
      desc: '',
      args: [],
    );

  /// `TUN`
  String get tun => Intl.message('TUN', name: 'tun', desc: '', args: []);

  /// `only effective in administrator mode`
  String get tunDesc => Intl.message(
      'only effective in administrator mode',
      name: 'tunDesc',
      desc: '',
      args: [],
    );

  /// `Minimize on exit`
  String get minimizeOnExit => Intl.message(
      'Minimize on exit',
      name: 'minimizeOnExit',
      desc: '',
      args: [],
    );

  /// `Modify the default system exit event`
  String get minimizeOnExitDesc => Intl.message(
      'Modify the default system exit event',
      name: 'minimizeOnExitDesc',
      desc: '',
      args: [],
    );

  /// `Auto launch`
  String get autoLaunch => Intl.message('Auto launch', name: 'autoLaunch', desc: '', args: []);

  /// `Follow the system self startup`
  String get autoLaunchDesc => Intl.message(
      'Follow the system self startup',
      name: 'autoLaunchDesc',
      desc: '',
      args: [],
    );

  /// `SilentLaunch`
  String get silentLaunch => Intl.message(
      'SilentLaunch',
      name: 'silentLaunch',
      desc: '',
      args: [],
    );

  /// `Start in the background`
  String get silentLaunchDesc => Intl.message(
      'Start in the background',
      name: 'silentLaunchDesc',
      desc: '',
      args: [],
    );

  /// `AutoRun`
  String get autoRun => Intl.message('AutoRun', name: 'autoRun', desc: '', args: []);

  /// `Auto run when the application is opened`
  String get autoRunDesc => Intl.message(
      'Auto run when the application is opened',
      name: 'autoRunDesc',
      desc: '',
      args: [],
    );

  /// `Override`
  String get overrideProviderSettings => Intl.message('Override', name: 'overrideProviderSettings', desc: '', args: []);

  /// `Ignore provider settings and manage manually`
  String get overrideProviderSettingsDesc => Intl.message(
      'Ignore provider settings and manage manually',
      name: 'overrideProviderSettingsDesc',
      desc: '',
      args: [],
    );

  /// `These settings are managed by your provider`
  String get managedByProvider => Intl.message(
      'These settings are managed by your provider',
      name: 'managedByProvider',
      desc: '',
      args: [],
    );

  /// `Override network settings`
  String get overrideNetworkSettings => Intl.message(
      'Override network settings',
      name: 'overrideNetworkSettings',
      desc: '',
      args: [],
    );

  /// `Ignore network settings from provider config`
  String get overrideNetworkSettingsDesc => Intl.message(
      'Ignore network settings from provider config',
      name: 'overrideNetworkSettingsDesc',
      desc: '',
      args: [],
    );

  /// `These parameters are managed by your provider`
  String get managedByProviderNetwork => Intl.message(
      'These parameters are managed by your provider',
      name: 'managedByProviderNetwork',
      desc: '',
      args: [],
    );

  /// `Logcat`
  String get logcat => Intl.message('Logcat', name: 'logcat', desc: '', args: []);

  /// `Disabling will hide the log entry`
  String get logcatDesc => Intl.message(
      'Disabling will hide the log entry',
      name: 'logcatDesc',
      desc: '',
      args: [],
    );

  /// `Auto check updates`
  String get autoCheckUpdate => Intl.message(
      'Auto check updates',
      name: 'autoCheckUpdate',
      desc: '',
      args: [],
    );

  /// `Auto check for updates when the app starts`
  String get autoCheckUpdateDesc => Intl.message(
      'Auto check for updates when the app starts',
      name: 'autoCheckUpdateDesc',
      desc: '',
      args: [],
    );

  /// `AccessControl`
  String get accessControl => Intl.message(
      'AccessControl',
      name: 'accessControl',
      desc: '',
      args: [],
    );

  /// `Configure application access proxy`
  String get accessControlDesc => Intl.message(
      'Configure application access proxy',
      name: 'accessControlDesc',
      desc: '',
      args: [],
    );

  /// `Application Settings`
  String get application => Intl.message(
      'Application Settings',
      name: 'application',
      desc: '',
      args: [],
    );

  /// `Standard application settings`
  String get applicationDesc => Intl.message(
      'Standard application settings',
      name: 'applicationDesc',
      desc: '',
      args: [],
    );

  /// `Edit`
  String get edit => Intl.message('Edit', name: 'edit', desc: '', args: []);

  /// `Confirm`
  String get confirm => Intl.message('Confirm', name: 'confirm', desc: '', args: []);

  /// `Update`
  String get update => Intl.message('Update', name: 'update', desc: '', args: []);

  /// `Add`
  String get add => Intl.message('Add', name: 'add', desc: '', args: []);

  /// `Save`
  String get save => Intl.message('Save', name: 'save', desc: '', args: []);

  /// `Delete`
  String get delete => Intl.message('Delete', name: 'delete', desc: '', args: []);

  /// `Years`
  String get years => Intl.message('Years', name: 'years', desc: '', args: []);

  /// `Months`
  String get months => Intl.message('Months', name: 'months', desc: '', args: []);

  /// `Hours`
  String get hours => Intl.message('Hours', name: 'hours', desc: '', args: []);

  /// `day`
  String get day => Intl.message('day', name: 'day', desc: '', args: []);

  /// `days`
  String get days => Intl.message('days', name: 'days', desc: '', args: []);

  /// `days`
  String get daysGenitive => Intl.message('days', name: 'daysGenitive', desc: '', args: []);

  /// `hour`
  String get hour => Intl.message('hour', name: 'hour', desc: '', args: []);

  /// `hours`
  String get hoursPlural => Intl.message('hours', name: 'hoursPlural', desc: '', args: []);

  /// `hours`
  String get hoursGenitive => Intl.message('hours', name: 'hoursGenitive', desc: '', args: []);

  /// `Minutes`
  String get minutes => Intl.message('Minutes', name: 'minutes', desc: '', args: []);

  /// `Seconds`
  String get seconds => Intl.message('Seconds', name: 'seconds', desc: '', args: []);

  /// ` Ago`
  String get ago => Intl.message(' Ago', name: 'ago', desc: '', args: []);

  /// `Just`
  String get just => Intl.message('Just', name: 'just', desc: '', args: []);

  /// `QR code`
  String get qrcode => Intl.message('QR code', name: 'qrcode', desc: '', args: []);

  /// `Scan QR code to obtain profile`
  String get qrcodeDesc => Intl.message(
      'Scan QR code to obtain profile',
      name: 'qrcodeDesc',
      desc: '',
      args: [],
    );

  /// `URL`
  String get url => Intl.message('URL', name: 'url', desc: '', args: []);

  /// `Obtain profile through URL`
  String get urlDesc => Intl.message(
      'Obtain profile through URL',
      name: 'urlDesc',
      desc: '',
      args: [],
    );

  /// `File`
  String get file => Intl.message('File', name: 'file', desc: '', args: []);

  /// `Directly upload profile`
  String get fileDesc => Intl.message(
      'Directly upload profile',
      name: 'fileDesc',
      desc: '',
      args: [],
    );

  /// `Name`
  String get name => Intl.message('Name', name: 'name', desc: '', args: []);

  /// `Please input the profile name`
  String get profileNameNullValidationDesc => Intl.message(
      'Please input the profile name',
      name: 'profileNameNullValidationDesc',
      desc: '',
      args: [],
    );

  /// `Please input the profile URL`
  String get profileUrlNullValidationDesc => Intl.message(
      'Please input the profile URL',
      name: 'profileUrlNullValidationDesc',
      desc: '',
      args: [],
    );

  /// `Please input a valid profile URL`
  String get profileUrlInvalidValidationDesc => Intl.message(
      'Please input a valid profile URL',
      name: 'profileUrlInvalidValidationDesc',
      desc: '',
      args: [],
    );

  /// `Auto update`
  String get autoUpdate => Intl.message('Auto update', name: 'autoUpdate', desc: '', args: []);

  /// `Auto update interval (minutes)`
  String get autoUpdateInterval => Intl.message(
      'Auto update interval (minutes)',
      name: 'autoUpdateInterval',
      desc: '',
      args: [],
    );

  /// `Please enter the auto update interval time`
  String get profileAutoUpdateIntervalNullValidationDesc => Intl.message(
      'Please enter the auto update interval time',
      name: 'profileAutoUpdateIntervalNullValidationDesc',
      desc: '',
      args: [],
    );

  /// `Please input a valid interval time format`
  String get profileAutoUpdateIntervalInvalidValidationDesc => Intl.message(
      'Please input a valid interval time format',
      name: 'profileAutoUpdateIntervalInvalidValidationDesc',
      desc: '',
      args: [],
    );

  /// `Theme mode`
  String get themeMode => Intl.message('Theme mode', name: 'themeMode', desc: '', args: []);

  /// `Theme color`
  String get themeColor => Intl.message('Theme color', name: 'themeColor', desc: '', args: []);

  /// `Preview`
  String get preview => Intl.message('Preview', name: 'preview', desc: '', args: []);

  /// `Auto`
  String get auto => Intl.message('Auto', name: 'auto', desc: '', args: []);

  /// `Light`
  String get light => Intl.message('Light', name: 'light', desc: '', args: []);

  /// `Dark`
  String get dark => Intl.message('Dark', name: 'dark', desc: '', args: []);

  /// `Import from URL`
  String get importFromURL => Intl.message(
      'Import from URL',
      name: 'importFromURL',
      desc: '',
      args: [],
    );

  /// `Submit`
  String get submit => Intl.message('Submit', name: 'submit', desc: '', args: []);

  /// `Do you want to pass`
  String get doYouWantToPass => Intl.message(
      'Do you want to pass',
      name: 'doYouWantToPass',
      desc: '',
      args: [],
    );

  /// `Create`
  String get create => Intl.message('Create', name: 'create', desc: '', args: []);

  /// `Sort by default`
  String get defaultSort => Intl.message(
      'Sort by default',
      name: 'defaultSort',
      desc: '',
      args: [],
    );

  /// `Sort by delay`
  String get delaySort => Intl.message('Sort by delay', name: 'delaySort', desc: '', args: []);

  /// `Sort by name`
  String get nameSort => Intl.message('Sort by name', name: 'nameSort', desc: '', args: []);

  /// `Please upload file`
  String get pleaseUploadFile => Intl.message(
      'Please upload file',
      name: 'pleaseUploadFile',
      desc: '',
      args: [],
    );

  /// `Please upload a valid QR code`
  String get pleaseUploadValidQrcode => Intl.message(
      'Please upload a valid QR code',
      name: 'pleaseUploadValidQrcode',
      desc: '',
      args: [],
    );

  /// `Blacklist mode`
  String get blacklistMode => Intl.message(
      'Blacklist mode',
      name: 'blacklistMode',
      desc: '',
      args: [],
    );

  /// `Whitelist mode`
  String get whitelistMode => Intl.message(
      'Whitelist mode',
      name: 'whitelistMode',
      desc: '',
      args: [],
    );

  /// `Filter system app`
  String get filterSystemApp => Intl.message(
      'Filter system app',
      name: 'filterSystemApp',
      desc: '',
      args: [],
    );

  /// `Cancel filter system app`
  String get cancelFilterSystemApp => Intl.message(
      'Cancel filter system app',
      name: 'cancelFilterSystemApp',
      desc: '',
      args: [],
    );

  /// `Select all`
  String get selectAll => Intl.message('Select all', name: 'selectAll', desc: '', args: []);

  /// `Cancel select all`
  String get cancelSelectAll => Intl.message(
      'Cancel select all',
      name: 'cancelSelectAll',
      desc: '',
      args: [],
    );

  /// `App access control`
  String get appAccessControl => Intl.message(
      'App access control',
      name: 'appAccessControl',
      desc: '',
      args: [],
    );

  /// `Only allow selected app to enter VPN`
  String get accessControlAllowDesc => Intl.message(
      'Only allow selected app to enter VPN',
      name: 'accessControlAllowDesc',
      desc: '',
      args: [],
    );

  /// `The selected application will be excluded from VPN`
  String get accessControlNotAllowDesc => Intl.message(
      'The selected application will be excluded from VPN',
      name: 'accessControlNotAllowDesc',
      desc: '',
      args: [],
    );

  /// `Selected`
  String get selected => Intl.message('Selected', name: 'selected', desc: '', args: []);

  /// `unable to update current profile`
  String get unableToUpdateCurrentProfileDesc => Intl.message(
      'unable to update current profile',
      name: 'unableToUpdateCurrentProfileDesc',
      desc: '',
      args: [],
    );

  /// `No more info`
  String get noMoreInfoDesc => Intl.message(
      'No more info',
      name: 'noMoreInfoDesc',
      desc: '',
      args: [],
    );

  /// `profile parse error`
  String get profileParseErrorDesc => Intl.message(
      'profile parse error',
      name: 'profileParseErrorDesc',
      desc: '',
      args: [],
    );

  /// `ProxyPort`
  String get proxyPort => Intl.message('ProxyPort', name: 'proxyPort', desc: '', args: []);

  /// `Set the Clash listening port`
  String get proxyPortDesc => Intl.message(
      'Set the Clash listening port',
      name: 'proxyPortDesc',
      desc: '',
      args: [],
    );

  /// `Port`
  String get port => Intl.message('Port', name: 'port', desc: '', args: []);

  /// `LogLevel`
  String get logLevel => Intl.message('LogLevel', name: 'logLevel', desc: '', args: []);

  /// `Show`
  String get show => Intl.message('Show', name: 'show', desc: '', args: []);

  /// `Exit`
  String get exit => Intl.message('Exit', name: 'exit', desc: '', args: []);

  /// `System proxy`
  String get systemProxy => Intl.message(
      'System proxy',
      name: 'systemProxy',
      desc: '',
      args: [],
    );

  /// `Project`
  String get project => Intl.message('Project', name: 'project', desc: '', args: []);

  /// `Core`
  String get core => Intl.message('Core', name: 'core', desc: '', args: []);

  /// `Tab animation`
  String get tabAnimation => Intl.message(
      'Tab animation',
      name: 'tabAnimation',
      desc: '',
      args: [],
    );

  /// `A multi-platform proxy client based on ClashMeta, simple and easy to use, open-source and ad-free.`
  String get desc => Intl.message(
      'A multi-platform proxy client based on ClashMeta, simple and easy to use, open-source and ad-free.',
      name: 'desc',
      desc: '',
      args: [],
    );

  /// `Starting VPN...`
  String get startVpn => Intl.message(
      'Starting VPN...',
      name: 'startVpn',
      desc: '',
      args: [],
    );

  /// `Stopping VPN...`
  String get stopVpn => Intl.message('Stopping VPN...', name: 'stopVpn', desc: '', args: []);

  /// `Discovery a new version`
  String get discovery => Intl.message(
      'Discovery a new version',
      name: 'discovery',
      desc: '',
      args: [],
    );

  /// `Compatibility mode`
  String get compatible => Intl.message(
      'Compatibility mode',
      name: 'compatible',
      desc: '',
      args: [],
    );

  /// `Opening it will lose part of its application ability and gain the support of full amount of Clash.`
  String get compatibleDesc => Intl.message(
      'Opening it will lose part of its application ability and gain the support of full amount of Clash.',
      name: 'compatibleDesc',
      desc: '',
      args: [],
    );

  /// `The current proxy group cannot be selected.`
  String get notSelectedTip => Intl.message(
      'The current proxy group cannot be selected.',
      name: 'notSelectedTip',
      desc: '',
      args: [],
    );

  /// `tip`
  String get tip => Intl.message('tip', name: 'tip', desc: '', args: []);

  /// `Backup and Recovery`
  String get backupAndRecovery => Intl.message(
      'Backup and Recovery',
      name: 'backupAndRecovery',
      desc: '',
      args: [],
    );

  /// `Sync data via WebDAV or file`
  String get backupAndRecoveryDesc => Intl.message(
      'Sync data via WebDAV or file',
      name: 'backupAndRecoveryDesc',
      desc: '',
      args: [],
    );

  /// `Account`
  String get account => Intl.message('Account', name: 'account', desc: '', args: []);

  /// `Backup`
  String get backup => Intl.message('Backup', name: 'backup', desc: '', args: []);

  /// `Recovery`
  String get recovery => Intl.message('Recovery', name: 'recovery', desc: '', args: []);

  /// `Only recovery profiles`
  String get recoveryProfiles => Intl.message(
      'Only recovery profiles',
      name: 'recoveryProfiles',
      desc: '',
      args: [],
    );

  /// `Recovery all data`
  String get recoveryAll => Intl.message(
      'Recovery all data',
      name: 'recoveryAll',
      desc: '',
      args: [],
    );

  /// `Recovery success`
  String get recoverySuccess => Intl.message(
      'Recovery success',
      name: 'recoverySuccess',
      desc: '',
      args: [],
    );

  /// `Backup success`
  String get backupSuccess => Intl.message(
      'Backup success',
      name: 'backupSuccess',
      desc: '',
      args: [],
    );

  /// `No info`
  String get noInfo => Intl.message('No info', name: 'noInfo', desc: '', args: []);

  /// `Please bind WebDAV`
  String get pleaseBindWebDAV => Intl.message(
      'Please bind WebDAV',
      name: 'pleaseBindWebDAV',
      desc: '',
      args: [],
    );

  /// `Bind`
  String get bind => Intl.message('Bind', name: 'bind', desc: '', args: []);

  /// `Connectivity：`
  String get connectivity => Intl.message(
      'Connectivity：',
      name: 'connectivity',
      desc: '',
      args: [],
    );

  /// `WebDAV configuration`
  String get webDAVConfiguration => Intl.message(
      'WebDAV configuration',
      name: 'webDAVConfiguration',
      desc: '',
      args: [],
    );

  /// `Address`
  String get address => Intl.message('Address', name: 'address', desc: '', args: []);

  /// `WebDAV server address`
  String get addressHelp => Intl.message(
      'WebDAV server address',
      name: 'addressHelp',
      desc: '',
      args: [],
    );

  /// `Please enter a valid WebDAV address`
  String get addressTip => Intl.message(
      'Please enter a valid WebDAV address',
      name: 'addressTip',
      desc: '',
      args: [],
    );

  /// `Password`
  String get password => Intl.message('Password', name: 'password', desc: '', args: []);

  /// `Check for updates`
  String get checkUpdate => Intl.message(
      'Check for updates',
      name: 'checkUpdate',
      desc: '',
      args: [],
    );

  /// `Discover the new version`
  String get discoverNewVersion => Intl.message(
      'Discover the new version',
      name: 'discoverNewVersion',
      desc: '',
      args: [],
    );

  /// `The current application is already the latest version`
  String get checkUpdateError => Intl.message(
      'The current application is already the latest version',
      name: 'checkUpdateError',
      desc: '',
      args: [],
    );

  /// `Go to download`
  String get goDownload => Intl.message(
      'Go to download',
      name: 'goDownload',
      desc: '',
      args: [],
    );

  /// `Unknown`
  String get unknown => Intl.message('Unknown', name: 'unknown', desc: '', args: []);

  /// `GeoData`
  String get geoData => Intl.message('GeoData', name: 'geoData', desc: '', args: []);

  /// `External resources`
  String get externalResources => Intl.message(
      'External resources',
      name: 'externalResources',
      desc: '',
      args: [],
    );

  /// `Checking...`
  String get checking => Intl.message('Checking...', name: 'checking', desc: '', args: []);

  /// `Country`
  String get country => Intl.message('Country', name: 'country', desc: '', args: []);

  /// `Check error`
  String get checkError => Intl.message('Check error', name: 'checkError', desc: '', args: []);

  /// `Search`
  String get search => Intl.message('Search', name: 'search', desc: '', args: []);

  /// `Allow applications to bypass VPN`
  String get allowBypass => Intl.message(
      'Allow applications to bypass VPN',
      name: 'allowBypass',
      desc: '',
      args: [],
    );

  /// `Some apps can bypass VPN when turned on`
  String get allowBypassDesc => Intl.message(
      'Some apps can bypass VPN when turned on',
      name: 'allowBypassDesc',
      desc: '',
      args: [],
    );

  /// `ExternalController`
  String get externalController => Intl.message(
      'ExternalController',
      name: 'externalController',
      desc: '',
      args: [],
    );

  /// `Once enabled, the Clash kernel can be controlled on port 9090`
  String get externalControllerDesc => Intl.message(
      'Once enabled, the Clash kernel can be controlled on port 9090',
      name: 'externalControllerDesc',
      desc: '',
      args: [],
    );

  /// `When turned on it will be able to receive IPv6 traffic`
  String get ipv6Desc => Intl.message(
      'When turned on it will be able to receive IPv6 traffic',
      name: 'ipv6Desc',
      desc: '',
      args: [],
    );

  /// `App`
  String get app => Intl.message('App', name: 'app', desc: '', args: []);

  /// `General`
  String get general => Intl.message('General', name: 'general', desc: '', args: []);

  /// `Attach HTTP proxy to VpnService`
  String get vpnSystemProxyDesc => Intl.message(
      'Attach HTTP proxy to VpnService',
      name: 'vpnSystemProxyDesc',
      desc: '',
      args: [],
    );

  /// `Attach HTTP proxy to VpnService`
  String get systemProxyDesc => Intl.message(
      'Attach HTTP proxy to VpnService',
      name: 'systemProxyDesc',
      desc: '',
      args: [],
    );

  /// `Unified delay`
  String get unifiedDelay => Intl.message(
      'Unified delay',
      name: 'unifiedDelay',
      desc: '',
      args: [],
    );

  /// `Remove extra delays such as handshaking`
  String get unifiedDelayDesc => Intl.message(
      'Remove extra delays such as handshaking',
      name: 'unifiedDelayDesc',
      desc: '',
      args: [],
    );

  /// `TCP concurrent`
  String get tcpConcurrent => Intl.message(
      'TCP concurrent',
      name: 'tcpConcurrent',
      desc: '',
      args: [],
    );

  /// `Enabling it will allow TCP concurrency`
  String get tcpConcurrentDesc => Intl.message(
      'Enabling it will allow TCP concurrency',
      name: 'tcpConcurrentDesc',
      desc: '',
      args: [],
    );

  /// `Geo Low Memory Mode`
  String get geodataLoader => Intl.message(
      'Geo Low Memory Mode',
      name: 'geodataLoader',
      desc: '',
      args: [],
    );

  /// `Enabling will use the Geo low memory loader`
  String get geodataLoaderDesc => Intl.message(
      'Enabling will use the Geo low memory loader',
      name: 'geodataLoaderDesc',
      desc: '',
      args: [],
    );

  /// `Requests`
  String get requests => Intl.message('Requests', name: 'requests', desc: '', args: []);

  /// `View recently request records`
  String get requestsDesc => Intl.message(
      'View recently request records',
      name: 'requestsDesc',
      desc: '',
      args: [],
    );

  /// `Find process`
  String get findProcessMode => Intl.message(
      'Find process',
      name: 'findProcessMode',
      desc: '',
      args: [],
    );

  /// `Init`
  String get init => Intl.message('Init', name: 'init', desc: '', args: []);

  /// `Long term effective`
  String get infiniteTime => Intl.message(
      'Long term effective',
      name: 'infiniteTime',
      desc: '',
      args: [],
    );

  /// `Expiration time`
  String get expirationTime => Intl.message(
      'Expiration time',
      name: 'expirationTime',
      desc: '',
      args: [],
    );

  /// `Connections`
  String get connections => Intl.message('Connections', name: 'connections', desc: '', args: []);

  /// `View current connections data`
  String get connectionsDesc => Intl.message(
      'View current connections data',
      name: 'connectionsDesc',
      desc: '',
      args: [],
    );

  /// `Intranet IP`
  String get intranetIP => Intl.message('Intranet IP', name: 'intranetIP', desc: '', args: []);

  /// `View`
  String get view => Intl.message('View', name: 'view', desc: '', args: []);

  /// `Cut`
  String get cut => Intl.message('Cut', name: 'cut', desc: '', args: []);

  /// `Copy`
  String get copy => Intl.message('Copy', name: 'copy', desc: '', args: []);

  /// `Paste`
  String get paste => Intl.message('Paste', name: 'paste', desc: '', args: []);

  /// `Test url`
  String get testUrl => Intl.message('Test url', name: 'testUrl', desc: '', args: []);

  /// `Sync`
  String get sync => Intl.message('Sync', name: 'sync', desc: '', args: []);

  /// `Hidden from recent tasks`
  String get exclude => Intl.message(
      'Hidden from recent tasks',
      name: 'exclude',
      desc: '',
      args: [],
    );

  /// `When the app is in the background, the app is hidden from the recent task`
  String get excludeDesc => Intl.message(
      'When the app is in the background, the app is hidden from the recent task',
      name: 'excludeDesc',
      desc: '',
      args: [],
    );

  /// `One column`
  String get oneColumn => Intl.message('One column', name: 'oneColumn', desc: '', args: []);

  /// `Two columns`
  String get twoColumns => Intl.message('Two columns', name: 'twoColumns', desc: '', args: []);

  /// `Three columns`
  String get threeColumns => Intl.message(
      'Three columns',
      name: 'threeColumns',
      desc: '',
      args: [],
    );

  /// `Four columns`
  String get fourColumns => Intl.message(
      'Four columns',
      name: 'fourColumns',
      desc: '',
      args: [],
    );

  /// `Standard`
  String get expand => Intl.message('Standard', name: 'expand', desc: '', args: []);

  /// `Shrink`
  String get shrink => Intl.message('Shrink', name: 'shrink', desc: '', args: []);

  /// `Min`
  String get min => Intl.message('Min', name: 'min', desc: '', args: []);

  /// `Oneline`
  String get oneline => Intl.message('Oneline', name: 'oneline', desc: '', args: []);

  /// `Tab`
  String get tab => Intl.message('Tab', name: 'tab', desc: '', args: []);

  /// `List`
  String get list => Intl.message('List', name: 'list', desc: '', args: []);

  /// `Delay`
  String get delay => Intl.message('Delay', name: 'delay', desc: '', args: []);

  /// `Style`
  String get style => Intl.message('Style', name: 'style', desc: '', args: []);

  /// `Size`
  String get size => Intl.message('Size', name: 'size', desc: '', args: []);

  /// `Sort`
  String get sort => Intl.message('Sort', name: 'sort', desc: '', args: []);

  /// `Columns`
  String get columns => Intl.message('Columns', name: 'columns', desc: '', args: []);

  /// `Proxies setting`
  String get proxiesSetting => Intl.message(
      'Proxies setting',
      name: 'proxiesSetting',
      desc: '',
      args: [],
    );

  /// `Proxy group`
  String get proxyGroup => Intl.message('Proxy group', name: 'proxyGroup', desc: '', args: []);

  /// `Go`
  String get go => Intl.message('Go', name: 'go', desc: '', args: []);

  /// `External link`
  String get externalLink => Intl.message(
      'External link',
      name: 'externalLink',
      desc: '',
      args: [],
    );

  /// `Contributors`
  String get otherContributors => Intl.message(
      'Contributors',
      name: 'otherContributors',
      desc: '',
      args: [],
    );

  /// `Auto close connections`
  String get autoCloseConnections => Intl.message(
      'Auto close connections',
      name: 'autoCloseConnections',
      desc: '',
      args: [],
    );

  /// `Auto close connections after change node`
  String get autoCloseConnectionsDesc => Intl.message(
      'Auto close connections after change node',
      name: 'autoCloseConnectionsDesc',
      desc: '',
      args: [],
    );

  /// `Only statistics proxy`
  String get onlyStatisticsProxy => Intl.message(
      'Only statistics proxy',
      name: 'onlyStatisticsProxy',
      desc: '',
      args: [],
    );

  /// `When turned on, only statistics proxy traffic`
  String get onlyStatisticsProxyDesc => Intl.message(
      'When turned on, only statistics proxy traffic',
      name: 'onlyStatisticsProxyDesc',
      desc: '',
      args: [],
    );

  /// `Pure black mode`
  String get pureBlackMode => Intl.message(
      'Pure black mode',
      name: 'pureBlackMode',
      desc: '',
      args: [],
    );

  /// `Tcp keep alive interval`
  String get keepAliveIntervalDesc => Intl.message(
      'Tcp keep alive interval',
      name: 'keepAliveIntervalDesc',
      desc: '',
      args: [],
    );

  /// ` entries`
  String get entries => Intl.message(' entries', name: 'entries', desc: '', args: []);

  /// `Local`
  String get local => Intl.message('Local', name: 'local', desc: '', args: []);

  /// `Remote`
  String get remote => Intl.message('Remote', name: 'remote', desc: '', args: []);

  /// `Backup local data to WebDAV`
  String get remoteBackupDesc => Intl.message(
      'Backup local data to WebDAV',
      name: 'remoteBackupDesc',
      desc: '',
      args: [],
    );

  /// `Recovery data from WebDAV`
  String get remoteRecoveryDesc => Intl.message(
      'Recovery data from WebDAV',
      name: 'remoteRecoveryDesc',
      desc: '',
      args: [],
    );

  /// `Backup local data to local`
  String get localBackupDesc => Intl.message(
      'Backup local data to local',
      name: 'localBackupDesc',
      desc: '',
      args: [],
    );

  /// `Recovery data from file`
  String get localRecoveryDesc => Intl.message(
      'Recovery data from file',
      name: 'localRecoveryDesc',
      desc: '',
      args: [],
    );

  /// `Mode`
  String get mode => Intl.message('Mode', name: 'mode', desc: '', args: []);

  /// `Time`
  String get time => Intl.message('Time', name: 'time', desc: '', args: []);

  /// `Source`
  String get source => Intl.message('Source', name: 'source', desc: '', args: []);

  /// `All apps`
  String get allApps => Intl.message('All apps', name: 'allApps', desc: '', args: []);

  /// `Only third-party apps`
  String get onlyOtherApps => Intl.message(
      'Only third-party apps',
      name: 'onlyOtherApps',
      desc: '',
      args: [],
    );

  /// `Action`
  String get action => Intl.message('Action', name: 'action', desc: '', args: []);

  /// `Intelligent selection`
  String get intelligentSelected => Intl.message(
      'Intelligent selection',
      name: 'intelligentSelected',
      desc: '',
      args: [],
    );

  /// `Clipboard import`
  String get clipboardImport => Intl.message(
      'Clipboard import',
      name: 'clipboardImport',
      desc: '',
      args: [],
    );

  /// `Export clipboard`
  String get clipboardExport => Intl.message(
      'Export clipboard',
      name: 'clipboardExport',
      desc: '',
      args: [],
    );

  /// `Layout`
  String get layout => Intl.message('Layout', name: 'layout', desc: '', args: []);

  /// `Tight`
  String get tight => Intl.message('Tight', name: 'tight', desc: '', args: []);

  /// `Standard`
  String get standard => Intl.message('Standard', name: 'standard', desc: '', args: []);

  /// `Loose`
  String get loose => Intl.message('Loose', name: 'loose', desc: '', args: []);

  /// `Profiles sort`
  String get profilesSort => Intl.message(
      'Profiles sort',
      name: 'profilesSort',
      desc: '',
      args: [],
    );

  /// `Start`
  String get start => Intl.message('Start', name: 'start', desc: '', args: []);

  /// `Stop`
  String get stop => Intl.message('Stop', name: 'stop', desc: '', args: []);

  /// `Processing app related settings`
  String get appDesc => Intl.message(
      'Processing app related settings',
      name: 'appDesc',
      desc: '',
      args: [],
    );

  /// `Modify VPN related settings`
  String get vpnDesc => Intl.message(
      'Modify VPN related settings',
      name: 'vpnDesc',
      desc: '',
      args: [],
    );

  /// `Update DNS related settings`
  String get dnsDesc => Intl.message(
      'Update DNS related settings',
      name: 'dnsDesc',
      desc: '',
      args: [],
    );

  /// `Key`
  String get key => Intl.message('Key', name: 'key', desc: '', args: []);

  /// `Value`
  String get value => Intl.message('Value', name: 'value', desc: '', args: []);

  /// `Add Hosts`
  String get hostsDesc => Intl.message('Add Hosts', name: 'hostsDesc', desc: '', args: []);

  /// `Changes take effect after restarting the VPN`
  String get vpnTip => Intl.message(
      'Changes take effect after restarting the VPN',
      name: 'vpnTip',
      desc: '',
      args: [],
    );

  /// `Auto routes all system traffic through VpnService`
  String get vpnEnableDesc => Intl.message(
      'Auto routes all system traffic through VpnService',
      name: 'vpnEnableDesc',
      desc: '',
      args: [],
    );

  /// `Options`
  String get options => Intl.message('Options', name: 'options', desc: '', args: []);

  /// `Loopback unlock tool`
  String get loopback => Intl.message(
      'Loopback unlock tool',
      name: 'loopback',
      desc: '',
      args: [],
    );

  /// `Used for UWP loopback unlocking`
  String get loopbackDesc => Intl.message(
      'Used for UWP loopback unlocking',
      name: 'loopbackDesc',
      desc: '',
      args: [],
    );

  /// `Providers`
  String get providers => Intl.message('Providers', name: 'providers', desc: '', args: []);

  /// `Proxy providers`
  String get proxyProviders => Intl.message(
      'Proxy providers',
      name: 'proxyProviders',
      desc: '',
      args: [],
    );

  /// `Rule providers`
  String get ruleProviders => Intl.message(
      'Rule providers',
      name: 'ruleProviders',
      desc: '',
      args: [],
    );

  /// `Override Dns`
  String get overrideDns => Intl.message(
      'Override Dns',
      name: 'overrideDns',
      desc: '',
      args: [],
    );

  /// `Turning it on will override the DNS options in the profile`
  String get overrideDnsDesc => Intl.message(
      'Turning it on will override the DNS options in the profile',
      name: 'overrideDnsDesc',
      desc: '',
      args: [],
    );

  /// `Status`
  String get status => Intl.message('Status', name: 'status', desc: '', args: []);

  /// `System DNS will be used when turned off`
  String get statusDesc => Intl.message(
      'System DNS will be used when turned off',
      name: 'statusDesc',
      desc: '',
      args: [],
    );

  /// `Prioritize the use of DOH's http/3`
  String get preferH3Desc => Intl.message(
      'Prioritize the use of DOH\'s http/3',
      name: 'preferH3Desc',
      desc: '',
      args: [],
    );

  /// `Respect rules`
  String get respectRules => Intl.message(
      'Respect rules',
      name: 'respectRules',
      desc: '',
      args: [],
    );

  /// `DNS connection following rules, need to configure proxy-server-nameserver`
  String get respectRulesDesc => Intl.message(
      'DNS connection following rules, need to configure proxy-server-nameserver',
      name: 'respectRulesDesc',
      desc: '',
      args: [],
    );

  /// `DNS mode`
  String get dnsMode => Intl.message('DNS mode', name: 'dnsMode', desc: '', args: []);

  /// `Fakeip range`
  String get fakeipRange => Intl.message(
      'Fakeip range',
      name: 'fakeipRange',
      desc: '',
      args: [],
    );

  /// `Fakeip filter`
  String get fakeipFilter => Intl.message(
      'Fakeip filter',
      name: 'fakeipFilter',
      desc: '',
      args: [],
    );

  /// `Default nameserver`
  String get defaultNameserver => Intl.message(
      'Default nameserver',
      name: 'defaultNameserver',
      desc: '',
      args: [],
    );

  /// `For resolving DNS server`
  String get defaultNameserverDesc => Intl.message(
      'For resolving DNS server',
      name: 'defaultNameserverDesc',
      desc: '',
      args: [],
    );

  /// `Nameserver`
  String get nameserver => Intl.message('Nameserver', name: 'nameserver', desc: '', args: []);

  /// `For resolving domain`
  String get nameserverDesc => Intl.message(
      'For resolving domain',
      name: 'nameserverDesc',
      desc: '',
      args: [],
    );

  /// `Use hosts`
  String get useHosts => Intl.message('Use hosts', name: 'useHosts', desc: '', args: []);

  /// `Use system hosts`
  String get useSystemHosts => Intl.message(
      'Use system hosts',
      name: 'useSystemHosts',
      desc: '',
      args: [],
    );

  /// `Nameserver policy`
  String get nameserverPolicy => Intl.message(
      'Nameserver policy',
      name: 'nameserverPolicy',
      desc: '',
      args: [],
    );

  /// `Specify the corresponding nameserver policy`
  String get nameserverPolicyDesc => Intl.message(
      'Specify the corresponding nameserver policy',
      name: 'nameserverPolicyDesc',
      desc: '',
      args: [],
    );

  /// `Proxy nameserver`
  String get proxyNameserver => Intl.message(
      'Proxy nameserver',
      name: 'proxyNameserver',
      desc: '',
      args: [],
    );

  /// `Domain for resolving proxy nodes`
  String get proxyNameserverDesc => Intl.message(
      'Domain for resolving proxy nodes',
      name: 'proxyNameserverDesc',
      desc: '',
      args: [],
    );

  /// `Fallback`
  String get fallback => Intl.message('Fallback', name: 'fallback', desc: '', args: []);

  /// `Generally use offshore DNS`
  String get fallbackDesc => Intl.message(
      'Generally use offshore DNS',
      name: 'fallbackDesc',
      desc: '',
      args: [],
    );

  /// `Fallback filter`
  String get fallbackFilter => Intl.message(
      'Fallback filter',
      name: 'fallbackFilter',
      desc: '',
      args: [],
    );

  /// `Geoip code`
  String get geoipCode => Intl.message('Geoip code', name: 'geoipCode', desc: '', args: []);

  /// `Ipcidr`
  String get ipcidr => Intl.message('Ipcidr', name: 'ipcidr', desc: '', args: []);

  /// `Domain`
  String get domain => Intl.message('Domain', name: 'domain', desc: '', args: []);

  /// `Reset`
  String get reset => Intl.message('Reset', name: 'reset', desc: '', args: []);

  /// `Show/Hide`
  String get action_view => Intl.message('Show/Hide', name: 'action_view', desc: '', args: []);

  /// `Start/Stop`
  String get action_start => Intl.message('Start/Stop', name: 'action_start', desc: '', args: []);

  /// `Switch mode`
  String get action_mode => Intl.message('Switch mode', name: 'action_mode', desc: '', args: []);

  /// `System proxy`
  String get action_proxy => Intl.message(
      'System proxy',
      name: 'action_proxy',
      desc: '',
      args: [],
    );

  /// `TUN`
  String get action_tun => Intl.message('TUN', name: 'action_tun', desc: '', args: []);

  /// `Disclaimer`
  String get disclaimer => Intl.message('Disclaimer', name: 'disclaimer', desc: '', args: []);

  /// `This software is only used for non-commercial purposes such as learning exchanges and scientific research. It is strictly prohibited to use this software for commercial purposes. Any commercial activity, if any, has nothing to do with this software.`
  String get disclaimerDesc => Intl.message(
      'This software is only used for non-commercial purposes such as learning exchanges and scientific research. It is strictly prohibited to use this software for commercial purposes. Any commercial activity, if any, has nothing to do with this software.',
      name: 'disclaimerDesc',
      desc: '',
      args: [],
    );

  /// `Agree`
  String get agree => Intl.message('Agree', name: 'agree', desc: '', args: []);

  /// `Hotkey Management`
  String get hotkeyManagement => Intl.message(
      'Hotkey Management',
      name: 'hotkeyManagement',
      desc: '',
      args: [],
    );

  /// `Use keyboard to control applications`
  String get hotkeyManagementDesc => Intl.message(
      'Use keyboard to control applications',
      name: 'hotkeyManagementDesc',
      desc: '',
      args: [],
    );

  /// `Please press the keyboard.`
  String get pressKeyboard => Intl.message(
      'Please press the keyboard.',
      name: 'pressKeyboard',
      desc: '',
      args: [],
    );

  /// `Please enter the correct hotkey`
  String get inputCorrectHotkey => Intl.message(
      'Please enter the correct hotkey',
      name: 'inputCorrectHotkey',
      desc: '',
      args: [],
    );

  /// `Hotkey conflict`
  String get hotkeyConflict => Intl.message(
      'Hotkey conflict',
      name: 'hotkeyConflict',
      desc: '',
      args: [],
    );

  /// `Remove`
  String get remove => Intl.message('Remove', name: 'remove', desc: '', args: []);

  /// `No HotKey`
  String get noHotKey => Intl.message('No HotKey', name: 'noHotKey', desc: '', args: []);

  /// `No network`
  String get noNetwork => Intl.message('No network', name: 'noNetwork', desc: '', args: []);

  /// `Allow IPv6 inbound`
  String get ipv6InboundDesc => Intl.message(
      'Allow IPv6 inbound',
      name: 'ipv6InboundDesc',
      desc: '',
      args: [],
    );

  /// `Export logs`
  String get exportLogs => Intl.message('Export logs', name: 'exportLogs', desc: '', args: []);

  /// `Export Success`
  String get exportSuccess => Intl.message(
      'Export Success',
      name: 'exportSuccess',
      desc: '',
      args: [],
    );

  /// `Icon style`
  String get iconStyle => Intl.message('Icon style', name: 'iconStyle', desc: '', args: []);

  /// `Icon`
  String get onlyIcon => Intl.message('Icon', name: 'onlyIcon', desc: '', args: []);

  /// `None`
  String get noIcon => Intl.message('None', name: 'noIcon', desc: '', args: []);

  /// `Stack mode`
  String get stackMode => Intl.message('Stack mode', name: 'stackMode', desc: '', args: []);

  /// `Network`
  String get network => Intl.message('Network', name: 'network', desc: '', args: []);

  /// `Modify network-related settings`
  String get networkDesc => Intl.message(
      'Modify network-related settings',
      name: 'networkDesc',
      desc: '',
      args: [],
    );

  /// `Bypass domain`
  String get bypassDomain => Intl.message(
      'Bypass domain',
      name: 'bypassDomain',
      desc: '',
      args: [],
    );

  /// `Only takes effect when the system proxy is enabled`
  String get bypassDomainDesc => Intl.message(
      'Only takes effect when the system proxy is enabled',
      name: 'bypassDomainDesc',
      desc: '',
      args: [],
    );

  /// `Make sure to reset`
  String get resetTip => Intl.message(
      'Make sure to reset',
      name: 'resetTip',
      desc: '',
      args: [],
    );

  /// `RegExp`
  String get regExp => Intl.message('RegExp', name: 'regExp', desc: '', args: []);

  /// `Icon`
  String get icon => Intl.message('Icon', name: 'icon', desc: '', args: []);

  /// `Icon configuration`
  String get iconConfiguration => Intl.message(
      'Icon configuration',
      name: 'iconConfiguration',
      desc: '',
      args: [],
    );

  /// `No data`
  String get noData => Intl.message('No data', name: 'noData', desc: '', args: []);

  /// `Admin auto launch`
  String get adminAutoLaunch => Intl.message(
      'Admin auto launch',
      name: 'adminAutoLaunch',
      desc: '',
      args: [],
    );

  /// `Boot up by using admin mode`
  String get adminAutoLaunchDesc => Intl.message(
      'Boot up by using admin mode',
      name: 'adminAutoLaunchDesc',
      desc: '',
      args: [],
    );

  /// `FontFamily`
  String get fontFamily => Intl.message('FontFamily', name: 'fontFamily', desc: '', args: []);

  /// `System font`
  String get systemFont => Intl.message('System font', name: 'systemFont', desc: '', args: []);

  /// `Toggle`
  String get toggle => Intl.message('Toggle', name: 'toggle', desc: '', args: []);

  /// `System`
  String get system => Intl.message('System', name: 'system', desc: '', args: []);

  /// `Route mode`
  String get routeMode => Intl.message('Route mode', name: 'routeMode', desc: '', args: []);

  /// `Bypass private route address`
  String get routeMode_bypassPrivate => Intl.message(
      'Bypass private route address',
      name: 'routeMode_bypassPrivate',
      desc: '',
      args: [],
    );

  /// `Use config`
  String get routeMode_config => Intl.message(
      'Use config',
      name: 'routeMode_config',
      desc: '',
      args: [],
    );

  /// `Route address`
  String get routeAddress => Intl.message(
      'Route address',
      name: 'routeAddress',
      desc: '',
      args: [],
    );

  /// `Config listen route address`
  String get routeAddressDesc => Intl.message(
      'Config listen route address',
      name: 'routeAddressDesc',
      desc: '',
      args: [],
    );

  /// `Please enter the admin password`
  String get pleaseInputAdminPassword => Intl.message(
      'Please enter the admin password',
      name: 'pleaseInputAdminPassword',
      desc: '',
      args: [],
    );

  /// `Copying environment variables`
  String get copyEnvVar => Intl.message(
      'Copying environment variables',
      name: 'copyEnvVar',
      desc: '',
      args: [],
    );

  /// `Memory info`
  String get memoryInfo => Intl.message('Memory info', name: 'memoryInfo', desc: '', args: []);

  /// `Cancel`
  String get cancel => Intl.message('Cancel', name: 'cancel', desc: '', args: []);

  /// `The file has been modified. Do you want to save the changes?`
  String get fileIsUpdate => Intl.message(
      'The file has been modified. Do you want to save the changes?',
      name: 'fileIsUpdate',
      desc: '',
      args: [],
    );

  /// `The profile has been modified. Do you want to disable auto update?`
  String get profileHasUpdate => Intl.message(
      'The profile has been modified. Do you want to disable auto update?',
      name: 'profileHasUpdate',
      desc: '',
      args: [],
    );

  /// `Do you want to cache the changes?`
  String get hasCacheChange => Intl.message(
      'Do you want to cache the changes?',
      name: 'hasCacheChange',
      desc: '',
      args: [],
    );

  /// `Copy success`
  String get copySuccess => Intl.message(
      'Copy success',
      name: 'copySuccess',
      desc: '',
      args: [],
    );

  /// `Copy link`
  String get copyLink => Intl.message('Copy link', name: 'copyLink', desc: '', args: []);

  /// `Export file`
  String get exportFile => Intl.message('Export file', name: 'exportFile', desc: '', args: []);

  /// `The cache is corrupt. Do you want to clear it?`
  String get cacheCorrupt => Intl.message(
      'The cache is corrupt. Do you want to clear it?',
      name: 'cacheCorrupt',
      desc: '',
      args: [],
    );

  /// `Relying on third-party api is for reference only`
  String get detectionTip => Intl.message(
      'Relying on third-party api is for reference only',
      name: 'detectionTip',
      desc: '',
      args: [],
    );

  /// `Listen`
  String get listen => Intl.message('Listen', name: 'listen', desc: '', args: []);

  /// `undo`
  String get undo => Intl.message('undo', name: 'undo', desc: '', args: []);

  /// `redo`
  String get redo => Intl.message('redo', name: 'redo', desc: '', args: []);

  /// `none`
  String get none => Intl.message('none', name: 'none', desc: '', args: []);

  /// `Basic configuration`
  String get basicConfig => Intl.message(
      'Basic configuration',
      name: 'basicConfig',
      desc: '',
      args: [],
    );

  /// `Modify the basic configuration globally`
  String get basicConfigDesc => Intl.message(
      'Modify the basic configuration globally',
      name: 'basicConfigDesc',
      desc: '',
      args: [],
    );

  /// `{count} items have been selected`
  String selectedCountTitle(Object count) => Intl.message(
      '$count items have been selected',
      name: 'selectedCountTitle',
      desc: '',
      args: [count],
    );

  /// `Add rule`
  String get addRule => Intl.message('Add rule', name: 'addRule', desc: '', args: []);

  /// `Rule name`
  String get ruleName => Intl.message('Rule name', name: 'ruleName', desc: '', args: []);

  /// `Content`
  String get content => Intl.message('Content', name: 'content', desc: '', args: []);

  /// `Sub rule`
  String get subRule => Intl.message('Sub rule', name: 'subRule', desc: '', args: []);

  /// `Rule target`
  String get ruleTarget => Intl.message('Rule target', name: 'ruleTarget', desc: '', args: []);

  /// `Source IP`
  String get sourceIp => Intl.message('Source IP', name: 'sourceIp', desc: '', args: []);

  /// `No resolve IP`
  String get noResolve => Intl.message('No resolve IP', name: 'noResolve', desc: '', args: []);

  /// `Get original rules`
  String get getOriginRules => Intl.message(
      'Get original rules',
      name: 'getOriginRules',
      desc: '',
      args: [],
    );

  /// `Override the original rule`
  String get overrideOriginRules => Intl.message(
      'Override the original rule',
      name: 'overrideOriginRules',
      desc: '',
      args: [],
    );

  /// `Attach on the original rules`
  String get addedOriginRules => Intl.message(
      'Attach on the original rules',
      name: 'addedOriginRules',
      desc: '',
      args: [],
    );

  /// `Enable override`
  String get enableOverride => Intl.message(
      'Enable override',
      name: 'enableOverride',
      desc: '',
      args: [],
    );

  /// `Do you want to save the changes?`
  String get saveChanges => Intl.message(
      'Do you want to save the changes?',
      name: 'saveChanges',
      desc: '',
      args: [],
    );

  /// `Modify general settings`
  String get generalDesc => Intl.message(
      'Modify general settings',
      name: 'generalDesc',
      desc: '',
      args: [],
    );

  /// `There is a certain performance loss after opening`
  String get findProcessModeDesc => Intl.message(
      'There is a certain performance loss after opening',
      name: 'findProcessModeDesc',
      desc: '',
      args: [],
    );

  /// `Effective only in mobile view`
  String get tabAnimationDesc => Intl.message(
      'Effective only in mobile view',
      name: 'tabAnimationDesc',
      desc: '',
      args: [],
    );

  /// `Are you sure you want to save?`
  String get saveTip => Intl.message(
      'Are you sure you want to save?',
      name: 'saveTip',
      desc: '',
      args: [],
    );

  /// `Color schemes`
  String get colorSchemes => Intl.message(
      'Color schemes',
      name: 'colorSchemes',
      desc: '',
      args: [],
    );

  /// `Palette`
  String get palette => Intl.message('Palette', name: 'palette', desc: '', args: []);

  /// `TonalSpot`
  String get tonalSpotScheme => Intl.message(
      'TonalSpot',
      name: 'tonalSpotScheme',
      desc: '',
      args: [],
    );

  /// `Fidelity`
  String get fidelityScheme => Intl.message('Fidelity', name: 'fidelityScheme', desc: '', args: []);

  /// `Monochrome`
  String get monochromeScheme => Intl.message(
      'Monochrome',
      name: 'monochromeScheme',
      desc: '',
      args: [],
    );

  /// `Neutral`
  String get neutralScheme => Intl.message('Neutral', name: 'neutralScheme', desc: '', args: []);

  /// `Vibrant`
  String get vibrantScheme => Intl.message('Vibrant', name: 'vibrantScheme', desc: '', args: []);

  /// `Expressive`
  String get expressiveScheme => Intl.message(
      'Expressive',
      name: 'expressiveScheme',
      desc: '',
      args: [],
    );

  /// `Content`
  String get contentScheme => Intl.message('Content', name: 'contentScheme', desc: '', args: []);

  /// `Rainbow`
  String get rainbowScheme => Intl.message('Rainbow', name: 'rainbowScheme', desc: '', args: []);

  /// `FruitSalad`
  String get fruitSaladScheme => Intl.message(
      'FruitSalad',
      name: 'fruitSaladScheme',
      desc: '',
      args: [],
    );

  /// `Developer mode`
  String get developerMode => Intl.message(
      'Developer mode',
      name: 'developerMode',
      desc: '',
      args: [],
    );

  /// `Developer mode is enabled.`
  String get developerModeEnableTip => Intl.message(
      'Developer mode is enabled.',
      name: 'developerModeEnableTip',
      desc: '',
      args: [],
    );

  /// `Message test`
  String get messageTest => Intl.message(
      'Message test',
      name: 'messageTest',
      desc: '',
      args: [],
    );

  /// `This is a message.`
  String get messageTestTip => Intl.message(
      'This is a message.',
      name: 'messageTestTip',
      desc: '',
      args: [],
    );

  /// `Crash test`
  String get crashTest => Intl.message('Crash test', name: 'crashTest', desc: '', args: []);

  /// `Clear Data`
  String get clearData => Intl.message('Clear Data', name: 'clearData', desc: '', args: []);

  String get clearDataTip => Intl.message('This will delete all app data and restart the application. Are you sure?', name: 'clearDataTip', desc: '', args: []);

  /// `Text Scaling`
  String get textScale => Intl.message('Text Scaling', name: 'textScale', desc: '', args: []);

  /// `Internet`
  String get internet => Intl.message('Internet', name: 'internet', desc: '', args: []);

  /// `System APP`
  String get systemApp => Intl.message('System APP', name: 'systemApp', desc: '', args: []);

  /// `No network APP`
  String get noNetworkApp => Intl.message(
      'No network APP',
      name: 'noNetworkApp',
      desc: '',
      args: [],
    );

  /// `Contact me`
  String get contactMe => Intl.message('Contact me', name: 'contactMe', desc: '', args: []);

  /// `Recovery strategy`
  String get recoveryStrategy => Intl.message(
      'Recovery strategy',
      name: 'recoveryStrategy',
      desc: '',
      args: [],
    );

  /// `Override`
  String get recoveryStrategy_override => Intl.message(
      'Override',
      name: 'recoveryStrategy_override',
      desc: '',
      args: [],
    );

  /// `Compatible`
  String get recoveryStrategy_compatible => Intl.message(
      'Compatible',
      name: 'recoveryStrategy_compatible',
      desc: '',
      args: [],
    );

  /// `Logs test`
  String get logsTest => Intl.message('Logs test', name: 'logsTest', desc: '', args: []);

  /// `{label} cannot be empty`
  String emptyTip(Object label) => Intl.message(
      '$label cannot be empty',
      name: 'emptyTip',
      desc: '',
      args: [label],
    );

  /// `{label} must be a url`
  String urlTip(Object label) => Intl.message(
      '$label must be a url',
      name: 'urlTip',
      desc: '',
      args: [label],
    );

  /// `{label} must be a number`
  String numberTip(Object label) => Intl.message(
      '$label must be a number',
      name: 'numberTip',
      desc: '',
      args: [label],
    );

  /// `Interval`
  String get interval => Intl.message('Interval', name: 'interval', desc: '', args: []);

  /// `Current {label} already exists`
  String existsTip(Object label) => Intl.message(
      'Current $label already exists',
      name: 'existsTip',
      desc: '',
      args: [label],
    );

  /// `Are you sure you want to delete the current {label}?`
  String deleteTip(Object label) => Intl.message(
      'Are you sure you want to delete the current $label?',
      name: 'deleteTip',
      desc: '',
      args: [label],
    );

  /// `Are you sure you want to delete the selected {label}?`
  String deleteMultipTip(Object label) => Intl.message(
      'Are you sure you want to delete the selected $label?',
      name: 'deleteMultipTip',
      desc: '',
      args: [label],
    );

  /// `No {label} at the moment`
  String nullTip(Object label) => Intl.message(
      'No $label at the moment',
      name: 'nullTip',
      desc: '',
      args: [label],
    );

  /// `No scripts`
  String get nullScriptTip => Intl.message(
      'No scripts',
      name: 'nullScriptTip',
      desc: '',
      args: [],
    );

  /// `Script`
  String get script => Intl.message('Script', name: 'script', desc: '', args: []);

  /// `Color`
  String get color => Intl.message('Color', name: 'color', desc: '', args: []);

  /// `Rename`
  String get rename => Intl.message('Rename', name: 'rename', desc: '', args: []);

  /// `Unnamed`
  String get unnamed => Intl.message('Unnamed', name: 'unnamed', desc: '', args: []);

  /// `Please enter a script name`
  String get pleaseEnterScriptName => Intl.message(
      'Please enter a script name',
      name: 'pleaseEnterScriptName',
      desc: '',
      args: [],
    );

  /// `Does not take effect in script mode`
  String get overrideInvalidTip => Intl.message(
      'Does not take effect in script mode',
      name: 'overrideInvalidTip',
      desc: '',
      args: [],
    );

  /// `Mixed Port`
  String get mixedPort => Intl.message('Mixed Port', name: 'mixedPort', desc: '', args: []);

  /// `Socks Port`
  String get socksPort => Intl.message('Socks Port', name: 'socksPort', desc: '', args: []);

  /// `Redir Port`
  String get redirPort => Intl.message('Redir Port', name: 'redirPort', desc: '', args: []);

  /// `Tproxy Port`
  String get tproxyPort => Intl.message('Tproxy Port', name: 'tproxyPort', desc: '', args: []);

  /// `{label} must be between 1024 and 49151`
  String portTip(Object label) => Intl.message(
      '$label must be between 1024 and 49151',
      name: 'portTip',
      desc: '',
      args: [label],
    );

  /// `Please enter a different port`
  String get portConflictTip => Intl.message(
      'Please enter a different port',
      name: 'portConflictTip',
      desc: '',
      args: [],
    );

  /// `Import`
  String get import => Intl.message('Import', name: 'import', desc: '', args: []);

  /// `Import from file`
  String get importFile => Intl.message(
      'Import from file',
      name: 'importFile',
      desc: '',
      args: [],
    );

  /// `Import from URL`
  String get importUrl => Intl.message(
      'Import from URL',
      name: 'importUrl',
      desc: '',
      args: [],
    );

  /// `Auto set system DNS`
  String get autoSetSystemDns => Intl.message(
      'Auto set system DNS',
      name: 'autoSetSystemDns',
      desc: '',
      args: [],
    );

  /// `Change Server`
  String get changeServer => Intl.message(
      'Change Server',
      name: 'changeServer',
      desc: '',
      args: [],
    );

  /// `Add Profile`
  String get addProfile => Intl.message('Add Profile', name: 'addProfile', desc: '', args: []);

  /// `Traffic`
  String get traffic => Intl.message('Traffic', name: 'traffic', desc: '', args: []);

  /// `Unlimited Traffic`
  String get trafficUnlimited => Intl.message(
      'Unlimited Traffic',
      name: 'trafficUnlimited',
      desc: '',
      args: [],
    );

  /// `Lifetime Subscription`
  String get subscriptionEternal => Intl.message(
      'Lifetime Subscription',
      name: 'subscriptionEternal',
      desc: '',
      args: [],
    );

  /// `Expires on`
  String get expiresOn => Intl.message('Expires on', name: 'expiresOn', desc: '', args: []);

  /// `Remaining`
  String get remaining => Intl.message('Remaining', name: 'remaining', desc: '', args: []);

  /// `Remaining`
  String get remainingSingular => Intl.message(
      'Remaining',
      name: 'remainingSingular',
      desc: '',
      args: [],
    );

  /// `Remaining`
  String get remainingPlural => Intl.message(
      'Remaining',
      name: 'remainingPlural',
      desc: '',
      args: [],
    );

  /// `QR code not found`
  String get qrNotFound => Intl.message(
      'QR code not found',
      name: 'qrNotFound',
      desc: '',
      args: [],
    );

  /// `Success`
  String get successTitle => Intl.message('Success', name: 'successTitle', desc: '', args: []);

  /// `Sent successfully`
  String get sentSuccessfullyMessage => Intl.message(
      'Sent successfully',
      name: 'sentSuccessfullyMessage',
      desc: '',
      args: [],
    );

  /// `Error`
  String get errorTitle => Intl.message('Error', name: 'errorTitle', desc: '', args: []);

  /// `Invalid QR code`
  String get invalidQrMessage => Intl.message(
      'Invalid QR code',
      name: 'invalidQrMessage',
      desc: '',
      args: [],
    );

  /// `Send to TV`
  String get sendToTvTitle => Intl.message(
      'Send to TV',
      name: 'sendToTvTitle',
      desc: '',
      args: [],
    );

  /// `Add from Phone`
  String get addFromPhoneTitle => Intl.message(
      'Add from Phone',
      name: 'addFromPhoneTitle',
      desc: '',
      args: [],
    );

  /// `Scan QR code with phone`
  String get addFromPhoneSubtitle => Intl.message(
      'Scan QR code with phone',
      name: 'addFromPhoneSubtitle',
      desc: '',
      args: [],
    );

  /// `Paste`
  String get pasteFromClipboard => Intl.message(
      'Paste',
      name: 'pasteFromClipboard',
      desc: '',
      args: [],
    );

  /// `Lifetime Subscription`
  String get subscriptionUnlimited => Intl.message(
      'Lifetime Subscription',
      name: 'subscriptionUnlimited',
      desc: '',
      args: [],
    );

  /// `Updated`
  String get updated => Intl.message('Updated', name: 'updated', desc: '', args: []);

  /// `Select Profile`
  String get selectProfile => Intl.message(
      'Select Profile',
      name: 'selectProfile',
      desc: '',
      args: [],
    );

  /// `Send to TV`
  String get sendToTv => Intl.message('Send to TV', name: 'sendToTv', desc: '', args: []);

  /// `Support`
  String get support => Intl.message('Support', name: 'support', desc: '', args: []);

  /// `Thanks for contribution`
  String get thanks => Intl.message(
      'Thanks for contribution',
      name: 'thanks',
      desc: '',
      args: [],
    );

  /// `Original Repository`
  String get originalRepository => Intl.message(
      'Original Repository',
      name: 'originalRepository',
      desc: '',
      args: [],
    );

  /// `Receive Subscription`
  String get receiveSubscriptionTitle => Intl.message(
      'Receive Subscription',
      name: 'receiveSubscriptionTitle',
      desc: '',
      args: [],
    );

  /// `Send device data`
  String get settingsSendDeviceDataTitle => Intl.message(
      'Send device data',
      name: 'settingsSendDeviceDataTitle',
      desc: '',
      args: [],
    );

  /// `Help improve the app by sending anonymous data`
  String get settingsSendDeviceDataSubtitle => Intl.message(
      'Help improve the app by sending anonymous data',
      name: 'settingsSendDeviceDataSubtitle',
      desc: '',
      args: [],
    );
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales => const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
