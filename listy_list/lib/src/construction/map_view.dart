import 'location.dart';
import 'list_view.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:go_router/go_router.dart';

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

    Future<Position> getCurrentLocation() async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
      // });
      mapController.moveCamera(CameraUpdate.newLatLng(currentPosition));
      return position;
    }

    void fetchLocations() async {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:3000/locations'));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.

        Map<String, dynamic> parsedBody = jsonDecode(response.body);
        final locations = (parsedBody["locations"] as List<dynamic>)
            .map((e) => Location.fromJson(e))
            .toList();

        locations.forEach(addMarker);
        setState(() {
          this.locations = locations;
        });
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load locations');
      }
    }

    fetchLocations();
    getCurrentLocation();
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
