// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'dart:async';

// class MapContainer extends StatefulWidget {
//   @override
//   _MapContainerState createState() => _MapContainerState();
// }

// class _MapContainerState extends State<MapContainer> {
//   // define map controller
//   Completer<GoogleMapController> _controller = Completer();

//   // define initial camera position
//   CameraPosition _initialPosition = CameraPosition(
//     target:
//         LatLng(37.42796133580664, -122.085749655962), // set initial location
//     zoom: 14, // set initial zoom level
//   );

//   // define location data
//   late LocationData _currentLocation;

//   // define location service
//   Location _locationService = Location();

//   // request location permission
//   void _requestPermission() {
//     _locationService.requestPermission().then((value) {
//       setState(() {});
//     });
//   }

//   // get user location and update camera position
//   void _getUserLocation() async {
//     try {
//       _currentLocation = await _locationService.getLocation();
//       final GoogleMapController controller = await _controller.future;
//       var currentLocation = _currentLocation;
//       var longitude = _currentLocation.longitude;
//       var latitude = currentLocation.latitude;
//       controller.animateCamera(CameraUpdate.newCameraPosition(
//           CameraPosition(target: LatLng(latitude!, longitude!), zoom: 14)));
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _requestPermission();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 300, // set width of the container
//       height: 200, // set height of the container
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: GoogleMap(
//         initialCameraPosition: _initialPosition,
//         myLocationEnabled: true, // show user's current location
//         myLocationButtonEnabled:
//             true, // enable button to show user's current location
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//     );
//   }
// }
