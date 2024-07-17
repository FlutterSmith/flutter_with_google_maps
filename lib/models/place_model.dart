import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel({required this.id, required this.name, required this.latLng});
}

List<PlaceModel> places = [
  PlaceModel(
    id: 1,
    name: 'Place 1',
    latLng: const LatLng(31.513631468276124, 31.84429113585985),
  ),
  PlaceModel(
    id: 2,
    name: 'Place 2',
    latLng: const LatLng(30.820345298178513, 31.00868648882693),
  ),
  PlaceModel(
    id: 3,
    name: 'Sberpay',
    latLng: const LatLng(30.817510559368372, 30.99778503841333),
  ),
  PlaceModel(
    id: 4,
    name: 'Fisha Silim',
    latLng: const LatLng(30.75940819630136, 30.959676213671486),
  ),
];
