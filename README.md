# AngelinaVPN Apps

[**English**](README_EN.md)

Официальный клиент **AngelinaVPN** для Android, macOS и других платформ.

- Работает на ядре **Xray**
- Поддерживает импорт подписок и работу с прокси-профилями
- Используется для обхода сетевых ограничений, включая сценарии с белыми списками

## Ссылки

- VPN-бот: [https://t.me/vpnAngelina_bot](https://t.me/vpnAngelina_bot)
- Репозиторий: [https://github.com/AngelinaVPN/apps](https://github.com/AngelinaVPN/apps)

## Быстрый старт

### macOS

```bash
dart setup.dart macos --arch arm64 --no-core
```

### Android

```bash
flutter build apk --release --split-per-abi
```

Готовые APK будут в `build/app/outputs/flutter-apk/`.

## Deep Link для установки подписки

Поддерживаемый формат:

```text
angelinavpn://install-config?url=https%3A%2F%2Fexample.com%2Fapi%2Fsub%2Ftoken
```

Также поддерживается схема `flclash://install-config?...`.

## Автоматизация Worklog (Timesheet)

Добавлен скрипт `scripts/timesheet_worklog.sh` для отправки worklog в API.

1. Создайте локальный env-файл (не коммитьте токен):

```bash
cp scripts/timesheet_worklog.env.example ~/.timesheet.env
# отредактируйте ~/.timesheet.env
```

2. Отправьте запись:

```bash
source ~/.timesheet.env
scripts/timesheet_worklog.sh \
  --issue RUN-10 \
  --start '2026-02-19T09:00:00+03:00' \
  --duration 'PT22H' \
  --comment 'Поддержка заказов и логистических операций на складах'
```

3. Проверка без отправки:

```bash
source ~/.timesheet.env
scripts/timesheet_worklog.sh \
  --issue RUN-10 \
  --start '2026-02-19T09:00:00+03:00' \
  --duration 'PT22H' \
  --comment 'Тест' \
  --dry-run
```

Пример cron (каждый будний день в 18:00):

```cron
0 18 * * 1-5 source ~/.timesheet.env && /Users/vladislavdaneev/Documents/vpn/AngelinaVPN2/scripts/timesheet_worklog.sh --issue RUN-10 --start "$(date '+\%Y-\%m-\%dT09:00:00+03:00')" --duration "PT9H" --comment "Поддержка заказов и логистических операций на складах"
```
