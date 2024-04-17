import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:food_rider_app/resources/color_resources.dart';
import 'package:food_rider_app/resources/string_resources.dart';
import 'package:food_rider_app/widgets/custom_widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:progress_dialog/progress_dialog.dart';

class MapBody extends StatefulWidget {
  @override
  _MapBodyState createState() => _MapBodyState();
}

class _MapBodyState extends State<MapBody> {
  Location location = new Location();
  Set<Polygon> _polygons = HashSet<Polygon>();
  List<LatLng> polygonLatLngs = [];
  int _polygonIdCounter = 1;
  late CameraPosition _cameraPosition;
  late GoogleMapController _controller;

  //region check permission function
  Future checkPermission() async {
    // final ProgressDialog pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
        // await pr.hide();
        return;
      }
      else{
        setPolygon();
      }
    }
    else{
      setPolygon();
    }
  }
  //endregion

  //region code to set polygons for map to show the rider riding region on map
  void setPolygon(){
    final String polygonIdVal = 'polygon_id_$_polygonIdCounter';
    polygonLatLngs.add(LatLng(31.471600490522185, 74.27767731249332));
    polygonLatLngs.add(LatLng(31.478339389178036, 74.27618265151978));
    polygonLatLngs.add(LatLng(31.480173651272818, 74.28100023418665));
    polygonLatLngs.add(LatLng(31.478309651819064, 74.28172241896391));
    polygonLatLngs.add(LatLng(31.475359315709156, 74.28056605160236));
    for(int i = 0; i < polygonLatLngs.length; i++){
      _polygons.add(
          Polygon(
            polygonId: PolygonId(polygonIdVal),
            points: polygonLatLngs,
            strokeWidth: 2,
            strokeColor: ColorResources.dodgerBlueColor,
            fillColor: ColorResources.dodgerBlueColor.withOpacity(0.5),
          )
      );
    }
    setState(() {
      _cameraPosition = CameraPosition(target: LatLng(polygonLatLngs[0].latitude, polygonLatLngs[0].longitude),zoom: 15.0);
    });
  }
  //endregion

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return _cameraPosition != null ? Scaffold(
      backgroundColor: ColorResources.whiteColor,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _cameraPosition,
            mapType: MapType.normal,
            polygons: _polygons,
            myLocationEnabled: true,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller){
              _controller=(controller);
              _controller.animateCamera(
                  CameraUpdate.newCameraPosition(_cameraPosition));
            },
          )
        ],
      ),
    ) : Container(
      child: Center(
        child: textBold(StringResources.mapText, TextAlign.center),
      ),
    );
  }
}
