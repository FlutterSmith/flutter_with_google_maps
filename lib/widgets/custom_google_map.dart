import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_with_google_maps/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import 'package:location/location.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  String? nightMapStyle;
  late Location location;
  // Set<Marker> markers = {};
  // Set<Polyline> polyLines = {};

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(31.513631468276124, 31.84429113585985),
      zoom: 10,
    );
    // initMarkers();
    // initPolyLines();

    location = Location();
    checkAndRequestLocationService();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  void initMapStyle() async {
    nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/night_map_style.json');

    setState(() {});
  }

  void checkAndRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();

    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        // TODO: show error
      }
    }

    checkAndRequestLocationPermission();
  }

  void checkAndRequestLocationPermission() async {
    var isPermissionGranted = await location.hasPermission();

    if (isPermissionGranted == PermissionStatus.denied) {
      isPermissionGranted = await location.requestPermission();

      if (isPermissionGranted != PermissionStatus.granted) {
        // TODO: show error
      }
    }
  }

  // void initPolyLines() {
  //   Polyline polyline = const Polyline(
  //     polylineId: PolylineId('1'),
  //     color: Colors.blue,
  //     width: 5,
  //     startCap: Cap.roundCap,
  //     endCap: Cap.roundCap,

  //     points: [
  //       LatLng(31.513631468276124, 31.84429113585985),
  //       LatLng(31.50534244845643, 32.71444082458226),
  //     ],
  //   );
  //   polyLines.add(polyline);
  // }

  // Future<Uint8List> getImageFromRawData(String image, double width) async {
  //   var imageData = await rootBundle.load(image);

  //   var imageCodec = await ui.instantiateImageCodec(
  //       imageData.buffer.asUint8List(),
  //       targetWidth: width.round());
  //   var imageFrameInfo = await imageCodec.getNextFrame();

  //   var imageByteData =
  //       await imageFrameInfo.image.toByteData(format: ui.ImageByteFormat.png);

  //   return imageByteData!.buffer.asUint8List();
  // }

  // void initMarkers() async {
  // var custommarkerIcon = BitmapDescriptor.bytes(
  //   await getImageFromRawData('assets/images/icon.jpg', 50),
  // );
  //   var myMarkers = places
  //       .map(
  //         (e) => Marker(
  // icon: custommarkerIcon,
  //           markerId: MarkerId(e.id.toString()),
  //           position: e.latLng,
  //           infoWindow: InfoWindow(title: e.name),
  //         ),
  //       )
  //       .toSet();
  //   markers.addAll(myMarkers);

  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          style: nightMapStyle,
          myLocationEnabled: true,
          onMapCreated: (controller) {
            googleMapController = controller;
            initMapStyle();

            location.onLocationChanged.listen((locationData) {});
          },
          initialCameraPosition: initialCameraPosition,
          // cameraTargetBounds: CameraTargetBounds(
          //   LatLngBounds(
          //     northeast: const LatLng(31.50534244845643, 32.71444082458226),
          //     southwest: const LatLng(30.745923229403292, 30.70394280037733),
          //   ),
          // ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          left: 16,
          child: ElevatedButton(
            onPressed: () {
              CameraPosition newLocation = const CameraPosition(
                target: LatLng(30.820345298178513, 31.00868648882693),
                zoom: 12,
              );
              googleMapController
                  .animateCamera(CameraUpdate.newCameraPosition(newLocation));
            },
            child: const Text('Change location'),
          ),
        ),
      ],
    );
  }
}

//world view 0 -> 3
// country view 4 -> 6
// city view 10 -> 12
// street view 13 -> 17
// building view 18 -> 20



// steps to get location 
// inquire about location service - on/off 
// request location permission
// get current location or  
// get last known location
// get stream of location changes 
// display location on map