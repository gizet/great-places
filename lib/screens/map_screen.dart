import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 37.422, longitude: -122.084, address: "Google Plex"),
      this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _picketLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _picketLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude),
            zoom: 16),
        // minMaxZoomPreference: const MinMaxZoomPreference(10, 20),
        // myLocationEnabled: true,
        // zoomControlsEnabled: true,
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: _picketLocation == null
            ? {}
            : {Marker(markerId: const MarkerId('t'), position: _picketLocation!)},
      ),
    );
  }
}
