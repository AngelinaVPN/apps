#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  timesheet_worklog.sh --issue RUN-10 --start 2026-02-19T09:00:00+03:00 --duration PT8H --comment "Work summary"

Required env vars:
  TIMESHEET_OAUTH_TOKEN   OAuth token without "OAuth " prefix
  TIMESHEET_ORG_ID        Organization id (example: 7867633)

Optional env vars:
  TIMESHEET_BASE_URL      Default: https://timesheet.apps.data.lmru.tech

Options:
  --issue        Task key (example: RUN-10)
  --start        RFC3339 datetime with timezone offset
  --duration     ISO-8601 duration (example: PT2H30M)
  --comment      Worklog comment
  --dry-run      Print request payload and exit
  -h, --help     Show this help
USAGE
}

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Error: required command not found: $1" >&2
    exit 1
  fi
}

ISSUE=""
START=""
DURATION=""
COMMENT=""
DRY_RUN="false"

while (($# > 0)); do
  case "$1" in
    --issue)
      ISSUE="${2:-}"
      shift 2
      ;;
    --start)
      START="${2:-}"
      shift 2
      ;;
    --duration)
      DURATION="${2:-}"
      shift 2
      ;;
    --comment)
      COMMENT="${2:-}"
      shift 2
      ;;
    --dry-run)
      DRY_RUN="true"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Error: unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ -z "$ISSUE" || -z "$START" || -z "$DURATION" || -z "$COMMENT" ]]; then
  echo "Error: --issue, --start, --duration and --comment are required" >&2
  usage >&2
  exit 1
fi

: "${TIMESHEET_OAUTH_TOKEN:?TIMESHEET_OAUTH_TOKEN is required}"
: "${TIMESHEET_ORG_ID:?TIMESHEET_ORG_ID is required}"
TIMESHEET_BASE_URL="${TIMESHEET_BASE_URL:-https://timesheet.apps.data.lmru.tech}"

require_cmd curl
require_cmd jq

PAYLOAD="$(jq -n \
  --arg start "$START" \
  --arg duration "$DURATION" \
  --arg comment "$COMMENT" \
  '{start: $start, duration: $duration, comment: $comment}')"

URL="${TIMESHEET_BASE_URL}/tracker/v3/issues/${ISSUE}/worklog"

if [[ "$DRY_RUN" == "true" ]]; then
  echo "URL: $URL"
  echo "x-org-id: $TIMESHEET_ORG_ID"
  echo "authorization: OAuth ***"
  echo "payload: $PAYLOAD"
  exit 0
fi

RESPONSE="$(curl -fsS "$URL" \
  -H 'accept: */*' \
  -H 'content-type: application/json' \
  -H "authorization: OAuth ${TIMESHEET_OAUTH_TOKEN}" \
  -H "x-org-id: ${TIMESHEET_ORG_ID}" \
  --data-raw "$PAYLOAD")"

if command -v jq >/dev/null 2>&1; then
  echo "$RESPONSE" | jq .
else
  echo "$RESPONSE"
fi
