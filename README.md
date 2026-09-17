# 🅿️ Parking App — Find Nearby Parking Spots

A Flutter mobile app that helps users find, filter, and get directions to nearby parking spots in real time.

## Features

- **Live location tracking** — continuously tracks the user's current position using `geolocator`.
- **Interactive map** — built with `flutter_map` and OpenStreetMap tiles (via CartoDB), showing the user's location and nearby parking spots as markers.
- **Nearby parking data** — fetches real parking locations from OpenStreetMap's Overpass API, enriched with details stored in Supabase (price, ratings, amenities, capacity, images, and more).
- **Search & filters** — search parking spots by name, filter by amenities (EV charging, covered, 24/7, security), and cap results by max price.
- **Sort options** — sort results by distance, price, rating, or availability.
- **Spot details** — each parking spot shows distance and walking time, rating breakdown, space availability, opening hours, amenities, contact info (with tap-to-call and tap-to-visit-website), and directions notes.
- **Reviews** — view and browse user reviews for each parking spot.
- **Session booking preview** — pick a date, start time, and end time to preview a parking session with calculated duration and price.
- **Directions & routing** — get a route from the user's current location to a selected parking spot, rendered on the map.

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter |
| State management | Cubit (`flutter_bloc`) |
| Maps & tiles | `flutter_map`, OpenStreetMap / CartoDB |
| Location services | `geolocator` |
| Parking spot data | OpenStreetMap Overpass API |
| Backend & database | Supabase (PostgreSQL, Row Level Security, Realtime) |
| Routing / directions | OpenRouteService |
| Navigation | `go_router` |
| Responsive UI | `flutter_screenutil` |
| Networking | `dio` |
| Functional error handling | `dartz` (`Either<Failure, T>`) |
| External links | `url_launcher` |
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
│   │   │   └── supabase_handler.dart              # Supabase/Postgrest error mapping
│   │   └── utils/
│   │       ├── functions/                        # Shared helper functions (distance, formatting, mock data, etc.)
│   │       ├── widgets/                           # Shared reusable widgets
│   │       ├── app_colors.dart                    # App color system
│   │       ├── app_router.dart                    # go_router route definitions
│   │       ├── app_text_style.dart                 # App text style system
│   │       ├── app_theme.dart                      # Light theme configuration
│   │       └── constants.dart                      # App-wide constants
│   ├── features/
│   │   ├── map/                                    # Map, spot details, search/filter/sort, reviews, booking
│   │   ├── onboarding/                             # Onboarding flow
│   │   └── splash/                                 # Splash screen
│   └── main.dart                                   # App entry point
├── test/
├── .env                                            # Local environment variables (gitignored)
└── pubspec.yaml
```

- **Data sources are separated**: OpenStreetMap (Overpass API) supplies base location data, while Supabase stores and serves enriched details (pricing, ratings, amenities) that OSM doesn't provide.
- **Errors are handled functionally** using `Either<Failure, T>`, with dedicated handlers for network (`dio_handler.dart`) and database (`supabase_handler.dart`) errors.
- **Geographic filtering** happens at the query level (bounding box on `lat`/`lng`) to avoid over-fetching data from Supabase.

## Getting Started

### Prerequisites

- Flutter SDK (3.x or later)
- A Supabase project (free tier is sufficient)

### Setup

1. Clone the repository:
   ```bash
   git clone <https://github.com/alaaabdelmoniem/parking_App>
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

4. Set up the `parking_spots` table in Supabase — schema and RLS policies live under `/backend`.

5. Run the app:
   ```bash
   flutter run
   ```

## Data Sources & Attribution

- Base parking location data © [OpenStreetMap](https://www.openstreetmap.org/copyright) contributors, available under the Open Database License.
- Map tiles provided by [CARTO](https://carto.com/basemaps).

## Status

🚧 This project is under active development. Amenity filters, live availability tracking, and full review data are currently backed by mock data pending real data sources.