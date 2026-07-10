# Madeira Ativa — Android release (Google Play)

Package: `com.shpara.ativa` · signed with `~/keystores/ativa-upload.jks`
Upload file: **`madeira-ativa-vX.Y.Z.aab`** (this folder)

## What is already done
- Release AAB is built and signed with the permanent upload key (not debug).
- App icon, splash, privacy policy (https://shpara.com/madeira/privacy) ready.
- Store texts in `listing.md`, feature graphic `feature-graphic-1024x500.png`.

## Sequence — first publish
1. **Create account:** play.google.com/console → pay **$25** (one-time) →
   choose **Personal** → complete identity verification (passport + address).
2. **Create app:** All apps → Create app → name "Madeira Ativa", language,
   App (not game), Free.
3. **Store listing:** paste from `listing.md`; upload icon (512×512), feature
   graphic (1024×500), and **min 2 phone screenshots** (take on the phone).
4. **Privacy:** Policy URL = `https://shpara.com/madeira/privacy`.
   Fill "Data safety" → declare: no data collected/shared (matches the policy).
5. **Content rating** questionnaire → Everyone.
6. **Closed testing (required for new personal accounts):**
   Testing → Closed testing → create track → add **≥12 testers** (emails or a
   Google Group) → upload the **.aab** → roll out. Testers must opt in and keep
   it installed **14 days**.
7. After 14 days Google unlocks **Production**: promote the same build → submit
   for review (a few days).

## Sequence — every update afterwards
1. Bump `version:` in `pubspec.yaml` (e.g. 1.6.2 → 1.6.3).
2. `flutter build appbundle --release` → new `.aab`.
3. Play Console → Production (or testing) → Create release → upload `.aab` →
   review → roll out.

> Keep `~/keystores/ativa-upload.jks` + its password forever. Lose it and you
> cannot update the app. It is NOT in git.
