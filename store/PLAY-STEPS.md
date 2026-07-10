# Google Play — step by step

Upload artifact: `store/android/madeira-ativa-v1.6.1.aab`
(signed with YOUR upload key — `~/keystores/ativa-upload.jks`, keep it forever)

## 1. Account (once)
1. Go to https://play.google.com/console → sign in with your Google account.
2. Pay the **$25 one-time** registration fee.
3. Choose account type **Personal**, complete **identity verification**
   (passport/ID; sometimes a short video). Can take a few days — start now.

## 2. Create the app
1. Play Console → **Create app**.
2. Name: **Madeira Ativa** · Language: English · Type: **App** · Free.
3. Accept the declarations.

## 3. Store listing (copy from `store/listing.md`)
- Short + full description (EN; add PT under "Manage translations").
- App icon: 512×512 (from `assets/icon.png`).
- Feature graphic: 1024×500 (ask Claude to generate).
- Phone screenshots: at least 2 (use `store/screenshots/`).
- Category: **Travel & Local** (or Sports). Contact email: azenha.agent@gmail.com.

## 4. Policy / content
- **Privacy policy URL**: `https://shpara.com/madeira/privacy`
- **Data safety** form: choose **No data collected / no data shared**.
- Content rating questionnaire → will come out **Everyone**.
- Target audience: 13+ (or all ages). No ads.

## 5. Upload the build
1. Left menu → **Testing ▸ Closed testing** → create a track.
2. Upload `store/android/madeira-ativa-v1.6.1.aab`.
3. On first upload, accept **Play App Signing** (Google keeps the release key,
   your upload key stays yours — this is correct).

## 6. The 12-tester rule (new personal accounts)
Before Google lets you go to **Production**, a personal account must run
**closed testing with ≥12 testers for 14 continuous days**.
1. In the closed track add testers by email (or a Google Group).
2. Send them the opt-in link; they install and keep it for 14 days.
3. After 14 days the **Apply for production** button unlocks.

## 7. Production
Promote the closed track to Production → submit for review (a few days).

---
Artifact checklist: ✅ signed AAB · ✅ icon · ✅ splash · ✅ privacy URL ·
⬜ feature graphic · ⬜ screenshots · ⬜ 12 testers
