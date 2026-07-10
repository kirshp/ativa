# Apple App Store — step by step

Unlike Android, you cannot pre-build the final upload package without the paid
account — the store `.ipa` is created at Archive time once a paid team is
selected. Everything else (icons, splash, version, privacy) is already done.

## 1. Apple Developer Program (once)
1. https://developer.apple.com/programs/ → enrol.
2. Pay **$99 / year**. Verify identity. (Ready in ~24–48h.)

## 2. Point the project at the paid team
1. Open `ios/Runner.xcworkspace` in Xcode.
2. Runner target → **Signing & Capabilities** → select your **paid team**
   (replace the current free personal team `ARY46X758B`).
   "Automatically manage signing" stays ON — Xcode makes the distribution
   certificate + provisioning profile for you.

## 3. Create the app record
1. https://appstoreconnect.apple.com → **My Apps ▸ +** → New App.
2. Platform iOS · Name **Madeira Ativa** · Bundle ID **com.shpara.ativa**
   (register it under Certificates, Identifiers & Profiles if asked) · SKU: ativa.

## 4. Build & upload
In the project folder:
```sh
flutter build ipa --release
```
Then open `build/ios/archive/Runner.xcarchive` in Xcode Organizer →
**Distribute App ▸ App Store Connect ▸ Upload**.
(Or use Xcode: Product ▸ Archive ▸ Distribute.)

## 5. Listing (copy from `store/listing.md`)
- Description (EN; add PT as a localization).
- Screenshots: **6.7"** (iPhone 15/14 Pro Max) and **6.5"** sizes — capture on
  your iPhone 13 Pro Max, that covers 6.5".
- Privacy policy URL: `https://shpara.com/madeira/privacy`
- App Privacy → **Data Not Collected**.
- Category: Travel (secondary: Sports). Age rating: 4+.

## 6. Submit
Attach the uploaded build → **Submit for Review** (1–3 days).
No 12-tester requirement. TestFlight is optional if you want beta testers first.

---
Checklist: ✅ icons(21) · ✅ splash · ✅ bundle id · ✅ privacy URL ·
⬜ paid account · ⬜ screenshots · ⬜ archive+upload
