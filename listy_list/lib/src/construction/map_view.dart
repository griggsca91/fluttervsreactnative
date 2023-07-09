import 'dart:io';

import 'location.dart';
import 'list_view.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:go_router/go_router.dart';
import './service.dart';

class ConstructionMap extends StatefulWidget {
  const ConstructionMap({super.key});

  @override
  State<StatefulWidget> createState() {
    return ConstructionMapState();
  }
}

class ConstructionMapState extends State<ConstructionMap> {
  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();

    fetchLocations().then((locations) {
      locations.forEach(addMarker);
      setState(() {
        this.locations = locations;
      });
    });

    getCurrentLocation().then((location) {
      currentPosition = LatLng(location.latitude, location.longitude);
      mapController.moveCamera(CameraUpdate.newLatLng(currentPosition));
    });
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LatLng currentPosition = const LatLng(38.8630, -77.3592);
  var locations = <Location>[];

  void addMarker(Location location) {
    MarkerId markerId = MarkerId(location.address);
    Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        location.lat,
        location.long,
      ),
      infoWindow: InfoWindow(title: location.displayName, snippet: '*'),
      // onTap: () => _onMarkerTapped(markerId),
      // onDragEnd: (LatLng position) => _onMarkerDragEnd(markerId, position),
      // onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: <Widget>[
      GoogleMap(
        markers: Set<Marker>.of(markers.values),
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: currentPosition,
          zoom: 11.0,
        ),
      ),
      Positioned(
        bottom: 50.0,
        left: 0,
        right: 0,
        height: 150.0,
        child: ConstructionList(
          constructionSites: locations,
          onItemFocus: (location) => {
            mapController.animateCamera(
                CameraUpdate.newLatLng(LatLng(location.lat, location.long)))
          },
          onItemClick: (location) => context.push("/location"),
        ),
      ),
    ]);
  }
}
