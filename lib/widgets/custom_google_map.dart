import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  String? nightMapStyle;
  Set<Marker> markers = {};

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(31.513631468276124, 31.84429113585985),
      zoom: 10,
    );
    initMarkers();
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

  void initMarkers() {
    var myMarker = Marker(
      markerId: const MarkerId('1'),
      position: const LatLng(31.513631468276124, 31.84429113585985),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: const InfoWindow(title: 'My Location'),
    );
    markers.add(myMarker);
    markers.add(
      Marker(
        markerId: const MarkerId('2'),
        position: const LatLng(30.820345298178513, 31.00868648882693),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: 'My Location'),
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          markers: markers,
          style: nightMapStyle,
          myLocationEnabled: true,
          onMapCreated: (controller) {
            googleMapController = controller;
            initMapStyle();
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

