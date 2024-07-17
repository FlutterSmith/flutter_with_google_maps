import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/utils/location_service.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? googleMapController;
  String? nightMapStyle;
  late LocationService locationService;
  bool isFirstCall = true;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(31.513631468276124, 31.84429113585985),
      zoom: 1,
    );

    locationService = LocationService();

    setMyLocation();

    super.initState();
  }

  Set<Marker> markers = {};

  @override
  void dispose() {
    googleMapController!.dispose();
    super.dispose();
  }

  void setMyLocation() async {
    await locationService.checkAndRequestLocationService();
    var hasPermission =
        await locationService.checkAndRequestLocationPermission();
    if (hasPermission) {
      locationService.getRealTimeLocationData((locationData) {
        setLocationMarker(locationData);
        updateMyCamera(locationData);
      });
    } else {
      // TODO: show error
    }
  }

  void updateMyCamera(LocationData locationData) {
    if (isFirstCall) {
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(locationData.latitude!, locationData.longitude!),
        zoom: 17,
      );
      googleMapController
          ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      isFirstCall = false;
    } else {
      googleMapController?.animateCamera(CameraUpdate.newLatLng(
          LatLng(locationData.latitude!, locationData.longitude!)));
    }
  }

  void setLocationMarker(LocationData locationData) {
    var myLocationMarker = Marker(
      markerId: const MarkerId('myLocation'),
      position: LatLng(locationData.latitude!, locationData.longitude!),
    );
    markers.add(myLocationMarker);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: markers,
      zoomControlsEnabled: false,
      onMapCreated: (controller) {
        googleMapController = controller;
      },
      initialCameraPosition: initialCameraPosition,
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

    // void initMapStyle() async {
  //   nightMapStyle = await DefaultAssetBundle.of(context)
  //       .loadString('assets/map_styles/night_map_style.json');

  //   setState(() {});
  // }