import 'package:geolocator/geolocator.dart';

class SpotModel {
  final String? id; // Supabase row id (uuid), null for new/unsaved spots
  final String?
  osmId; // e.g. "node_123456" or "way_789012", null if manually added
  final String name;
  final double lat;
  final double lng;

  // --- Fields that may come from OSM (nullable — often missing)
  final String? capacity;
  final String? capacityDisabled;
  final String? openingHours;
  final String? phone;
  final String? website;

  // Fields not available in OSM
  final double? priceForHour;
  final double? priceForDay;
  final String? address;
  final double? rate;
  final int numOfReviews;
  final List<String> images;
  final String type; //  'garage', 'street'
  final String? noteDirection;

  const SpotModel({
    this.id,
    this.osmId,
    required this.name,
    required this.lat,
    required this.lng,
    this.capacity,
    this.capacityDisabled,
    this.openingHours,
    this.phone,
    this.website,
    this.priceForHour,
    this.priceForDay,
    this.address,
    this.rate,
    this.numOfReviews = 0,
    this.images = const [],
    this.type = 'unknown',
    this.noteDirection,
  });

  // Parsing from an Overpass API element (raw OSM data)
  factory SpotModel.fromOverpassElement(Map<String, dynamic> element) {
    // Nodes have 'lat'/'lon' directly; ways/relations return a 'center'
    final center = element['center'] as Map<String, dynamic>?;
    final double spotLat = (element['lat'] ?? center?['lat'])?.toDouble();
    final double spotLng = (element['lon'] ?? center?['lon'])?.toDouble();

    final tags = element['tags'] as Map<String, dynamic>?;

    return SpotModel(
      osmId: '${element['type']}_${element['id']}',
      name: tags?['name'] ?? 'Parking',
      lat: spotLat,
      lng: spotLng,
      capacity: tags?['capacity'],
      capacityDisabled: tags?['capacity:disabled'],
      openingHours: tags?['opening_hours'],
      phone: tags?['phone'],
      website: tags?['website'],
      type:
          tags?['parking'] ?? 'unknown', // surface / multi-storey / underground
    );
  }

  factory SpotModel.fromSupabase(Map<String, dynamic> json) {
    return SpotModel(
      id: json['id'],
      osmId: json['osm_id'],
      name: json['name'] ?? 'Parking',
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      capacity: json['capacity'],
      capacityDisabled: json['capacity_disabled'],
      openingHours: json['opening_hours'],
      phone: json['phone'],
      website: json['website'],
      priceForHour: (json['price_for_hour'] as num?)?.toDouble(),
      priceForDay: (json['price_for_day'] as num?)?.toDouble(),
      address: json['address'],
      rate: (json['rate'] as num?)?.toDouble(),
      numOfReviews: json['num_of_reviews'] ?? 0,
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : const [],
      type: json['type'] ?? 'unknown',
      noteDirection: json['note_direction'],
    );
  }

  // Converting to JSON for Supabase insert/upsert
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'osm_id': osmId,
      'name': name,
      'lat': lat,
      'lng': lng,
      'capacity': capacity,
      'capacity_disabled': capacityDisabled,
      'opening_hours': openingHours,
      'phone': phone,
      'website': website,
      'price_for_hour': priceForHour,
      'price_for_day': priceForDay,
      'address': address,
      'rate': rate,
      'num_of_reviews': numOfReviews,
      'images': images,
      'type': type,
      'note_direction': noteDirection,
    };
  }

  //  it must be calculated at runtime, not persisted in the database.
  double distanceFrom(Position userPosition) {
    return Geolocator.distanceBetween(
      userPosition.latitude,
      userPosition.longitude,
      lat,
      lng,
    ); // returns distance in meters
  }

  // Convenience copyWith for updating a spot ( after user edits it)
  SpotModel copyWith({
    String? id,
    String? osmId,
    String? name,
    double? lat,
    double? lng,
    String? capacity,
    String? capacityDisabled,
    String? openingHours,
    String? phone,
    String? website,
    double? priceForHour,
    double? priceForDay,
    String? address,
    double? rate,
    int? numOfReviews,
    List<String>? images,
    String? type,
    String? noteDirection,
  }) {
    return SpotModel(
      id: id ?? this.id,
      osmId: osmId ?? this.osmId,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      capacity: capacity ?? this.capacity,
      capacityDisabled: capacityDisabled ?? this.capacityDisabled,
      openingHours: openingHours ?? this.openingHours,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      priceForHour: priceForHour ?? this.priceForHour,
      priceForDay: priceForDay ?? this.priceForDay,
      address: address ?? this.address,
      rate: rate ?? this.rate,
      numOfReviews: numOfReviews ?? this.numOfReviews,
      images: images ?? this.images,
      type: type ?? this.type,
      noteDirection: noteDirection ?? this.noteDirection,
    );
  }
}
