// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// class MapPage extends StatefulWidget {
//   final double latitude;
//   final double longitude;

//   MapPage({required this.latitude, required this.longitude});
//   @override
//   _MapPageState createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   late GoogleMapController mapController;
//   TextEditingController searchController = TextEditingController();

//   late LatLng currentLocation =
//       // 31.351879, 75.462716
//       LatLng(
//           widget.latitude, widget.longitude); // Initialize with a default value
//   Set<Marker> markers = Set();

//   List<Marker> _marker = [];
//   final List<Marker> _list = const [
//     Marker(
//         markerId: MarkerId('1'),
//         position: mark,
//         infoWindow: InfoWindow(title: "My Position"))
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _marker.addAll(_list);
//     _getCurrentLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: TextField(
//           controller: searchController,
//           style: TextStyle(color: Colors.black),
//           decoration: InputDecoration(
//             hintText: 'Search for a place',
//             border: InputBorder.none,
//             suffixIcon: IconButton(
//               icon: Icon(
//                 Icons.search,
//                 color: Colors.black,
//               ),
//               onPressed: _searchPlaces,
//             ),
//           ),
//         ),
//         iconTheme: IconThemeData(color: Colors.black),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: GoogleMap(
//               onMapCreated: (controller) {
//                 setState(() {
//                   mapController = controller;
//                 });
//               },
//               initialCameraPosition: CameraPosition(
//                 target: currentLocation,
//                 zoom: 15,
//               ),
//               myLocationEnabled: true,
//               myLocationButtonEnabled: true,
//               onCameraMove: (CameraPosition position) {
//                 // Update current location when the camera moves
//                 currentLocation = position.target;
//               },
//               onTap: (LatLng location) {
//                 _addMarker(location);
//               },
//               markers: Set<Marker>.of(_marker),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 print("location---> of gym register page"
//                     'Latitude: ${currentLocation.latitude}, Longitude: ${currentLocation.longitude}');
//                 _saveLocationAndNavigateBack();
//                 print(currentLocation);
//               },
//               child: Text('Submit'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.black,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(21.0),
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
//                 minimumSize: Size(250, 50),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _getCurrentLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       if (position != null) {
//         setState(() {
//           currentLocation = LatLng(position.latitude, position.longitude);
//           _addMarker(currentLocation);
//         });
//       } else {
//         print('Failed to get current location. Position is null.');
//       }
//     } catch (e) {
//       print('Error getting current location: $e');
//       // Handle the error (show a message, request permissions, etc.)
//     }
//   }

//   void _searchPlaces() async {
//     try {
//       List<Location> locations =
//           await locationFromAddress(searchController.text);

//       if (locations.isNotEmpty && mapController != null) {
//         LatLng selectedLocation =
//             LatLng(locations[0].latitude, locations[0].longitude);
//         _addMarker(selectedLocation);

//         mapController.animateCamera(
//           CameraUpdate.newLatLng(selectedLocation),
//         );
//       }
//     } catch (e) {
//       print('Error searching places: $e');
//       // Handle the error (show a message, log it, etc.)
//     }
//   }

//   void _addMarker(LatLng location) {
//     markers.clear(); // Clear previous markers
//     markers.add(
//       Marker(
//         markerId: MarkerId('selected_location'),
//         position: location,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//       ),
//     );
//   }

//   void _saveLocationAndNavigateBack() {
//     if (currentLocation != null) {
//       // Perform any save logic here (e.g., save currentLocation to a variable)
//       // In this example, we'll print the coordinates

//       // Pass the selected location back to the previous page
//       Navigator.pop(
//         context,
//         currentLocation,
//       );
//     } else {
//       // Handle case where location is not available
//       print('Location not available');
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MapPage extends StatefulWidget {
  final double latitude;
  final double longitude;

  MapPage({required this.latitude, required this.longitude});
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  TextEditingController searchController = TextEditingController();

  late LatLng currentLocation = LatLng(
      widget.latitude, widget.longitude); // Initialize with a default value
  Set<Marker> markers = Set();
  List<Marker> _marker = [];
  final List<Marker> _list = [];

  @override
  void initState() {
    super.initState();
    _list.addAll([
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(widget.latitude, widget.longitude),
        infoWindow: InfoWindow(title: "Target Gym"),
      ),
    ]);
    _marker.addAll(_list);
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: TextField(
          controller: searchController,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Search for a place',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: _searchPlaces,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
              initialCameraPosition: CameraPosition(
                target: currentLocation,
                zoom: 15,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onCameraMove: (CameraPosition position) {
                // Update current location when the camera moves
                currentLocation = position.target;
              },
              onTap: (LatLng location) {
                _addMarker(location);
              },
              markers: Set<Marker>.of(_marker),
            ),
          ),
        ],
      ),
    );
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (position != null) {
        setState(() {
          currentLocation = LatLng(position.latitude, position.longitude);
          _addMarker(currentLocation);
        });
      } else {
        print('Failed to get current location. Position is null.');
      }
    } catch (e) {
      print('Error getting current location: $e');
      // Handle the error (show a message, request permissions, etc.)
    }
  }

  void _searchPlaces() async {
    try {
      List<Location> locations =
          await locationFromAddress(searchController.text);

      if (locations.isNotEmpty && mapController != null) {
        LatLng selectedLocation =
            LatLng(locations[0].latitude, locations[0].longitude);
        _addMarker(selectedLocation);

        mapController.animateCamera(
          CameraUpdate.newLatLng(selectedLocation),
        );
      }
    } catch (e) {
      print('Error searching places: $e');
      // Handle the error (show a message, log it, etc.)
    }
  }

  void _addMarker(LatLng location) {
    markers.clear(); // Clear previous markers
    markers.add(
      Marker(
        markerId: MarkerId('selected_location'),
        position: currentLocation, // Use currentLocation as the marker position
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
  }

  void _saveLocationAndNavigateBack() {
    if (currentLocation != null) {
      // Perform any save logic here (e.g., save currentLocation to a variable)
      // In this example, we'll print the coordinates

      // Pass the selected location back to the previous page
      Navigator.pop(
        context,
        currentLocation,
      );
    } else {
      // Handle case where location is not available
      print('Location not available');
    }
  }
}
