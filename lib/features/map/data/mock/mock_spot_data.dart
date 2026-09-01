import 'dart:math';

final List<String> parkingNames = [
  'Central Parking Garage',
  'Downtown Parking Lot',
  'City Center Car Park',
  'Riverside Parking',
  'Main Street Parking',
  'Plaza Parking Garage',
  'Sunset Parking Lot',
  'Metro Station Parking',
  'Market Square Car Park',
  'Harbor View Parking',
  'North Gate Parking',
  'University Parking Lot',
  'Green Park Garage',
  'Palm Street Parking',
  'Westside Parking Center',
  'Lakeview Parking Deck',
  'Old Town Car Park',
  'Airport Road Parking',
  'Stadium Parking Lot',
  'East End Garage',
  'Bridge Street Parking',
  'Cedar Avenue Car Park',
  'Grand Terminal Parking',
  'Hilltop Parking Garage',
  'Fountain Square Parking',
];

final List<String> directionNotes = [
  'Enter from the main gate and follow the signs to the left.',
  'The entrance is right next to the pharmacy on the corner.',
  'Take the ramp down to level B1 for available spots.',
  'Look for the blue barrier gate near the intersection.',
  'Access is through the side street behind the mall.',
  'The parking entrance is shared with the hotel driveway.',
  'Turn right after the traffic light, entrance is 50 meters ahead.',
  'Use the north entrance; the south side is exit only.',
  'The gate opens automatically once you approach it.',
  'Entrance is narrow, so larger vehicles should use the rear access.',
  'Follow the P sign visible from the main road.',
  'The spot is located behind the building, not visible from the street.',
  'Drive past the security booth and continue straight ahead.',
  'Entrance is shared with a nearby construction site, so expect delays.',
  'Look for the yellow awning marking the parking entrance.',
  'Entrance is on the left side of the building, past the bus stop.',
  'Follow the ramp up to level 2 for open spots.',
  'The gate is manned during the day, automatic at night.',
  'Access via the alley next to the coffee shop.',
  'Watch for the speed bump right before the entrance.',
  'Entrance faces the park, easy to spot from a distance.',
  'Parking is underground, take the ramp just past the lobby.',
  'Look for the red and white striped barrier at the entrance.',
  'Entry is through the service road behind the building.',
  'The ticket booth is right at the entrance, follow the arrows.',
];

final List<String> parkingAddresses = [
  '12 Main Street, Downtown',
  '45 River Road, City Center',
  '8 Market Square',
  '120 Sunset Boulevard',
  '3 Palm Street, North District',
  '77 Harbor View Road',
  '15 University Avenue',
  '200 Green Park Lane',
  '9 Metro Station Road',
  '55 Westside Avenue',
  '21 Plaza Street',
  '6 Main Gate Road',
  '33 Lakeview Drive',
  '19 Old Town Square',
  '88 Airport Road',
  '4 Stadium Way',
  '27 East End Street',
  '61 Bridge Street',
  '14 Cedar Avenue',
  '5 Grand Terminal Plaza',
  '99 Hilltop Road',
  '22 Fountain Square',
];

final List<String> parkingImages = [
  'assets/images/par1.jpg',
  'assets/images/par2.jpg',
  'assets/images/par3.jpg',
  'assets/images/p4.jpg',
  'assets/images/p5.jpg',
  'assets/images/p6.jpg',
  'assets/images/p7.jpg',
  'assets/images/p8.jpg',
  'assets/images/p9.jpg',
  'assets/images/p10.jpg',
  'assets/images/p11.jpg',
  'assets/images/p12.jpg',
  'assets/images/p13.jpg',
];

List<String> parkingReviews = [
  'Very convenient location, close to everything I needed. 👍',
  'Spots were tight but the price was fair. 💰',
  'Easy in and out, no long lines even during rush hour. 🚗💨',
  'A bit hard to find the entrance the first time. 😅',
  'Clean and well-lit, felt safe parking here at night. 🌙✨',
  'Staff was helpful when I couldn\'t find a spot. 🙌',
  'Good value for the price, would park here again. ⭐',
  'Entrance was a bit narrow for larger cars. 😬',
  'Quick access to the mall right next door. 🛍️',
  'Spot was exactly where the app said it would be. ✅',
  'Could use better signage around the area. 🪧',
  'Great spot, right in the middle of downtown. 🏙️',
];
final List<String> openingHoursOptions = [
  'Mo-Su 06:00-23:00',
  'Mo-Fr 07:00-22:00',
  'Mo-Su 08:00-20:00',
  'Mo-Sa 06:00-00:00',
  'Su-Th 08:00-22:00; Fr-Sa 08:00-00:00',
  'Mo-Su 05:00-01:00',
  'Mo-Su 00:00-24:00',
  'Mo-Fr 06:00-21:00',
  'Sa-Su 09:00-23:00',
  'Mo-Su 07:00-19:00',
  'Mo-Th 08:00-22:00; Fr-Sa 08:00-02:00',
  'Mo-Su 06:30-22:30',
  'Mo-Su 09:00-18:00',
  'Mo-Su 10:00-00:00',
  'Mo-Fr 05:00-23:00; Sa-Su 07:00-23:00',
  'Mo-Su closed on public holidays',
];

final List<String> capacityDisabledOptions = ['2', '3', '4', '5', '6'];

final List<String> parkingTypes = [
  'garage',
  'street',
  'lot',
  'multi-storey',
  'underground',
  'rooftop',
  'street_side',
  'carports',
  'garage_boxes',
  'covered',
  'open_air',
];

String getRandomOpeningHours() {
  final random = Random();
  return openingHoursOptions[random.nextInt(openingHoursOptions.length)];
}

String getRandomCapacityDisabled() {
  final random = Random();
  return capacityDisabledOptions[random.nextInt(
    capacityDisabledOptions.length,
  )];
}

String getRandomType() {
  final random = Random();
  return parkingTypes[random.nextInt(parkingTypes.length)];
}

String getRandomParkingName() {
  final random = Random();
  return parkingNames[random.nextInt(parkingNames.length)];
}

String getRandomDirectionNote() {
  final random = Random();
  return directionNotes[random.nextInt(directionNotes.length)];
}

String getRandomAddress() {
  final random = Random();
  return parkingAddresses[random.nextInt(parkingAddresses.length)];
}

List<String> getRandomImages({int count = 3}) {
  final shuffled = List<String>.from(parkingImages)..shuffle();
  return shuffled.take(count).toList();
}
