import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:travel_guide_app/components/constants.dart';

class LocationTrackingPage extends StatefulWidget {
  const LocationTrackingPage({
    Key? key,
    required this.placeName,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  final String placeName;
  final double latitude;
  final double longitude;

  @override
  State<LocationTrackingPage> createState() => _LocationTrackingPageState();
}

class _LocationTrackingPageState extends State<LocationTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();

  late LatLng sourceLocation;
  late LatLng destination;
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    await getCurrentLocation();
    await getPolyPoints();
  }

  Future<void> getCurrentLocation() async {
    Location location = Location();

    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      print('Error getting location: $e');
    }

    if (mounted) {
      // Set the source and destination locations based on the provided latitude and longitude
      sourceLocation =
          LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
      destination = LatLng(widget.latitude, widget.longitude);
      setState(() {});
    }
  }

  Future<void> getPolyPoints() async {
    try {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        google_api_key,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude),
      );

      if (result.points.isNotEmpty) {
        polylineCoordinates.clear();
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      }
    } catch (e) {
      print('Error getting polyline points: $e');
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
      ),
      body: currentLocation == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 13.5,
              ),
              polylines: {
                Polyline(
                  polylineId: const PolylineId("routes"),
                  points: polylineCoordinates,
                  color: primaryColor,
                  width: 6,
                ),
              },
              markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                ),
                Marker(
                  markerId: const MarkerId("source"),
                  position: sourceLocation,
                ),
                Marker(
                  markerId: const MarkerId("destination"),
                  position: destination,
                ),
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
            ),
    );
  }
}
