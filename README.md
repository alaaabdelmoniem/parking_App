# Parking App

A Flutter mobile application for discovering, booking, and navigating to nearby parking spots.

The app combines open map data (OpenStreetMap) with a Supabase backend: the map data tells you *where* parking is, and Supabase adds what OSM doesn't have: pricing, ratings, amenities, availability, and bookings.

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Configuration](#configuration)
- [Roadmap & Known Limitations](#roadmap--known-limitations)
- [Data Sources & Attribution](#data-sources--attribution)

---

## Overview

| | |
|---|---|
| **Platform** | Android and iOS (Flutter) |
| **Backend** | Supabase (PostgreSQL, Auth, Row Level Security) |
| **Maps** | `flutter_map` with OpenStreetMap / CARTO tiles |
| **State management** | Cubit (`flutter_bloc`) |
| **Status** | Under active development |

---

## Features

### Discovery & Map
- **Reliable current location.** Uses the last known position first, then a fresh fix with a time limit, then a live stream. Disabled location services and denied permissions are handled explicitly.
- **Supabase-first spot loading.** Nearby spots are read from Supabase first. The Overpass API is called only when the area has no data or has not been synced recently. Each ~1 km grid cell is cached locally for 7 days.
- **Smart refetching.** Spots are re-fetched only on the first location fix or after the user moves more than 500 m.
- **Search, filter, and sort.** Search by name, filter by amenities (EV charging, covered, 24/7, security) and maximum price, and sort by distance, price, rating, or availability.
- **Directions.** A route from the user's position to the selected spot is drawn on the map (OpenRouteService). It is recalculated when the user moves more than 50 m, and stale responses are discarded.

### Spot Details
- Distance and estimated walking time.
- Rating breakdown, space availability, opening hours, and amenities.
- Tap-to-call and tap-to-visit-website contact actions.
- Directions notes and a reviews section.

### Authentication
- Email/password sign-up and login with email confirmation (Supabase Auth).
- Google and Facebook sign-in (OAuth) sharing one deep-link redirect.
- A single `AuthCache` helper stores the user's id, name, and email for every login method, and clears them on log out.
- Manual `emailConfirmedAt` check on login, independent of dashboard settings.
- User-friendly error messages mapped from `AuthException` codes (invalid credentials, rate limits, unconfirmed email, already-registered accounts, and more).
- Animated splash screen.

### Booking
- **Opening-hours aware.** The date/time picker reads the spot's OSM `opening_hours` (for example `Mo-Su 09:00-18:00`) and offers only open days and 15-minute slots inside the open range. If the hours are missing or use unsupported syntax, it falls back to an unrestricted `CupertinoDatePicker`.
- Exit time cannot be earlier than entry time, and past times cannot be selected.
- Automatic duration and price calculation, with a full price breakdown (fee, tax, discounts, total).
- Multi-step checkout (date/time, summary, payment method, confirm) as a full screen or a draggable bottom sheet.
- QR code generated on-device from the booking id (`qr_flutter`); no image is stored.
- Add Card sheet with automatic formatting, live brand detection (Visa, Mastercard, Amex, Discover), and validation (Luhn checksum, expiry, CVV length per brand).
- Bookings are stored per user and protected by Row Level Security.

### Reservations
- List of the user's bookings with spot image, name, address, date, time range, and total price.
- Client-side status filters: All, Active, Upcoming, Completed.
- **Status is computed, not stored.** Upcoming before the start time, Active between start and end, Completed after the end. Times are stored in UTC and shown in local time.
- Status-aware cards:
  - *Upcoming:* view the QR code.
  - *Active:* live session sheet with a countdown, a progress bar (turns orange under 15 minutes), directions, QR code, and **Extend Time**.
  - *Completed:* Book Again.
- **Extend Time.** The new end time is limited to the spot's opening hours, saved to Supabase, and the list reloads when the sheet closes.

### Navigation & Profile
- Liquid-glass bottom navigation bar (Map, Reservations, Profile) with an animated selection pill.
- Profile screen with the user's name and email, booking stats, and grouped settings. Log out is functional; the remaining settings are UI only.

---

## Architecture

The project is organized feature-first. Each feature separates its data layer (models, repositories) from its presentation layer (cubits, views, widgets).

Key decisions:

- **Two data sources, one flow.** OpenStreetMap provides base locations; Supabase provides enriched details. Supabase is always read first, and Overpass is only a fallback for unsynced areas.
- **Functional error handling.** Repositories return `Either<Failure, T>` (`dartz`), with dedicated mappers for network errors (`dio_handler.dart`) and database/auth errors (`supabase_handler.dart`).
- **Query-level geographic filtering.** Spots are fetched by bounding box on `lat`/`lng` to avoid over-fetching.
- **Security at the database level.** The `bookings` table uses Row Level Security (`auth.uid()`), so a user's reservations are never visible to others. The app additionally filters by the signed-in user's id.
- **Index-aligned data.** Bookings are fetched first, then each booking's spot is loaded by `spot_id`; the two lists keep the same order so the UI can render them together.
- **Safe async state.** Cubits check `isClosed` after every `await`, so leaving a screen mid-request never throws.
- **Latest request wins.** Route requests carry an id, and responses from outdated requests are ignored.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter |
| State management | Cubit (`flutter_bloc`) |
| Maps & tiles | `flutter_map`, OpenStreetMap / CARTO |
| Location | `geolocator` |
| Parking data | OpenStreetMap Overpass API |
| Backend | Supabase (PostgreSQL, Auth, RLS) |
| Routing | OpenRouteService |
| Navigation | `go_router` |
| Responsive UI | `flutter_screenutil` |
| Networking | `dio` |
| Error handling | `dartz` (`Either<Failure, T>`) |
| QR codes | `qr_flutter` |
| Animations | `lottie` |
| External links | `url_launcher` |
| Configuration | `flutter_dotenv` |

---

## Project Structure

```
parking_App/
├── android/ ios/ ...                  # Platform targets
├── assets/                            # Images and static assets
├── backend/                           # Supabase migrations, schema, RLS policies
├── lib/
│   ├── core/
│   │   ├── cache/                     # auth_cache, cache_helper, cache_keys
│   │   ├── errors/                    # dio_handler, failure, supabase_handler
│   │   ├── models/                    # card_details_model, oAuth_mixin
│   │   ├── routers/                   # app_router (go_router)
│   │   ├── theme/                     # app_colors, app_text_style, app_theme
│   │   └── utils/                     # enums, functions, widgets, constants,
│   │                                  # input formatters, opening-hours parser
│   ├── features/
│   │   ├── auth/                      # Login, sign-up, social auth, log out
│   │   ├── main/                      # App shell and bottom navigation
│   │   ├── map/                       # Map, spot details, search/filter/sort, booking
│   │   ├── onboarding/                # Onboarding flow
│   │   ├── profile/                   # Profile screen
│   │   ├── reservations/              # Reservations list, cards, QR and active-session sheets
│   │   └── splash/                    # Animated splash screen
│   └── main.dart                      # Entry point
├── test/
├── .env                               # Local secrets (gitignored)
└── pubspec.yaml
```

---

## Getting Started

### Prerequisites
- Flutter SDK 3.x or later
- A Supabase project (the free tier is enough)
- An [OpenRouteService](https://openrouteservice.org/) API key for directions
- A [CARTO Basemaps](https://carto.com/basemaps) API key, only if you use CARTO tiles
- Google and/or Facebook developer apps for OAuth (optional, only for social login)

### Installation

```bash
git clone https://github.com/alaaabdelmoniem/parking_App
cd parking_App
flutter pub get
```

1. Create a `.env` file in the project root (see [Configuration](#configuration)).
2. Create the `parking_spots` and `bookings` tables in Supabase. The schema and RLS policies are under `/backend`.
3. *(Optional)* Enable Google/Facebook sign-in in Supabase (`Authentication → Providers`) and register the redirect URL `io.supabase.parking://login-callback/` in `AndroidManifest.xml`, `Info.plist`, and Supabase's URL Configuration.
4. Run the app:
   ```bash
   flutter run
   ```

---

## Configuration

Create a `.env` file in the project root:

| Variable | Description |
|---|---|
| `SUPABASE_URL` | Your Supabase project URL |
| `SUPABASE_ANON_KEY` | Your Supabase anon (public) key |
| `ORS_API_KEY` | OpenRouteService API key (directions) |
| `CARTO_API_KEY` | CARTO Basemaps key (only for CARTO tiles) |

> **Security:** never commit real keys. Keep `.env` in `.gitignore` and commit a `.env.example` containing only the variable names. If a key is ever exposed, revoke and regenerate it.
>
> The `.env` file is read once at startup, so after changing it, fully stop and restart the app (hot reload will not pick it up).

---

## Roadmap & Known Limitations

- Amenity filters, live availability, and reviews currently use mock data pending real data sources.
- Payments are UI only: the booking flow and Add Card sheet are not connected to a payment gateway, and no card details are stored.
- Opening-hours rules are enforced in the date/time picker only; the database does not yet reject bookings outside opening hours.
- Most Profile settings are UI only, and the Book Again action is not implemented yet.

---

## Data Sources & Attribution

- Parking location data © [OpenStreetMap](https://www.openstreetmap.org/copyright) contributors, available under the Open Database License.
- Map tiles © [OpenStreetMap](https://www.openstreetmap.org/copyright) contributors and [CARTO](https://carto.com/basemaps).
- Routing by [OpenRouteService](https://openrouteservice.org/).
