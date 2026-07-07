# Madeira Ativa

Cross-platform (Android + iOS) Flutter app for sport and cultural events on
Madeira — trails, road running, orienteering, cycling, swimming, triathlon,
festivals — plus the island's heritage. Companion to
[shpara.com/madeira](https://shpara.com/madeira/).

## Features

- **Events** — calendar strip + site-matching categories (Trail / Road /
  Orient / Bike / Kids / Pro / Swim / Fest) with a watchlist of unconfirmed dates.
- **Map** — Madeira levada routes on OpenStreetMap.
- **Levadas** — 44 official PR routes with distance, climb, status and fees,
  plus aggregate trail stats.
- **News** — multilingual feed (EN / PT / DE / PL / UK / RU).
- **Roots** — the island's history: a six-era timeline and a 19-picture album.
- **On TV** — upcoming sports broadcasts.
- EN / PT interface, light theme, live data from the site (no separate backend).

## Data

The app reads the same static JSON the website and Telegram bot use
(`events.json`, `news_feed.json`, `levadas.json`, `tv_broadcasts.json`,
`watchlist.json`) — a shared parser keeps everything in sync.

## Build

```sh
flutter pub get
flutter build apk --release --target-platform android-arm64   # Android
flutter build ios --release                                    # iOS (needs Xcode)
```

## Versioning

Each released update bumps the version in `pubspec.yaml` and is tagged
`vX.Y.Z` — see the repository's tags / releases.
