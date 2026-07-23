#!/bin/zsh
# Weekly re-sign+reinstall of Madeira Ativa on the iPhone (free Apple signing
# expires every 7 days). Runs via launchd; no-op if the phone isn't connected.
export PATH="/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
DEV="00008110-0004050C3633801E"
LOG=~/Library/Logs/ativa-ios-reinstall.log
echo "=== $(date) ===" >> "$LOG"
if ! xcrun devicectl list devices 2>/dev/null | grep -qi "connected"; then
  echo "iPhone not connected — skip" >> "$LOG"
  # warn if we have not managed to reinstall for 5+ days (signing expires at 7)
  LAST=$(grep -n "reinstalled OK" "$LOG" | tail -1 | cut -d: -f1)
  if [ -n "$LAST" ]; then
    TS=$(sed -n "1,${LAST}p" "$LOG" | grep "^=== " | tail -1 | sed 's/=== //;s/ ===//')
    AGE=$(( ( $(date +%s) - $(date -j -f "%a %b %d %T %Z %Y" "$TS" +%s 2>/dev/null || echo 0) ) / 86400 ))
    if [ "$AGE" -ge 5 ] 2>/dev/null; then
      osascript -e 'display notification "Подключи iPhone кабелем — подпись истекает через '"$((7-AGE))"' дн." with title "Madeira Ativa"' 2>/dev/null
    fi
  fi
  exit 0
fi
cd ~/Projects/ativa || exit 1
xcodebuild -workspace ios/Runner.xcworkspace -scheme Runner -configuration Release \
  -destination "id=$DEV" -allowProvisioningUpdates build >> "$LOG" 2>&1
APP=$(find ~/Library/Developer/Xcode/DerivedData -name "Runner.app" -path "*Release-iphoneos*" | head -1)
xcrun devicectl device install app --device "$DEV" "$APP" >> "$LOG" 2>&1 \
  && { echo "reinstalled OK" >> "$LOG"; osascript -e 'display notification "Приложение переустановлено на iPhone" with title "Madeira Ativa"' 2>/dev/null; } || echo "install FAILED" >> "$LOG"
