# دليريا (Dalyria)

**دليريا، دليلك في سوريا** — Dalyria, your guide to Syria.

A bilingual (Arabic / English) mobile app for discovering food places in Damascus, with verified and up-to-date information.

> **Status:** in development. This is the Software Engineering graduation project at Altınbaş University (2026–2027).
> **Version 1** (Semester 1) is an Android app covering food places in Damascus city.

---

## Project Overview

Syria is reopening. Hundreds of thousands of Syrians are returning or visiting, and many locals stopped exploring their own cities during the war years. Finding good places to eat is hard: information is scattered across friends and social media, and map apps are often outdated or missing basic details.

**Dalyria** (from دليل, "guide", + Syria) helps anyone in Damascus discover food places they don't know yet, with information they can trust: real photos, opening hours, and a "last verified" date on every place.

## Problem

- **Discovery:** people can't search for places they have never heard of. Existing tools only help if you already know what to look for.
- **Trust:** information is scattered, unstructured, and often missing key details such as opening hours, photos, or whether a place still exists.
- **Change:** new places open and close faster than existing information is updated.

## Objectives

- Build a working Android app where users can discover, search, and view food places in Damascus.
- Show verified, up-to-date information for every place, including a "last verified" date.
- Help users discover places they would not know to search for: new openings, trending places, and curated collections.
- Support both Arabic (right-to-left) and English (left-to-right).
- Give the admin tools to add, verify, and correct places, and to moderate user ratings.

## Scope

**Version 1 (Semester 1, this repository's first milestone)**

- Food places (restaurants, cafes, bakeries, sweet shops, and more) in Damascus city
- Home sections, search and filters, map with "near you", place details
- Google sign-in, saved places, ratings and reviews, problem reports, sharing
- Admin screens for managing places, reports, ratings, collections, and banners
- Android only, Arabic and English

**Planned for Version 2 (Semester 2)**

- Business owner accounts (claim and update their own listing)
- iOS version
- More cities and categories (attractions, gyms, hotels)
- Re-check schedule for keeping information fresh

## Planned Technology Stack

| Layer | Technology |
| --- | --- |
| Mobile app | Flutter (Dart), Android |
| Backend | Supabase (PostgreSQL, Auth, Storage) |
| Authentication | Google sign-in via Supabase Auth |
| Maps and location | Google Maps (`google_maps_flutter`), `geolocator` |
| State management | Riverpod |
| Navigation | `go_router` |
| Localization | Flutter `intl` (Arabic and English) |
| Testing | `flutter_test`, `integration_test` |

## Installation

_Coming soon._ Setup steps, environment variables, and run commands will be added as the project develops.

## Repository Structure

_Coming soon._

## Author

Khairat Joulak — Software Engineering, Altınbaş University

## References

### Academic

[1] J. M. Noguera, M. J. Barranco, R. J. Segura, and L. Martínez, "A mobile 3D-GIS hybrid recommender system for tourism," *Information Sciences*, vol. 215, pp. 37–52, 2012.

[2] M. Al-Ghobari, A. Muneer, and S. M. Fati, "Location-aware personalized traveler recommender system (LAPTA) using collaborative filtering KNN," *Computers, Materials & Continua*, vol. 69, no. 2, 2021, doi: 10.32604/cmc.2021.016348.

[3] M. A. Ali, D. H. Ting, M. Ahmad-ur-Rahman, S. Ali, F. Shear, and M. Mazhar, "Effect of online reviews and crowd cues on restaurant choice of customer: Moderating role of gender and perceived crowding," *Frontiers in Psychology*, vol. 12, Art. no. 780863, 2021, doi: 10.3389/fpsyg.2021.780863.

[4] S. M. Sarif, Z. Hanafi, S. F. Packeer Mohamed, S. B. Zaibon, and M. F. Mohamad Mohsin, "Makan@Local Chatok: Mobile eatery recommendation system based on local knowledge," *International Journal of Interactive Mobile Technologies (iJIM)*, vol. 14, no. 5, pp. 129–149, 2020, doi: 10.3991/ijim.v14i05.13357.

[5] H. H. Hochmair, L. Juhász, and S. Cvetojevic, "Data quality of points of interest in selected mapping and social media platforms," in *Progress in Location Based Services 2018*, P. Kiefer, H. Huang, N. Van de Weghe, and M. Raubal, Eds. Cham, Switzerland: Springer, 2018, pp. 293–313, doi: 10.1007/978-3-319-71470-7_15.

### Technical

[6] Google, "Flutter documentation." [Online]. Available: https://docs.flutter.dev

[7] Supabase, "Supabase documentation." [Online]. Available: https://supabase.com/docs

[8] Google, "Maps SDK for Android: Usage and billing." [Online]. Available: https://developers.google.com/maps/documentation/android-sdk/usage-and-billing

[9] Riverpod, "Riverpod documentation." [Online]. Available: https://riverpod.dev
