import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  LatLng _initialPosition = LatLng(37.7749, -122.4194); // Default to San Francisco
  LatLng _currentPosition = LatLng(37.7749, -122.4194);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition, 15),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 10,
        ),
        myLocationEnabled: true,
        markers: {
          Marker(
            markerId: MarkerId('currentLocation'),
            position: _currentPosition,
            infoWindow: InfoWindow(title: 'You are here'),
          ),
        },
      ),
    );
  }
}
