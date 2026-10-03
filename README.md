# 🅿️ Parking App — Find Nearby Parking Spots

A Flutter mobile app that helps users find, filter, book, and get directions to nearby parking spots in real time.

## Features

### Discovery & Map
- **Live location tracking** — continuously tracks the user's current position using `geolocator`.
- **Interactive map** — built with `flutter_map` and OpenStreetMap tiles (via CartoDB), showing the user's location and nearby parking spots as markers.
- **Nearby parking data** — fetches real parking locations from OpenStreetMap's Overpass API, enriched with details stored in Supabase (price, ratings, amenities, capacity, images, and more).
- **Search & filters** — search parking spots by name, filter by amenities (EV charging, covered, 24/7, security), and cap results by max price.
- **Sort options** — sort results by distance, price, rating, or availability.
- **Directions & routing** — get a route from the user's current location to a selected parking spot, rendered on the map.

### Spot Details
- Distance and estimated walking time to each spot.
- Rating breakdown, space availability, opening hours, and amenities.
- Contact info with tap-to-call and tap-to-visit-website.
- Directions notes and a browsable reviews section.

### Authentication
- Email/password sign-up and login via Supabase Auth, with email confirmation.
- Social login with Google and Facebook (OAuth), sharing a single deep-link redirect across providers.
- Manual `emailConfirmedAt` check on login as a safety net, independent of dashboard settings.
- Clear, user-facing error messages mapped from Supabase's `AuthException` codes (invalid credentials, rate limits, unconfirmed email, existing accounts detected via the `identities` array, etc.).

### Booking
- Pick a date, start time, and end time with a native iOS-style (`CupertinoDatePicker`) wheel, or a Material date/time picker.
- Automatic duration and price calculation based on the selected time window.
- Multi-step checkout flow (date/time → summary → payment method → confirm), available as a full screen or a draggable bottom sheet.
- Reservation summary with a full price breakdown (fee, tax, discounts, total).
- Bookings are written to a dedicated `bookings` table, scoped per user with Row Level Security — each user can only see and manage their own reservations (active, upcoming, or completed).

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter |
| State management | Cubit (`flutter_bloc`) |
| Maps & tiles | `flutter_map`, OpenStreetMap / CartoDB |
| Location services | `geolocator` |
| Parking spot data | OpenStreetMap Overpass API |
| Backend & database | Supabase (PostgreSQL, Auth, Row Level Security) |
| Routing / directions | OpenRouteService |
| Navigation | `go_router` |
| Responsive UI | `flutter_screenutil` |
| Networking | `dio` |
| Functional error handling | `dartz` (`Either<Failure, T>`) |
| External links | `url_launcher` |
| Animations | `lottie` |
| Environment config | `flutter_dotenv` |

## Project Structure

```
parking_App/
├── android/ ios/ linux/ macos/ web/ windows/   # Platform targets
├── assets/                                      # Images and static assets
├── backend/                                      # Supabase migrations & config
├── lib/
│   ├── core/
│   │   ├── cache/
│   │   │   ├── cache_helper.dart                 # Local key-value storage helper
│   │   │   └── cache_keys.dart                   # Cache & table name keys
│   │   ├── errors/
│   │   │   ├── dio_handler.dart                  # Dio/network error mapping
│   │   │   ├── failure.dart                      # Base Failure types
│   │   │   └── supabase_handler.dart              # Supabase/Postgrest/Auth error mapping
│   │   └── utils/
│   │       ├── functions/                        # Shared helper functions (distance, formatting, mock data, etc.)
│   │       ├── widgets/                           # Shared reusable widgets
│   │       ├── app_colors.dart                    # App color system
│   │       ├── app_router.dart                    # go_router route definitions
│   │       ├── app_text_style.dart                 # App text style system
│   │       ├── app_theme.dart                      # Light theme configuration
│   │       └── constants.dart                      # App-wide constants
│   ├── features/
│   │   ├── auth/                                   # Login, sign-up, and social auth
│   │   ├── map/                                    # Map, spot details, search/filter/sort, reviews, booking
│   │   ├── onboarding/                             # Onboarding flow
│   │   └── splash/                                 # Splash screen
│   └── main.dart                                   # App entry point
├── test/
├── .env                                            # Local environment variables (gitignored)
└── pubspec.yaml
```

- **Data sources are separated**: OpenStreetMap (Overpass API) supplies base location data, while Supabase stores and serves enriched details (pricing, ratings, amenities) that OSM doesn't provide.
- **Errors are handled functionally** using `Either<Failure, T>`, with dedicated handlers for network (`dio_handler.dart`) and database/auth (`supabase_handler.dart`) errors.
- **Geographic filtering** happens at the query level (bounding box on `lat`/`lng`) to avoid over-fetching data from Supabase.
- **Bookings are user-scoped by design**: the `bookings` table enforces Row Level Security so a user's reservations are never visible to other users, matched by `auth.uid()` at the database level rather than filtered client-side.

## Getting Started

### Prerequisites

- Flutter SDK (3.x or later)
- A Supabase project (free tier is sufficient)
- Google and/or Facebook developer apps configured for OAuth (optional, only needed for social login)

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/alaaabdelmoniem/parking_App
   cd parking_App
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Create a `.env` file in the project root (see `.env.example`) with your Supabase credentials:
   ```
   SUPABASE_URL=your_supabase_project_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

4. Set up the `parking_spots` and `bookings` tables in Supabase — schema and RLS policies live under `/backend`.

5. (Optional) To enable Google/Facebook sign-in, configure each provider in Supabase (`Authentication → Providers`) and register the shared OAuth redirect URL (`io.supabase.parking://login-callback/`) in `AndroidManifest.xml`, `Info.plist`, and Supabase's URL Configuration.

6. Run the app:
   ```bash
   flutter run
   ```

## Data Sources & Attribution

- Base parking location data © [OpenStreetMap](https://www.openstreetmap.org/copyright) contributors, available under the Open Database License.
- Map tiles provided by [CARTO](https://carto.com/basemaps).

## Status

🚧 This project is under active development. Amenity filters, live availability tracking, and full review data are currently backed by mock data pending real data sources. Payment processing in the booking flow is UI-only and not yet connected to a real payment gateway.