import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ptma/feture/google_map/model/plase_model.dart';

List<PlaseModel> marker = [
  PlaseModel(
      id: '1', name: 'كراج جنين الغربي', latLng: LatLng(32.461049, 35.298274)),
  PlaseModel(id: '2', name: 'كراج قباطية', latLng: LatLng(32.411080, 35.282381))
];
//getImageFromRowData () to resize image
Future<Uint8List> getImageFromRowData(String image, double width) async {
  var imageData = await rootBundle.load(image); //loade as row data
  var imageCodec = await ui.instantiateImageCodec(
      imageData.buffer.asUint8List(),
      targetWidth: width.round());
  var imageFrameInfo = await imageCodec.getNextFrame();
  var imageByteData =
      await imageFrameInfo.image.toByteData(format: ui.ImageByteFormat.png);
  return imageByteData!.buffer.asUint8List();
}

//set marker on map
Future<Set<Marker>> initMarkers() async {
  var customMarkerIcone = BitmapDescriptor.fromBytes(
      await getImageFromRowData('assets/images/marker.jpg', 50));
  var myMarker = marker
      .map((plasemodel) => Marker(
          icon: customMarkerIcone,
          markerId: MarkerId(plasemodel.id),
          position: plasemodel.latLng,
          infoWindow: InfoWindow(title: plasemodel.name)))
      .toSet();
  return myMarker;
}
