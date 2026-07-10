# Madeira Ativa — iOS release (App Store)

Bundle id: `com.shpara.ativa` · project: `~/Projects/ativa` (open in Xcode)
`Runner.app` here is a device build only — the App Store upload is done from
Xcode (needs the paid Apple Developer account).

## Prerequisites
- **Apple Developer Program — $99/year** (developer.apple.com/programs).
- Mac + Xcode (already set up). Team: ARY46X758B (kirshp@gmail.com).

## Sequence — first publish
1. **Enroll** in the Apple Developer Program ($99) and wait for approval.
2. **App Store Connect** (appstoreconnect.apple.com) → Apps → **+ New App**:
   platform iOS, name "Madeira Ativa", bundle id `com.shpara.ativa`, SKU any.
3. **Signing:** open `~/Projects/ativa/ios/Runner.xcworkspace` in Xcode →
   Runner target → Signing & Capabilities → Team = your paid team →
   "Automatically manage signing".
4. **Set version/build:** match `pubspec.yaml` (e.g. 1.6.2).
5. **Archive:** Xcode top bar device = **Any iOS Device (arm64)** →
   Product → **Archive** → Organizer opens → **Distribute App** →
   **App Store Connect** → Upload.
6. **In App Store Connect:** fill listing (texts in `../android/listing.md`,
   works for both), upload **screenshots** (6.7" iPhone required), set privacy
   (URL `https://shpara.com/madeira/privacy`, "No data collected"), pricing Free.
7. Select the uploaded build → **Submit for Review** (1–3 days typical).

## Sequence — every update afterwards
1. Bump `version:` in `pubspec.yaml`.
2. Xcode → Any iOS Device → Product → Archive → Distribute → Upload.
3. App Store Connect → new version → attach build → Submit for Review.

## Notes
- No 12-tester requirement on iOS (that is Google-only). TestFlight is optional
  for beta testers.
- Free personal-team signing (what we used on your iPhone) is **dev only** and
  expires in 7 days — the paid account removes that and enables the store.
