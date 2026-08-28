// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class GoogleMapsTutorial extends StatefulWidget {
//   const GoogleMapsTutorial({super.key});

//   @override
//   State<GoogleMapsTutorial> createState() => _GoogleMapsTutorialState();
// }

// class _GoogleMapsTutorialState extends State<GoogleMapsTutorial> {
//   GoogleMapController? _googleMapController;
//   final Set<Marker> _markers = {};

//   LatLng? _currentPosition;
//   Marker? _currentLocationMarker;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     _getCurrentLocation();
//   }

//   void goTo() {
//     _googleMapController!.animateCamera(
//       CameraUpdate.newCameraPosition(
//         const CameraPosition(target: LatLng(31, 30), zoom: 12),
//       ),
//       duration: const Duration(seconds: 2),
//     );
//     _markers.add(
//       Marker(
//         markerId: const MarkerId('1'),
//         position: const LatLng(31, 30),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//         infoWindow: const InfoWindow(title: 'grage'),
//         draggable: true,
//         onDrag: (pos) {
//           print('object');
//           _markers.add(
//             Marker(
//               markerId: const MarkerId('3'),
//               position: const LatLng(31, 30),
//               icon: BitmapDescriptor.defaultMarkerWithHue(
//                 BitmapDescriptor.hueRose,
//               ),
//               infoWindow: const InfoWindow(title: 'there'),
//             ),
//           );
//           setState(() {});
//         },
//       ),
//     );
//     setState(() {});
//   }

//   Future<void> _getCurrentLocation() async {
//     // permission
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }

//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       return;
//     }
//     const LocationSettings locationSettings = LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 100,
//     );
//     // this is contain the current locatin data including lat and long
//     Position position = await Geolocator.getCurrentPosition(
//       locationSettings: locationSettings,
//     );
//     setState(() {
//       _currentPosition = LatLng(position.latitude, position.longitude);
//       _currentLocationMarker = Marker(
//         markerId: const MarkerId('current_location'),
//         position: _currentPosition!,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
//         infoWindow: const InfoWindow(title: 'Current Location'),
//       );
//       _markers.add(_currentLocationMarker!);
//       if (_googleMapController != null) {
//         _googleMapController!.animateCamera(
//           CameraUpdate.newLatLng(_currentPosition!),
//           duration: const Duration(seconds: 2),
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _currentPosition != null
//           ? Column(
//               children: [
//                 Expanded(
//                   child: GoogleMap(
//                     initialCameraPosition: CameraPosition(
//                       target: _currentPosition!,
//                       zoom: 10,
//                     ),
//                     myLocationEnabled: true,
//                     myLocationButtonEnabled: true,
//                     onMapCreated: (controller) =>
//                         _googleMapController = controller,
//                     markers: _markers,
//                   ),
//                 ),
//                 TextButton(onPressed: goTo, child: const Text('Go To')),
//               ],
//             )
//           : const Center(child: CircularProgressIndicator()),
//     );
//   }
// }
