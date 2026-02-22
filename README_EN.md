# AngelinaVPN Apps

[**Русский**](README.md)

Official **AngelinaVPN** client app for Android, macOS, and other platforms.

- Powered by **Xray** core
- Supports subscription import and proxy profiles
- Designed for restricted networks, including whitelist-only environments

## Links

- VPN bot: [https://t.me/vpnAngelina_bot](https://t.me/vpnAngelina_bot)
- Repository: [https://github.com/AngelinaVPN/apps](https://github.com/AngelinaVPN/apps)

## Quick Start

### macOS

```bash
dart setup.dart macos --arch arm64 --no-core
```

### Android

```bash
flutter build apk --release --split-per-abi
```

APK outputs are located in `build/app/outputs/flutter-apk/`.

## Subscription Deep Link

Supported format:

```text
angelinavpn://install-config?url=https%3A%2F%2Fexample.com%2Fapi%2Fsub%2Ftoken
```

`flclash://install-config?...` is also supported.
